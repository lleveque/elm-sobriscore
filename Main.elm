module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onCheck, onClick)
import Html.Keyed
import Json.Decode
import Set
import List.Extra
import Round
import Markdown.Parser as Markdown
import Markdown.Renderer

-- MAIN

main = Browser.element { init = init, update = update, view = view, subscriptions = (\_ -> Sub.none) }

-- MODEL

type alias Model =
  { companyForm : Form
  , climateForm : Form
  , rseForm : Form
  , status : Status
  , answers : Set.Set String
  , currentScreen : Screen
  , hasDoneCompany : Bool
  }

defaultModel =
  { companyForm = []
  , climateForm = []
  , rseForm = []
  , answers = Set.empty
  , currentScreen = Intro
  , status = KO "Bienvenue sur l'outil Sobriscore !\nLe moteur de questionnaire est prêt, mais aucune n'a été chargée pour le moment."
  , hasDoneCompany = False
  }

type Screen = Intro | Step Form (Maybe Int) | Results Form

type Status = OK | KO String

type alias Form = List Section

formDecoder : Json.Decode.Decoder Form
formDecoder = Json.Decode.list sectionDecoder

vForm : Form -> Set.Set String -> Html Msg
vForm form answers = div [] ( List.map ( vSection form answers ) form )

type alias Section =
  { name : String
  , questions : List Question
  }

sectionDecoder : Json.Decode.Decoder Section
sectionDecoder = Json.Decode.map2 Section
  ( Json.Decode.field "text" Json.Decode.string )
  ( Json.Decode.field "questions" ( Json.Decode.list questionDecoder ))

vSection : Form -> Set.Set String -> Section -> Html Msg
vSection form answers s = Html.Keyed.node "div" []
  (( "section-title", div [] [ h2 [] [ text s.name ]] )
  :: ( List.map ( keyedVQuestion form answers ) s.questions )
  )

vSectionWithNumber : Form -> Int -> Set.Set String -> Html Msg
vSectionWithNumber form sectionNumber answers =
  let
    mSection = List.Extra.getAt sectionNumber form
  in
    case mSection of
      Just section ->
        div []
        [ vSection form answers section
        , div [ class "buttons"]
          [ button [ onClick ( LoadSection form ( sectionNumber - 1 ) ) ] [ text "Précédent"]
          , button [ onClick ( LoadSection form ( sectionNumber + 1 ) ) ] [ text "Suivant"]
          ]
        ]
      Nothing -> div [] [ text "Trop loin !" ]

type alias Question =
  { type_ : QuestionType
  , text : String
  , options : List Option
  , showIf : Maybe String
  }

questionDecoder : Json.Decode.Decoder Question
questionDecoder = Json.Decode.map4 Question
  ( Json.Decode.field "type" Json.Decode.string |> Json.Decode.andThen questionTypeDecoder)
  ( Json.Decode.field "text" Json.Decode.string )
  ( Json.Decode.field "options" ( Json.Decode.list optionDecoder ))
  ( Json.Decode.maybe ( Json.Decode.field "showIf" Json.Decode.string ))

keyedVQuestion : Form -> Set.Set String -> Question -> (String, Html Msg)
keyedVQuestion form answers q = ( q.text, vQuestion form answers q)

vQuestion : Form -> Set.Set String -> Question -> Html Msg
vQuestion form answers q =
  let
    enabled = div [] ([ renderMarkdown q.text ] ++ ( List.map ( vOption form answers False q.type_ q.text ) q.options ))
    disabled = div [ class "disabled" ] ([ renderMarkdown q.text ] ++ ( List.map ( vOption form answers True q.type_ q.text ) q.options ))
  in
    case q.showIf of
      Nothing -> enabled
      Just master -> if ( Set.member master answers ) then enabled else disabled

type QuestionType = Radio | Checkbox | Unknown

questionTypeDecoder : String -> Json.Decode.Decoder QuestionType
questionTypeDecoder qType = case qType of
  "radio" -> Json.Decode.succeed Radio
  "checkbox" -> Json.Decode.succeed Checkbox
  _ -> Json.Decode.succeed Unknown

type alias Option =
  { id : String
  , text : String
  , score : Int
  , feedback : Maybe String
  , showFeedbackIf : Maybe String
  }

optionDecoder : Json.Decode.Decoder Option
optionDecoder = Json.Decode.map5 Option
  ( Json.Decode.field "id" Json.Decode.string )
  ( Json.Decode.field "text" Json.Decode.string )
  ( Json.Decode.field "score" Json.Decode.int )
  ( Json.Decode.maybe ( Json.Decode.field "feedback" Json.Decode.string ))
  ( Json.Decode.maybe ( Json.Decode.field "showFeedbackIf" Json.Decode.string ))

vOption : Form -> Set.Set String -> Bool -> QuestionType -> String -> Option -> Html Msg
vOption form answers disable qType qName o =
  let
    isChecked = Set.member o.id answers
  in
    case qType of
      Radio -> div ([ class "option" ] ++ ( if isChecked then [ class "checked" ] else [] ))
        [ input
          ([ type_ "radio"
          , id o.id
          , name qName
          , value o.text
          , onCheck ( Select form o.id )
          , checked isChecked
          ] ++ ( if disable then [ disabled True ] else [] ))
          []
        , label [ for o.id ] [ renderMarkdown o.text ]
        ]
      Checkbox -> div ([ class "option" ] ++ ( if isChecked then [ class "checked" ] else [] ))
        [ input
          ([ type_ "checkbox"
          , id o.id
          , name qName
          , value o.text
          , onCheck ( Check form o.id )
          , checked isChecked
          ] ++ ( if disable then [ disabled True ] else [] ))
          []
        , label [ for o.id ] [ renderMarkdown o.text ]
        ]
      Unknown -> div [] [ renderMarkdown o.text ]

-- INIT

type alias AllForms =
  { companyForm : Form
  , climateForm : Form
  , rseForm : Form
  }

formsDecoder : Json.Decode.Decoder AllForms
formsDecoder = Json.Decode.map3 AllForms
  ( Json.Decode.field "companyForm" formDecoder )
  ( Json.Decode.field "climateForm" formDecoder )
  ( Json.Decode.field "rseForm" formDecoder )

init: Json.Decode.Value -> (Model, Cmd Msg)
init flags =
  case Json.Decode.decodeValue formsDecoder flags of

    Ok forms -> 
      ( { defaultModel
        | companyForm = forms.companyForm
        , climateForm = forms.climateForm
        , rseForm = forms.rseForm
        , status = OK
        }
      , Cmd.none )

    Err e ->
      ( { defaultModel
        | status = KO (Json.Decode.errorToString e)
        }
      , Cmd.none )

-- UPDATE

type Msg
  = Check Form String Bool
  | Select Form String Bool
  | LoadSection Form Int
  | Reset

removeCascadingAnswers : Form -> Set.Set String -> String -> Set.Set String
removeCascadingAnswers form answers checkedOption =
  let
    cascadingQuestions = form |> List.concatMap .questions |> List.filter doCascade
    removableCascadingQuestions = cascadingQuestions |> List.filter ( parentUnchecked answers )
    removableOptions = removableCascadingQuestions |> List.concatMap .options |> List.map .id
  in
    Set.filter ( \answer -> not ( List.member answer removableOptions )) answers

doCascade : Question -> Bool
doCascade q = case q.showIf of
  Just _ -> True
  Nothing -> False

parentUnchecked : Set.Set String -> Question -> Bool
parentUnchecked answers q = case q.showIf of
  Just parent -> not ( Set.member parent answers )
  Nothing -> False

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    
    Check form id checked ->
      let
        updatedAnswers =
          if checked then
            Set.insert id model.answers
          else
            Set.remove id model.answers
        answers = removeCascadingAnswers form updatedAnswers id
      in
        ({ model | answers = answers }, Cmd.none )
    
    Select form id _ ->
      let
        cleanedAnswers = Set.filter (notSameQuestion id) model.answers
        superCleanedAnswers = removeCascadingAnswers form cleanedAnswers id
        answers = Set.insert id superCleanedAnswers
      in
        ({ model | answers = answers }, Cmd.none )
    
    LoadSection form index ->
      let
        ( nextScreen, hasDoneCompany ) =
          if index < 0
          then
            ( Intro, model.hasDoneCompany )
          else
            if index >= List.length form
            then
              if form == model.companyForm
              then ( Intro, True )
              else ( Results form, model.hasDoneCompany )
            else
              ( Step form ( Just index ), model.hasDoneCompany )
      in ({ model | currentScreen = nextScreen, hasDoneCompany = hasDoneCompany }, Cmd.none )
    
    Reset -> ({ defaultModel | companyForm = model.companyForm, climateForm = model.climateForm, rseForm = model.rseForm, status = model.status }, Cmd.none )

notSameQuestion: String -> String -> Bool
notSameQuestion option1 option2 =
  case questionFromOption option1 of
    Just question -> not <| String.startsWith question option2
    Nothing -> True

questionFromOption: String -> Maybe String
questionFromOption oid = String.split "/" oid |> List.head

-- VIEW

view : Model -> Html Msg
view model = case model.status of
  KO error -> article [] [ aside [ style "display" "block" ] [ div [] [ h1 [] [ text "Error" ] ], p [] [ text error ]] ]
  OK ->
    div []
      [ h1 [] [ text "Sobriscore" ]
      , case model.currentScreen of

          Intro ->
            div []
              [ div [] [ text "Bienvenue dans l'outil Sobriscore !" ]
              , div [] [ button [ onClick ( LoadSection model.companyForm 0 ), class (if model.hasDoneCompany then "disabled" else "") ] [ text "Renseigner les données entreprise"] ]
              , div [] [ button [ onClick ( LoadSection model.climateForm 0 ), class (if model.hasDoneCompany then "" else "disabled") ] [ text "Commencer le formulaire Climat"] ]
              , div [] [ button [ onClick ( LoadSection model.rseForm 0 ), class (if model.hasDoneCompany then "" else "disabled")  ] [ text "Commencer le formulaire RSE"] ]
              ]

          Step form ( Just section ) -> vSectionWithNumber form section model.answers

          Step form Nothing -> div [] [ text "Pas de section sélectionnée" ]

          Results form -> div []
            [ getScore form model.answers
            , getFeedback form model.answers
            , button [ onClick Reset ] [ text "Recommencer" ]
            ]
      ]

getScore : Form -> Set.Set String -> Html Msg
getScore form answers =
  div [] 
    ([ h1 [] [ text ( "Votre Sobriscore est de : " ++ (totalScore form answers) ++ "%" )] ]
        ++ ( form |> List.map ( sectionScore answers ) ))

totalScore : Form -> Set.Set String -> String
totalScore form answers =
  let
    userScore = answers |> Set.toList |> List.filterMap (optionFromId form) |> List.foldl scoreAdder 0
  in
    Round.round 0 (100 * (toFloat userScore) / (toFloat (maxPoints form)))

maxPoints : Form -> Int
maxPoints form
  = form
  |> List.map maxPointsForSection
  |> List.sum

sectionScore : Set.Set String -> Section -> Html Msg
sectionScore answers section =
  let
    userPoints = section.questions |> List.concatMap .options |> List.filter (\o -> Set.member o.id answers) |> List.map .score |> List.sum
    userScore = Round.round 0 (100 * (toFloat userPoints) / (toFloat (maxPointsForSection section)))
  in
    h2 [] [ text ( section.name ++ " : " ++ userScore ++ "%" ), bar userScore ]

bar : String -> Html Msg
bar score = div [ style "width" "150px", style "height" "12px", style "background" "lightgrey" ] [ div [ style "background" "#3b91ec", style "height" "100%", style "width" (score++"%") ] []]

maxPointsForSection : Section -> Int
maxPointsForSection section = section.questions |> List.map maxPointsForQuestion |> List.sum

maxPointsForQuestion : Question -> Int
maxPointsForQuestion question =
  case question.type_ of
    Radio -> question.options |> List.map .score |> List.maximum |> ( Maybe.withDefault 0 )
    Checkbox -> question.options |> List.map .score |> List.sum
    _ -> 0

scoreAdder : Option -> Int -> Int
scoreAdder option total = total + option.score

optionFromId : Form -> String -> Maybe Option
optionFromId form id
  = form
  |> List.concatMap .questions
  |> List.concatMap .options
  |> List.filter (\option -> option.id == id)
  |> List.head

getFeedback : Form -> Set.Set String -> Html Msg
getFeedback form answers =
  let
    feedback = form |> List.filterMap ( sectionFeedback answers )
  in
    if ( List.isEmpty feedback )
    then
      div [] ( [ h1 [] [ text "Nos conseils" ], p [] [ text "Nous n'avons pas de recommandation particulière." ] ] )
    else
      div [] ( [ h1 [] [ text "Nos conseils" ] ] ++ ( form |> List.filterMap ( sectionFeedback answers )))

sectionFeedback : Set.Set String -> Section -> Maybe ( Html Msg )
sectionFeedback answers section =
  let
    feedbacks = section.questions |> List.filterMap ( questionFeedback answers )
  in
    if ( List.isEmpty feedbacks )
    then Nothing
    else Just ( div [] ([ h2 [] [ text section.name ] ] ++ feedbacks ) )

questionFeedback : Set.Set String -> Question -> Maybe ( Html Msg )
questionFeedback answers question =
  let
    feedbacks
      = question.options
      |> List.filter (\o -> Set.member o.id answers )
      |> List.filter (\o -> shouldShowFeedback answers o.showFeedbackIf)
      |> List.filterMap .feedback
      |> List.map (\feedback -> li [] [ renderMarkdown feedback ])
  in
    if ( List.isEmpty feedbacks )
    then Nothing
    else Just ( div [] feedbacks )

shouldShowFeedback : Set.Set String -> Maybe String -> Bool
shouldShowFeedback answers mParent = case mParent of
  Nothing -> True
  Just parent -> if Set.member parent answers then True else False

renderMarkdown : String -> Html Msg
renderMarkdown s =
      case s
        |> Markdown.parse
        |> Result.mapError (\_ -> "Erreur de décodage du markdown")
        |> Result.andThen (\ast -> Markdown.Renderer.render Markdown.Renderer.defaultHtmlRenderer ast)
      of
        Ok rendered -> div [] rendered
        Err errors -> div [] [ text s ]