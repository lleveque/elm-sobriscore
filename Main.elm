module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onCheck, onClick)
import Html.Keyed
import Json.Decode
import List.Extra
import Round
import Markdown.Parser as Markdown
import Markdown.Renderer
import OrderedSet

-- MAIN

main = Browser.element { init = init, update = update, view = view, subscriptions = (\_ -> Sub.none) }

-- MODEL

type alias Model =
  { companyForm : Form
  , climateForm : Form
  , rseForm : Form
  , status : Status
  , answers : Answers
  , currentScreen : Screen
  , hasDoneCompany : Bool
  , showScores : Bool
  }

defaultModel =
  { companyForm = []
  , climateForm = []
  , rseForm = []
  , answers = OrderedSet.empty
  , currentScreen = Intro
  , status = KO "Bienvenue sur l'outil Sobriscore !\nLe moteur de questionnaire est prêt, mais aucune n'a été chargée pour le moment."
  , hasDoneCompany = False
  , showScores = False
  }

type alias Answers = OrderedSet.OrderedSet String

type Screen = Intro | Step Form (Maybe Int) | Results Form

type Status = OK | KO String

type alias Form = List Section

formDecoder : Json.Decode.Decoder Form
formDecoder = Json.Decode.list sectionDecoder

type alias Section =
  { name : String
  , questions : List Question
  }

sectionDecoder : Json.Decode.Decoder Section
sectionDecoder = Json.Decode.map2 Section
  ( Json.Decode.field "text" Json.Decode.string )
  ( Json.Decode.field "questions" ( Json.Decode.list questionDecoder ))

vSection : Bool -> Form -> Answers -> Section -> Html Msg
vSection detailed form answers s =
  Html.Keyed.node "div" []
    (( "section-title"
      , div []
        [ h2 []
          [ text s.name
          , span [ class "checkup" ] [ text ( if detailed then ( " - " ++ ( String.fromInt ( maxPointsForSection s )) ++ " points" ) else "" ) ]
          ]
        ]
    ) :: ( List.map ( keyedVQuestion detailed form answers ) s.questions ))

vSectionWithNumber : Bool -> Form -> Int -> Answers -> Html Msg
vSectionWithNumber detailed form sectionNumber answers =
  let
    mSection = List.Extra.getAt sectionNumber form
  in
    case mSection of
      Just section ->
        div []
        [ vSection detailed form answers section
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

keyedVQuestion : Bool -> Form -> Answers -> Question -> (String, Html Msg)
keyedVQuestion detailed form answers q = ( q.text, vQuestion detailed form answers q)

vQuestion : Bool -> Form -> Answers -> Question -> Html Msg
vQuestion detailed form answers q =
  let
    enabled = div [] ([ renderMarkdown q.text , span [ class "checkup" ] [ text ( if detailed then " - " ++ ( String.fromInt ( maxPointsForQuestion q ) ) ++ " points" else "" ) ]] ++ ( List.map ( vOption detailed form answers False q.type_ q.text ) q.options ))
    disabled = div [ class "disabled" ] ([ renderMarkdown q.text, span [ class "checkup" ] [ text ( if detailed then " - " ++ ( String.fromInt ( maxPointsForQuestion q ) ) ++ " points" else "" ) ]] ++ ( List.map ( vOption detailed form answers True q.type_ q.text ) q.options ))
  in
    case q.showIf of
      Nothing -> enabled
      Just master -> if ( OrderedSet.member master answers ) then enabled else disabled

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

vOption : Bool -> Form -> Answers -> Bool -> QuestionType -> String -> Option -> Html Msg
vOption detailed form answers disable qType qName o =
  let
    isChecked = OrderedSet.member o.id answers
    renderOption = \optionType message ->
      div ([ class "option" ] ++ ( if isChecked then [ class "checked" ] else [] ))
        ([ div [ class "option-input" ]
          [ input
            ([ type_ optionType
            , id o.id
            , name qName
            , value o.text
            , onCheck ( message form o.id )
            , checked isChecked
            ] ++ ( if disable then [ disabled True ] else [] ))
            []
          , label [ for o.id ]
            [ renderMarkdown o.text
            , span [ class "checkup" ] [ text (if detailed then " - " ++ ( String.fromInt o.score ) ++ " points" else "" )]
            ]
          ]
        ] ++
          case (detailed, o.feedback) of
            (True, Just feedback) -> [ div [ class "checkup" ] [ renderMarkdown ("→ " ++ feedback) ] ]
            _ -> []
        )
  in
    case qType of
      Radio -> renderOption "radio" Select
      Checkbox -> renderOption "checkbox" Check
      Unknown -> div [] [ renderMarkdown o.text, span [ class "checkup" ] [ text (if detailed then " - " ++ ( String.fromInt o.score ) ++ " points" else "" )] ]

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
  | ToggleScores
  | Reset

removeCascadingAnswers : Form -> Answers -> String -> Answers
removeCascadingAnswers form answers checkedOption =
  let
    cascadingQuestions = form |> List.concatMap .questions |> List.filter doCascade
    removableCascadingQuestions = cascadingQuestions |> List.filter ( parentUnchecked answers )
    removableOptions = removableCascadingQuestions |> List.concatMap .options |> List.map .id
  in
    OrderedSet.filter ( \answer -> not ( List.member answer removableOptions )) answers

doCascade : Question -> Bool
doCascade q = case q.showIf of
  Just _ -> True
  Nothing -> False

parentUnchecked : Answers -> Question -> Bool
parentUnchecked answers q = case q.showIf of
  Just parent -> not ( OrderedSet.member parent answers )
  Nothing -> False

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    
    Check form id checked ->
      let
        updatedAnswers =
          if checked then
            OrderedSet.insert id model.answers
          else
            OrderedSet.remove id model.answers
        answers = removeCascadingAnswers form updatedAnswers id
      in
        ({ model | answers = answers }, Cmd.none )
    
    Select form id _ ->
      let
        cleanedAnswers = OrderedSet.filter (notSameQuestion id) model.answers
        superCleanedAnswers = removeCascadingAnswers form cleanedAnswers id
        answers = OrderedSet.insert id superCleanedAnswers
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

    ToggleScores -> ( { model | showScores = not model.showScores }, Cmd.none )
    
    Reset ->
      ( { defaultModel
          | companyForm = model.companyForm
          , climateForm = model.climateForm
          , rseForm = model.rseForm
          , status = model.status
          , showScores = model.showScores
        }
      , Cmd.none )

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
      [ h1 [ onClick ToggleScores, class ( if model.showScores then "checkup" else "" ) ] [ text "Sobriscore" ]
      , case model.currentScreen of

          Intro ->
            div []
              [ h2 [] [ text "Évaluez votre maturité Climat et RSE" ]
              , div [] [ renderMarkdown "La transition écologique est un enjeu majeur pour les entreprises.\n\nIl peut être difficile de se positionner face à la règlementation et les étapes nécessaires à assurer une transition durable de son entreprise. Si vous vous sentez perdu face à ce défi, alors vous êtes au bon endroit : **évaluez votre Sobriscore** !\n\nEco CO2 a développé l’outil Sobriscore pour mesurer la maturité de votre entreprise sur la question de la sobriété environnementale – en 5 minutes chrono !\n# Pourquoi le Sobriscore ?\nSimple et rapide, le questionnaire met en lumière :\n* Votre **niveau de maturité** sur le changement climatique et votre démarche RSE\n* Des **pistes prioritaires** pour agir en faveur de la transition écologique dans votre structure\n* Les enjeux de l’action pour votre secteur d’activité, sous la forme de **risques et opportunités**\nVotre synthèse Sobriscore est un véritable outil de travail au service de votre politique de sobriété pour accélérer la transition écologique." ]
              , div [] [ button [ onClick ( LoadSection model.companyForm 0 ), class (if model.hasDoneCompany then "disabled" else "") ] [ text "Renseigner les données entreprise"] ]
              , div [] [ button [ onClick ( LoadSection model.climateForm 0 ), class (if model.hasDoneCompany then "" else "disabled") ] [ text "Commencer le formulaire Climat"] ]
              , div [] [ button [ onClick ( LoadSection model.rseForm 0 ), class (if model.hasDoneCompany then "" else "disabled")  ] [ text "Commencer le formulaire RSE"] ]
              ]

          Step form ( Just section ) -> vSectionWithNumber model.showScores form section model.answers

          Step form Nothing -> div [] [ text "Pas de section sélectionnée" ]

          Results form -> div []
            (
              [ getScore model.showScores form model.answers
              , getFeedback form model.answers ]
              ++ if model.showScores then [ vAnswers form model.answers ] else []
              ++ [ button [ onClick Reset ] [ text "Recommencer" ] ]
            )
      ]

getScore : Bool -> Form -> Answers -> Html Msg
getScore detailed form answers =
  div [] 
    (
      [
        h1
          []
          (
            [ text
              ( "Votre Sobriscore est de : " ++ (totalScore form answers) ++ "% " )
            ] ++ ( if detailed then [ detailedTotalScore form answers ] else [] )
          )
      ]
      ++ ( form |> List.map ( sectionScore detailed answers ) )
    )

totalScore : Form -> Answers -> String
totalScore form answers =
  let
    userScore = answers |> OrderedSet.toList |> List.filterMap (optionFromId form) |> List.foldl scoreAdder 0
  in
    Round.round 0 (100 * (toFloat userScore) / (toFloat (maxPoints form)))

detailedTotalScore : Form -> Answers -> Html Msg
detailedTotalScore form answers =
  let
    userScore = answers |> OrderedSet.toList |> List.filterMap (optionFromId form) |> List.foldl scoreAdder 0
  in
    span [ class "checkup" ] [ text ( "(" ++ ( userScore |> String.fromInt ) ++ " points sur " ++ ( maxPoints form |> String.fromInt ) ++ ")" ) ]

maxPoints : Form -> Int
maxPoints form
  = form
  |> List.map maxPointsForSection
  |> List.sum

sectionScore : Bool -> Answers -> Section -> Html Msg
sectionScore detailed answers section =
  let
    userPoints = section.questions |> List.concatMap .options |> List.filter (\o -> OrderedSet.member o.id answers) |> List.map .score |> List.sum
    userScore = Round.round 0 (100 * (toFloat userPoints) / (toFloat (maxPointsForSection section)))
    detailedSectionScore = "(" ++ ( userPoints |> String.fromInt ) ++ " points sur " ++ ( maxPointsForSection section |> String.fromInt ) ++ ")"
  in
    div []
      (
        [ h2 [ style "display" "flex", style "align-items" "center", style "gap" "1em"]
          [ span [ style "width" "500px", style "text-align" "end" ] [ text ( section.name ++ " : ") ]
          , bar userScore
          , span [] [ text  ( userScore ++ "%" ) ]
          , span [ class "checkup" ] [ text ( if detailed then detailedSectionScore else "" ) ]
          ]
        ]
      )

bar : String -> Html Msg
bar score = div [ style "display" "inline-block", style "width" "150px", style "height" "12px", style "background" "lightgrey" ] [ div [ style "background" "#3b91ec", style "height" "100%", style "width" (score++"%") ] []]

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

getFeedback : Form -> Answers -> Html Msg
getFeedback form answers =
  let
    feedback = form |> List.filterMap ( sectionFeedback answers )
  in
    if ( List.isEmpty feedback )
    then
      div [] ( [ h1 [] [ text "Nos conseils" ], p [] [ text "Nous n'avons pas de recommandation particulière." ] ] )
    else
      div [] ( [ h1 [] [ text "Nos conseils" ] ] ++ ( form |> List.filterMap ( sectionFeedback answers )))

sectionFeedback : Answers -> Section -> Maybe ( Html Msg )
sectionFeedback answers section =
  let
    feedbacks = section.questions |> List.filterMap ( questionFeedback answers )
  in
    if ( List.isEmpty feedbacks )
    then Nothing
    else Just ( div [] ([ h2 [] [ text section.name ] ] ++ feedbacks ) )

questionFeedback : Answers -> Question -> Maybe ( Html Msg )
questionFeedback answers question =
  let
    feedbacks
      = question.options
      |> List.filter (\o -> OrderedSet.member o.id answers )
      |> List.filter (\o -> shouldShowFeedback answers o.showFeedbackIf)
      |> List.filterMap .feedback
      |> List.map (\feedback -> li [] [ renderMarkdown feedback ])
  in
    if ( List.isEmpty feedbacks )
    then Nothing
    else Just ( div [] feedbacks )

shouldShowFeedback : Answers -> Maybe String -> Bool
shouldShowFeedback answers mParent = case mParent of
  Nothing -> True
  Just parent -> if OrderedSet.member parent answers then True else False

vAnswers : Form -> Answers -> Html Msg
vAnswers form answers =
  let
    orderedFormAnswers = form |> List.concatMap .questions |> List.concatMap .options |> List.filter (\o -> OrderedSet.member o.id answers)
  in
    div [ class "checkup" ]
      [ h2 [] [ text "Vos réponses" ]
      , div [] ( if ( not ( List.isEmpty orderedFormAnswers )) then ( orderedFormAnswers |> List.map ( \a -> div [] [ text a.id ] ) ) else [ text "Aucune réponse donnée" ])
      ]

renderMarkdown : String -> Html Msg
renderMarkdown s =
      case s
        |> Markdown.parse
        |> Result.mapError (\_ -> "Erreur de décodage du markdown")
        |> Result.andThen (\ast -> Markdown.Renderer.render Markdown.Renderer.defaultHtmlRenderer ast)
      of
        Ok rendered -> div [ style "display" "inline-block" ] rendered
        Err errors -> div [ style "display" "inline-block" ] [ text s ]