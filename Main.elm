module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onCheck)
import Json.Decode
import Set

-- MAIN

main = Browser.element { init = init, update = update, view = view, subscriptions = (\_ -> Sub.none) }

-- MODEL

type alias Model =
  {
    climateForm : Form,
    status : Status,
    checkedItems : Set.Set String
  }

type Status = OK | KO String

type alias Form = List Section

formDecoder : Json.Decode.Decoder Form
formDecoder = Json.Decode.list sectionDecoder

vForm : Form -> Set.Set String -> Html Msg
vForm f checkedItems = div [] ( List.map ( vSection checkedItems ) f )

type alias Section =
  {
    name : String,
    questions : List Question
  }

sectionDecoder : Json.Decode.Decoder Section
sectionDecoder = Json.Decode.map2 Section
  ( Json.Decode.field "text" Json.Decode.string )
  ( Json.Decode.field "questions" ( Json.Decode.list questionDecoder ))

vSection : Set.Set String -> Section -> Html Msg
vSection checkedItems s = div [] ([ div [] [ h2 [] [ text s.name ]]] ++ ( List.map ( vQuestion checkedItems ) s.questions ))

type alias Question =
  {
    type_ : QuestionType,
    text : String,
    options : List Option,
    showIf : Maybe String
  }

questionDecoder : Json.Decode.Decoder Question
questionDecoder = Json.Decode.map4 Question
  ( Json.Decode.field "type" Json.Decode.string |> Json.Decode.andThen questionTypeDecoder)
  ( Json.Decode.field "text" Json.Decode.string )
  ( Json.Decode.field "options" ( Json.Decode.list optionDecoder ))
  ( Json.Decode.maybe ( Json.Decode.field "showIf" Json.Decode.string ))

vQuestion : Set.Set String -> Question -> Html Msg
vQuestion checkedItems q =
  let
    enabled = div [] ([ div [] [ text q.text ]] ++ ( List.map ( vOption False q.type_ q.text ) q.options ))
    disabled = div [ style "color" "#aaa" ] ([ div [] [ text q.text ]] ++ ( List.map ( vOption True q.type_ q.text ) q.options ))
  in
    case q.showIf of
      Nothing -> enabled
      Just master -> if ( Set.member master checkedItems ) then enabled else disabled

type QuestionType = Radio | Checkbox | Unknown

questionTypeDecoder : String -> Json.Decode.Decoder QuestionType
questionTypeDecoder qType = case qType of
  "radio" -> Json.Decode.succeed Radio
  "checkbox" -> Json.Decode.succeed Checkbox
  _ -> Json.Decode.succeed Unknown

type alias Option =
  {
    id : String,
    text : String,
    score : Int,
    feedback : Maybe String
  }

optionDecoder : Json.Decode.Decoder Option
optionDecoder = Json.Decode.map4 Option
  ( Json.Decode.field "id" Json.Decode.string )
  ( Json.Decode.field "text" Json.Decode.string )
  ( Json.Decode.field "score" Json.Decode.int )
  ( Json.Decode.maybe ( Json.Decode.field "feedback" Json.Decode.string ))

vOption : Bool -> QuestionType -> String -> Option -> Html Msg
vOption disable qType qName o =
  case qType of
    Radio -> div []
      [ input
        ([ type_ "radio"
        , id o.id
        , name qName
        , value o.text
        , onCheck ( Select o.id )
        ] ++ ( if disable then [ disabled True ] else [] ))
        []
      , label [ for o.id ] [ text o.text ]
      ]
    Checkbox -> div []
      [ input
        ([ type_ "checkbox"
        , id o.id
        , name qName
        , value o.text
        , onCheck ( Check o.id )
        ] ++ ( if disable then [ disabled True ] else [] ))
        []
      , label [ for o.id ] [ text o.text ]
      ]
    Unknown -> div [] [ text o.text ]

-- INIT

flagDecoder : Json.Decode.Decoder Form
flagDecoder = Json.Decode.field "climateForm" formDecoder

init: Json.Decode.Value -> (Model, Cmd Msg)
init flags =
  case Json.Decode.decodeValue flagDecoder flags of

    Ok form -> 
      ( { climateForm = form, checkedItems = Set.empty, status = OK }, Cmd.none )

    Err e ->
      ( { climateForm = [], checkedItems = Set.empty, status = KO (Json.Decode.errorToString e) }, Cmd.none )

-- UPDATE

type Msg
  = Check String Bool
  | Select String Bool

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Check id checked ->
      let
        checkedItems =
          if checked then
            Set.insert id model.checkedItems
          else
            Set.remove id model.checkedItems
      in
        ({ model | checkedItems = checkedItems }, Cmd.none )
    Select id _ ->
      let
        cleanedCheckedItems = Set.filter (notSameQuestion id) model.checkedItems
        checkedItems = Set.insert id cleanedCheckedItems
      in
        ({ model | checkedItems = checkedItems }, Cmd.none )

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
      [ h1 [] [ text "Sobriscore Climat" ]
      , vForm model.climateForm model.checkedItems
      , h1 [] [ text ( "Votre Sobriscore Climat est de : " ++ String.fromInt (score model.climateForm model.checkedItems) )]
      , getFeedback model.climateForm model.checkedItems
      ]

score : Form -> Set.Set String -> Int
score form answers = answers |> Set.toList |> List.map (optionFromId form) |> List.foldl scoreAdder 0

scoreAdder : Maybe Option -> Int -> Int
scoreAdder mOption total = case mOption of
  Just option -> total + option.score
  Nothing -> total

optionFromId : Form -> String -> Maybe Option
optionFromId form id
  = form
  |> List.concatMap .questions
  |> List.concatMap .options
  |> List.filter (\option -> option.id == id)
  |> List.head

getFeedback : Form -> Set.Set String -> Html Msg
getFeedback form answers = ul [] ( answers |> Set.toList |> List.map (optionFromId form) |> List.foldl feedbackAdder [] )

feedbackAdder : Maybe Option -> List ( Html Msg ) -> List ( Html Msg )
feedbackAdder mOption allFeedback =
  case mOption of
    Just option ->
      case option.feedback of
        Just feedback -> List.append allFeedback [ li [] [ text feedback ] ]
        Nothing -> allFeedback
    Nothing -> allFeedback