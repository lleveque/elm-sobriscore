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
  { title : String
  , subtitle : String
  , intro : String
  , companyForm : Form
  , climateForm : Form
  , rseForm : Form
  , status : Status
  , answers : Answers
  , currentScreen : Screen
  , showScores : Bool
  }

defaultModel =
  { title = "Titre !"
  , subtitle = "Un sous-titre incroyable"
  , intro = "Tous ces textes doivent être définis dans le fichier `data.js`."
  , companyForm = defaultForm
  , climateForm = defaultForm
  , rseForm = defaultForm
  , answers = OrderedSet.empty
  , currentScreen = Intro
  , status = KO "Le moteur de questionnaire est prêt, mais aucune donnée n'a été chargée pour le moment."
  , showScores = False
  }

type alias Answers = OrderedSet.OrderedSet String

type Screen = Intro | Step Form (Maybe Int) | CompanyStep Form (Maybe Int) | Results Form

type Status = OK | KO String

type alias Form =
  { sections : List Section
  , commonOpportunities : Maybe String
  }

defaultForm = { sections = [], commonOpportunities = Nothing }

formDecoder : Json.Decode.Decoder Form
formDecoder = Json.Decode.map2 Form
  ( Json.Decode.field "sections" ( Json.Decode.list sectionDecoder ) )
  ( Json.Decode.maybe ( Json.Decode.field "commonOpportunities" Json.Decode.string ) )

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

vCompanySectionWithNumber : Bool -> Form -> Form -> Int -> Answers -> Html Msg
vCompanySectionWithNumber detailed nextForm form sectionNumber answers =
  let
    mSection = List.Extra.getAt sectionNumber form.sections
  in
    case mSection of
      Just section ->
        div []
        [ vSection detailed form answers section
        , div [ class "buttons"]
          [ button [ onClick ( StepCompany nextForm ( sectionNumber - 1 ) ) ] [ text "Précédent"]
          , button [ onClick ( StepCompany nextForm ( sectionNumber + 1 ) ) ] [ text "Suivant"]
          ]
        ]
      Nothing -> div [] [ text "Trop loin !" ]

vSectionWithNumber : Bool -> Form -> Int -> Answers -> Html Msg
vSectionWithNumber detailed form sectionNumber answers =
  let
    mSection = List.Extra.getAt sectionNumber form.sections
  in
    case mSection of
      Just section ->
        div []
        [ vSection detailed form answers section
        , div [ class "buttons"]
          [ button [ onClick ( StepForm form ( sectionNumber - 1 ) ) ] [ text "Précédent"]
          , button [ onClick ( StepForm form ( sectionNumber + 1 ) ) ] [ text "Suivant"]
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

type alias ImportedData =
  { title : String
  , subtitle : String
  , intro : String
  , companyForm : Form
  , climateForm : Form
  , rseForm : Form
  }

importedDataDecoder : Json.Decode.Decoder ImportedData
importedDataDecoder = Json.Decode.map6 ImportedData
  ( Json.Decode.field "title" Json.Decode.string )
  ( Json.Decode.field "subtitle" Json.Decode.string )
  ( Json.Decode.field "intro" Json.Decode.string )
  ( Json.Decode.field "companyForm" formDecoder )
  ( Json.Decode.field "climateForm" formDecoder )
  ( Json.Decode.field "rseForm" formDecoder )

init: Json.Decode.Value -> (Model, Cmd Msg)
init flags =
  case Json.Decode.decodeValue importedDataDecoder flags of

    Ok data -> 
      ( { defaultModel
        | title = data.title
        , subtitle = data.subtitle
        , intro = data.intro
        , companyForm = data.companyForm
        , climateForm = data.climateForm
        , rseForm = data.rseForm
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
  | StartForm Form
  | StepCompany Form Int
  | StepForm Form Int
  | ToggleScores
  | Reset

removeCascadingAnswers : Form -> Answers -> String -> Answers
removeCascadingAnswers form answers checkedOption =
  let
    cascadingQuestions = form.sections |> List.concatMap .questions |> List.filter doCascade
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

    StartForm form ->
      if (hasFinished model.companyForm model.answers)
      then update (StepForm form 0) model
      else update (StepCompany form 0) model
    
    StepCompany form index ->
      if index < 0
      then
        ({ model | currentScreen = Intro }, Cmd.none )
      else
        if index < List.length model.companyForm.sections
        then
          ({ model | currentScreen = CompanyStep form ( Just index ) }, Cmd.none )
        else
          update ( StartForm form ) model
    
    StepForm form index ->
      if index < 0
      then
        ({ model | currentScreen = Intro }, Cmd.none )
      else
        if index < List.length form.sections
        then
          ({ model | currentScreen = Step form ( Just index ) }, Cmd.none )
        else
          ({ model | currentScreen = Results form }, Cmd.none )

    ToggleScores -> ( { model | showScores = not model.showScores }, Cmd.none )
    
    Reset ->
      ( { defaultModel
          | title = model.title
          , subtitle = model.subtitle
          , intro = model.intro
          , companyForm = model.companyForm
          , climateForm = model.climateForm
          , rseForm = model.rseForm
          , status = model.status
          , showScores = model.showScores
        }
      , Cmd.none )

notSameQuestion: String -> String -> Bool
notSameQuestion option1 option2 =
  case questionFromOptionID option1 of
    Just question -> not <| String.startsWith question option2
    Nothing -> True

questionFromOptionID: String -> Maybe String
questionFromOptionID oid = String.split "/" oid |> List.head

-- VIEW

view : Model -> Html Msg
view model = case model.status of
  KO error -> article [] [ aside [ style "display" "block" ] [ div [] [ h1 [] [ text "Error" ] ], p [] [ text error ]] ]
  OK ->
    div []
      [ h1 [ onClick ToggleScores, class ( if model.showScores then "checkup" else "" ) ] [ text model.title ]
      , div [] ( List.map ( formStatus model.answers ) [ model.companyForm, model.climateForm, model.rseForm ] )
      , case model.currentScreen of

          Intro ->
            div []
              [ h2 [] [ text model.subtitle ]
              , div [] [ renderMarkdown model.intro ]
              , div [] [ button [ onClick ( StartForm model.climateForm ) ] [ text "Commencer le formulaire Climat"] ]
              , div [] [ button [ onClick ( StartForm model.rseForm ) ] [ text "Commencer le formulaire RSE"] ]
              ]

          Step form ( Just section ) -> vSectionWithNumber model.showScores form section model.answers

          Step form Nothing -> div [] [ text "Pas de section sélectionnée" ]

          CompanyStep form ( Just section ) -> vCompanySectionWithNumber model.showScores form model.companyForm section model.answers

          CompanyStep form Nothing -> div [] [ text "Pas de section sélectionnée" ]

          Results form -> div []
            (
              [ getScore model.showScores form model.answers
              , getFeedback form model.answers ]
              ++ if model.showScores then [ vAnswers form model.answers ] else []
              ++ getResultsCTA model.climateForm model.rseForm model.answers
            )
      ]

getResultsCTA : Form -> Form -> Answers -> List (Html Msg)
getResultsCTA climateForm rseForm answers =
  case (hasFinished climateForm answers, hasFinished rseForm answers) of
    (True, False) ->
      [ button [ onClick Reset ] [ text "Recommencer depuis le début" ]
      , button [ onClick ( StartForm rseForm ) ] [ text "Continuer avec le formulaire RSE" ]
      ]
    (False, True) ->
      [ button [ onClick Reset ] [ text "Recommencer depuis le début" ]
      , button [ onClick ( StartForm climateForm ) ] [ text "Continuer avec le formulaire Climat" ]
      ]
    _ -> [ button [ onClick Reset ] [ text "Recommencer depuis le début" ] ]

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
      ++ ( form.sections |> List.map ( sectionScore detailed answers ) )
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
  = form.sections
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
  = form.sections
  |> List.concatMap .questions
  |> List.concatMap .options
  |> List.filter (\option -> option.id == id)
  |> List.head

getFeedback : Form -> Answers -> Html Msg
getFeedback form answers =
  let
    feedback = form.sections |> List.filterMap ( sectionFeedback answers )
  in
    if ( List.isEmpty feedback )
    then
      div [] ( [ h1 [] [ text "Nos conseils" ], p [] [ text "Nous n'avons pas de recommandation particulière." ] ] )
    else
      div []
        (
          [ mRender renderMarkdown form.commonOpportunities
          , h1 [] [ text "Nos conseils" ]
          ]
          ++ ( form.sections |> List.filterMap ( sectionFeedback answers ))
        )

mRender : (a -> Html Msg) -> Maybe a -> Html Msg
mRender render mData = case mData of
  Just data -> render data
  Nothing -> div [] []

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
      |> List.map (\feedback -> div [] [ renderMarkdown ( "- " ++ feedback ) ])
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
    orderedFormAnswers = form.sections |> List.concatMap .questions |> List.concatMap .options |> List.filter (\o -> OrderedSet.member o.id answers)
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

hasStarted : Form -> Answers -> Bool
hasStarted form answers =
  form.sections
  |> List.concatMap .questions
  |> List.concatMap .options
  |> List.filter ( isInAnswers answers )
  |> List.isEmpty
  |> not

isInAnswers : Answers -> Option -> Bool
isInAnswers answers option = OrderedSet.member option.id answers

hasFinished : Form -> Answers -> Bool
hasFinished form answers =
  let
    formQuestionsID =
      form.sections
      |> List.concatMap .questions
      |> List.concatMap .options
      |> List.map .id
      |> List.filterMap questionFromOptionID
    answeredQuestionsID =
      answers
      |> OrderedSet.toList
      |> List.filterMap questionFromOptionID
  in
    formQuestionsID |> List.all (\q -> List.member q answeredQuestionsID)

formStatus : Answers -> Form -> Html Msg
formStatus answers form =
  case ( hasStarted form answers, hasFinished form answers ) of
    (False, False) -> text "❎"
    (True, False) -> text "⏺"
    (True, True) -> text "✅"
    (False, True) -> text "⁉"