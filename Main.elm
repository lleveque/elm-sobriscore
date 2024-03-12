port module Main exposing (main, resetScroll)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onCheck, onClick, onInput)
import Html.Keyed
import Json.Decode
import List.Extra
import Round
import Markdown.Parser as Markdown
import Markdown.Renderer
import OrderedSet


port resetScroll : Int -> Cmd msg

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
  , name : String
  , email : String
  , company : String
  , role : String
  , answers : Answers
  , currentScreen : Screen
  , showScores : Bool
  , recordedAnswers : List AnswerRecording
  }

defaultModel =
  { title = "Titre !"
  , subtitle = "Un sous-titre incroyable"
  , intro = "Tous ces textes doivent être définis dans le fichier `data.js`."
  , companyForm = defaultForm
  , climateForm = defaultForm
  , rseForm = defaultForm
  , status = KO "Le moteur de questionnaire est prêt, mais aucune donnée n'a été chargée pour le moment."
  , name = "Jean-Michel Jarre"
  , email = "jean-michel@jarre.com"
  , company = "LaserHarps SARL"
  , role = "Technicien harpe laser"
  , answers = OrderedSet.empty
  , currentScreen = Intro
  , showScores = False
  , recordedAnswers = []
  }

type alias Answers = OrderedSet.OrderedSet String

type Screen = Intro | Step Form (Maybe Int) | CompanyStep Form (Maybe Int) | Results Form

type Status = OK | KO String

type alias Form = { sections : List Section }

defaultForm = { sections = [] }

formDecoder : Json.Decode.Decoder Form
formDecoder = Json.Decode.map Form
  ( Json.Decode.field "sections" ( Json.Decode.list sectionDecoder ) )

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

type QuestionType = Radio | Checkbox | Text | Unknown

questionTypeDecoder : String -> Json.Decode.Decoder QuestionType
questionTypeDecoder qType = case qType of
  "radio" -> Json.Decode.succeed Radio
  "checkbox" -> Json.Decode.succeed Checkbox
  "text" -> Json.Decode.succeed Text
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
      Text -> div ([ class "option" ] ++ ( if isChecked then [ class "checked" ] else [] ))
        [ div [ class "option-input" ] [ input ([ type_ "text", id o.id, name o.id, onInput (UpdateTextField o.id) ] ++ ( if disable then [ disabled True ] else [] )) [] ] ]
      Unknown -> div [] [ renderMarkdown o.text, span [ class "checkup" ] [ text (if detailed then " - " ++ ( String.fromInt o.score ) ++ " points" else "" )] ]

-- INIT

type alias ImportedData =
  { title : String
  , subtitle : String
  , intro : String
  , companyForm : Form
  , climateForm : Form
  , rseForm : Form
  , recordedAnswers : List AnswerRecording
  }

type alias AnswerRecording =
  { name : String
  , company : String
  , role : String
  , answers : Answers }

answerRecordingDecoder : Json.Decode.Decoder AnswerRecording
answerRecordingDecoder = Json.Decode.map4 AnswerRecording
  ( Json.Decode.field "name" Json.Decode.string )
  ( Json.Decode.field "company" Json.Decode.string )
  ( Json.Decode.field "role" Json.Decode.string )
  ( Json.Decode.field "answers" ((Json.Decode.list Json.Decode.string) |> Json.Decode.andThen answersDecoder) )

answersDecoder : List String -> Json.Decode.Decoder Answers
answersDecoder answers = Json.Decode.succeed (OrderedSet.fromList answers)

importedDataDecoder : Json.Decode.Decoder ImportedData
importedDataDecoder = Json.Decode.map7 ImportedData
  ( Json.Decode.field "title" Json.Decode.string )
  ( Json.Decode.field "subtitle" Json.Decode.string )
  ( Json.Decode.field "intro" Json.Decode.string )
  ( Json.Decode.field "companyForm" formDecoder )
  ( Json.Decode.field "climateForm" formDecoder )
  ( Json.Decode.field "rseForm" formDecoder )
  ( Json.Decode.field "recordedAnswers" (Json.Decode.list answerRecordingDecoder) )

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
        , recordedAnswers = data.recordedAnswers
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
  | UpdateTextField String String
  | StartForm Form
  | StepCompany Form Int
  | StepForm Form Int
  | ToggleScores
  | ShowResults AnswerRecording
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

    UpdateTextField field value ->
      case field of
        "name/example" -> ({ model | name = value, answers = ( OrderedSet.insert field model.answers ) }, Cmd.none )
        "company/example" -> ({ model | company = value, answers = ( OrderedSet.insert field model.answers ) }, Cmd.none )
        "email/example" -> ({ model | email = value, answers = ( OrderedSet.insert field model.answers ) }, Cmd.none )
        "otherJob/title" -> ({ model | role = value, answers = ( OrderedSet.insert field model.answers ) }, Cmd.none )
        _ -> ( model, Cmd.none )

    StartForm form ->
      if (hasFinished model.companyForm model.answers)
      then update (StepForm form 0) model
      else update (StepCompany form 0) model
    
    StepCompany form index ->
      if index < 0
      then
        ({ model | currentScreen = Intro }, resetScroll 0 )
      else
        if index < List.length model.companyForm.sections
        then
          ({ model | currentScreen = CompanyStep form ( Just index ) }, resetScroll 0 )
        else
          update ( StartForm form ) model
    
    StepForm form index ->
      if index < 0
      then
        ({ model | currentScreen = Intro }, resetScroll 0 )
      else
        if index < List.length form.sections
        then
          ({ model | currentScreen = Step form ( Just index ) }, resetScroll 0 )
        else
          ({ model | currentScreen = Results form }, resetScroll 0 )

    ToggleScores -> ( { model | showScores = not model.showScores }, Cmd.none )

    ShowResults recording ->
      let
        recordedModel =
          { model
          | name = recording.name
          , company = recording.company
          , role = recording.role
          , email = "anonymous@example.org"
          , answers = recording.answers
          , currentScreen = Results model.climateForm -- TODO adapt to any form
          }
      in
        ( recordedModel, resetScroll 0 )

    
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
          , recordedAnswers = model.recordedAnswers
        }
      , resetScroll 0 )

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
    main_ []
      [ nav []
        ([ img [ src "./sobriscore.svg", onClick ToggleScores, class ( if model.showScores then "checkup" else "" ) ] [] ]
        ++
          if ( hasFinished model.companyForm model.answers )
          then
            [ ul []
              [ p [] [ text (model.name ++ " 👤")]
              , p [] [ text (( getRole model.answers model.role ) ++ " - " ++ model.company ++ " 🏢")]
              , p [] [ text (model.email ++ " 📨")]
              ]
            ]
          else
            []
        )
      , case model.currentScreen of

          Intro ->
            div []
              [ div [] [ renderMarkdown model.intro ]
              , p [ id "start-buttons" ]
                [ button [ onClick ( StartForm model.climateForm ) ] [ text "Commencer le formulaire Climat"]
                , button [ onClick ( StartForm model.rseForm ) ] [ text "Commencer le formulaire RSE"]
                ]
              , h2 [ id "recordings-title"] [ text "Exemples de Sobriscores réalisés"]
              , p [ id "recordings-buttons" ] ( List.map (\recording -> button [ onClick ( ShowResults recording ) ] [ text ( recording.company ++ " (Climat : " ++ ( totalScore model.climateForm recording.answers ) ++ "%)" ) ]) model.recordedAnswers )
              , div [ id "web-credit" ] [ img [ class "logo", src "./logo_ecoco2_transparent.svg" ] [], span [] [ text "Le Sobriscore est un outil développé par Eco CO2,"], span [] [ text "société de conseil et de formation en transition écologique." ]]
              ]

          Step form ( Just section ) -> vSectionWithNumber model.showScores form section model.answers

          Step form Nothing -> div [] [ text "Pas de section sélectionnée" ]

          CompanyStep form ( Just section ) -> vCompanySectionWithNumber model.showScores form model.companyForm section model.answers

          CompanyStep form Nothing -> div [] [ text "Pas de section sélectionnée" ]

          Results form -> div []
            [ div [ class "results" ]
              (
                [ div [ id "brief" ]
                  [ h1 [] [ text ("Votre Sobriscore " ++ (if form == model.climateForm then "Climat" else "RSE")) ]
                  , getScore model.showScores form model.answers
                  ]
                , div [ id "print-credit" ] [ img [ class "logo", src "./logo_ecoco2_transparent.svg" ] [], span [] [ text "Le Sobriscore est un outil développé par Eco CO2,"], span [] [ text "société de conseil et de formation en transition écologique." ]]
                , getOpportunities model.answers
                , getLaws model.answers
                , getFeedback form model.answers ]
              )
            , div [ id "start-buttons" ] ( getResultsCTA model.climateForm model.rseForm model.answers )
            , if model.showScores then ( vAllAnswers model.answers ) else div [] []
            , div [ id "web-credit" ] [ img [ class "logo", src "./logo_ecoco2_transparent.svg" ] [], span [] [ text "Le Sobriscore est un outil développé par Eco CO2,"], span [] [ text "société de conseil et de formation en transition écologique." ]]
            ]
      ]

getRole : Answers -> String -> String
getRole answers otherJob =
  if OrderedSet.member "job/other" answers then otherJob
  else case ( List.filter (String.startsWith "job/") ( OrderedSet.toList answers ) |> List.head ) of
    Just "job/rse" -> "Responsable DD/RSE"
    Just "job/quality" -> "Responsable Qualité/QSE"
    Just "job/corporate" -> "Fonction support"
    Just "job/director" -> "Président/DG"
    _ -> "Poste inconnu"

getOpportunities : Answers -> Html Msg
getOpportunities answers =
  let
    opportunities = case ( List.filter (String.startsWith "sector/") ( OrderedSet.toList answers ) |> List.head ) of
      Just "sector/services" -> [ "Développement de services durables", "Conseil en gestion et adaptation aux risques climatiques", "Demande d'expertises des clients sur ces nouveaux sujets : être en avance de phase" ]
      Just "sector/agriculture" -> [ "Adoption de pratiques agricoles durables et résilientes", "Développement de cultures et de variétés adaptées au climat changeant", "Emergence de nouvelles zones de pêche à mesure que les habitats marins se déplacent", "Promotion de la gestion durable des ressources aquatiques." ]
      Just "sector/food" -> [ "Changements dans la demande alimentaire : les préférences des consommateurs peuvent évoluer en réponse aux changements climatiques:  demande croissante pour des produits alimentaires durables, locaux et faiblement carbonnée", "Innovation alimentaire et technologique : création de nouveaux produits alimentaires adaptés aux préférences des consommateurs conscients de l'impact climatique" ]
      Just "sector/transport" -> [ "Adoption de modes de transport plus durables pour répondre aux exigences environnementales", "Investissements dans des technologies écoénergétiques et des infrastructures résilientes", "Développement de solutions logistiques innovantes pour atténuer les risques climatiques", "Accroissement de la demande pour des services de transport respectueux de l'environnement" ]
      Just "sector/energy" -> [ "Croissance potentielle des énergies renouvelables et des technologies liées", "Possibilité de développer des solutions énergétiques innovantes et durables" ]
      Just "sector/construction" -> [ "Essor de la demande pour des bâtiments durables et écoénergétiques", "Opportunités d'innovation dans les matériaux de construction plus résilients et respectueux de l'environnement et développement de l'économie circulaire", "Développement de technologies de construction vertes", "Augmentation de la demande pour la rénovation énergétique des bâtiments existants." ]
      Just "sector/banking" -> [ "Développement de produits d'assurance innovants pour couvrir les risques climatiques", "Investissements dans des projets durables et résilients", "Création de produits financiers liés à la transition vers une économie bas-carbone", "Renforcement de la gestion des risques climatiques pour assurer la stabilité financière à long terme", "Rôle central dans la décarbonation de la vie économique et des infrastructures" ]
      Just "sector/tourism" -> [ "Croissance de la demande pour des options alimentaires durables et expériences touristiques éco-responsables", "Développement d'infrastructures résilientes face aux changements climatiques", "Adaptation des offres touristiques pour répondre à la sensibilité environnementale des voyageurs", "Possibilité de leadership en matière de durabilité pour renforcer la réputation de la marque" ]
      Just "sector/health" -> [ "Développement de technologies médicales et de pratiques de santé adaptées au changement climatique." ]
      Just "sector/trading" -> [ "Réponse à la demande croissante des consommateurs pour des produits durables", "Adoption de pratiques éco-responsables pour améliorer l'image de marque", "Investissements dans des technologies de chaîne d'approvisionnement verte", "Développement de modèles d'affaires axés sur la circularité et la location pour réduire les déchets et les achats." ]
      Just "sector/chemical" -> [ "Diversification des produits pour répondre à la demande croissante de solutions durables", "R&D sur les solutions plus durables de substitutions pour un marché porteur" ]
      Just "sector/software" -> [ "éveloppement de technologies plus économes en énergie, dont sont demandeuses clients particuliers & professionnels, ainsi que les entités étatiques", "Opportunités pour les technologies de surveillance et d'atténuation des impacts climatiques" ]
      Just "sector/clothing" -> [ "se différencier en adoptant des matériaux durables et recyclables", "Opportunités de développer une offre de mode durable et locale" ]
      Just "sector/manufacture" -> [ "Adoption de pratiques de production plus durables pour répondre à la demande croissante des consommateurs (reformatage)", "Investissements dans des technologies vertes pour réduire l'empreinte carbone", "Développement de produits innovants axés sur la durabilité", "Opportunités de croissance grâce à la fourniture de solutions climatiques et éco-responsables", "Eco-conception des produits permettant une réduciton des coûts de matière première et valorisation de métières issues de l'conomie circulaire (recylcage, upcycling)" ]
      Just "sector/arts" -> [ "Sensibilisation accrue aux enjeux climatiques par le biais de l'art et de la culture." ]
      Just "sector/waste" -> [ "Investissements dans des infrastructures résilientes pour faire face aux changements climatiques,", "Adoption de technologies vertes pour améliorer l'efficacité de la gestion de l'eau et des déchets", "Développement de solutions innovantes pour la récupération des ressources à partir des déchets", "Opportunités de croissance grâce à la demande croissante pour des services de gestion durable de l'eau et des déchets." ]
      _ -> []
    b2bOpportunity = if (OrderedSet.member "bizModel/b2b" answers) then Just "Vos clients cherchent vraisemblablement eux-mêmes à décarboner leur chaîne de valeur et il est très probable que vous soyez interrogé/challengé sur votre démarche." else Nothing
    b2cOpportunity = if (OrderedSet.member "bizModel/b2c" answers) then Just "Les entreprises qui adoptent des mesures et processus plus durable disposent d'un avantage concurrentiel significatif lorsque les organismes de réglementation du secteur adoptent des lois vertes qui obligent les marchés à s'adapter." else Nothing
    -- TODO add b2bOpportunity and b2cOpportunity to other opportunities
    allOpportunities =
      [ "Commerciale : le reporting climat est de plus en plus demander pour répondre à des AO"
      , "Financière : pour accéder à des financements (de la part d'investisseurs, ou dans le cadre de prêts bancaires)"
      ] ++ opportunities
  in
    section []
      [ h1 [] [ text "Pourquoi agir maintenant ?" ]
      , ul [] (List.map (\o -> li [] [ text o ]) allOpportunities)
      , getRisks answers
      ]

getRisks : Answers -> Html Msg
getRisks answers =
  let
    risks = case ( List.filter (String.startsWith "sector/") ( OrderedSet.toList answers ) |> List.head ) of
      Just "sector/services" -> [ "Pressions réglementaires : les gouvernements peuvent renforcer les réglementations environnementales en réponse aux changements climatiques, ce qui peut entraîner des coûts supplémentaires et des obligations de conformité pour les entreprises de services", "Réputation et responsabilité sociale : les entreprises du secteur des services peuvent être soumises à une pression accrue pour adopter des pratiques durables" ]
      Just "sector/agriculture" -> [ "Menaces croissantes pour les rendements agricoles en raison de conditions météorologiques extrêmes et du changement climatique", "Diminution des rendements agricoles du fait de l'erosion de la biodiversité (diminution des polénisateurs, déséquilibre des écosystèmes)", "Augmentation des maladies des cultures et des espèces marines", "Perturbation des saisons de pêche due aux changements dans les températures des océans et des baisse de populations d'éspèces marines" ]
      Just "sector/food" -> [ "Menaces croissantes pour les rendements agricoles en raison de conditions météorologiques extrêmes et du changement climatique", "Changements dans la disponibilité des matières premières", "Pressions sur la gestion de l'eau", "Impact sur les marchés internationaux" ]
      Just "sector/transport" -> [ "Augmentation des coûts opérationnels dus à des événements météorologiques extrêmes perturbant les infrastructures et les itinéraires", "Pressions réglementaires croissantes pour réduire les émissions de gaz à effet de serre", "Vulnérabilité accrue des chaînes d'approvisionnement aux impacts climatiques" ]
      Just "sector/energy" -> [ "Perturbations dans la production d'énergie en raison d'événements climatiques extrêmes", "Diminution de la disponibilité des ressources en énergie (eau, uranium, matériaux pour éoliennes, etc.)", "Pression sur la transition (coûts importants) si pas d'anticipation" ]
      Just "sector/construction" -> [ "Augmentation des coûts de construction en raison de normes renforcées pour la résilience climatique et de la raréfaction des matières premières", "Risques accrus liés à des événements météorologiques extrêmes affectant les chantiers et les infrastructures", "Pression pour l'adaptation des bâtiments aux conditions climatiques changeantes et pour la réduction de leur consommations énergétiques" ]
      Just "sector/banking" -> [ "Augmentation des pertes financières liées aux événements climatiques extrêmes et aux dommages aux biens assurés", "Risques accrus liés aux investissements dans des secteurs vulnérables aux changements climatiques", "Pression réglementaire croissante pour évaluer, reporter et communiquer sur les impacts sur le changement climatique", "Augmentation des risques réputationnels pour les investissements dans des secteurs très impactants (actifs bloqués)" ]
      Just "sector/tourism" -> [ "Vulnérabilité accrue aux phénomènes météorologiques extrêmes impactant les opérations (canicules, feux de forêts, tempêtes, innondations, etc)", "Perturbation des chaînes d'approvisionnement alimentaire et augmentation des coûts", "Menace pour les destinations touristiques en raison des changements climatiques (sports d'hiver) " ]
      Just "sector/health" -> [ "Augmentation des maladies liées au climat, telles que les maladies vectorielles (transmises par les moustiques, etc.)", "Pression sur les systèmes de santé dus à des événements climatiques extrêmes (ex : canicules, hiver rude, catastrophes naturelles)", "Déplacement de populations en raison de la montée du niveau de la mer ou d'événements climatiques" ]
      Just "sector/trading" -> [ "Augmentation des coûts logistiques dus à des conditions météorologiques extrêmes et à des perturbations dans la chaîne d'approvisionnement", "Pression pour réduire l'empreinte carbone des opérations", "Risques de pertes de stocks en raison d'événements climatiques", "Risque réputationnel sur l'impact des produits vendus" ]
      Just "sector/chemical" -> [ "Pression accrue pour réduire l'utilisation de produits chimiques nocifs et dépendance aux combustibles fossiles", "Possibilité de perturbation des chaînes d'approvisionnement en matières premières pétrosourcés" ]
      Just "sector/software" -> [ "Perturbations des infrastructures de communication dues à des événements climatiques extrêmes", "Augmentation de la demande d'énergie pour les alimenter les DATA Centers (4% des émissions de GES mondiales concernent le numérique)" ]
      Just "sector/clothing" -> [ "Perturbations des chaînes d'approvisionnement en coton et en fibres textiles plastiques notamment", "Pression sociétale pour réduire l'empreinte carbone de la production de vêtements (8% des émissions de GES mondiales sont imputables au secteur)" ]
      Just "sector/manufacture" -> [ "Augmentation des coûts liés à l'adaptation aux normes environnementales et aux interruptions de la chaîne d'approvisionnement", "Augmentation des coûts liés aux coûts des énergies et à la raréfction des matières premières", "Vulnérabilité aux événements climatiques extrêmes affectant les installations de production", "Pressions réglementaires et de la chaine de valeur pour réduire les émissions industrielles" ]
      Just "sector/arts" -> [ "Menace et perturbations pour les sites culturels via les conséquences du changement climatique (séismes, élévation niveau de la mer, tornades, etc.)" ]
      Just "sector/waste" -> [ "Augmentation des pressions sur les ressources hydriques en raison de phénomènes climatiques extrêmes", "Risques accrus d'inondations et de déversements de déchets liés aux changements dans les modèles climatiques", "Perturbation des infrastructures de gestion de l'eau" ]
      _ -> []
    b2bRisk = if (OrderedSet.member "bizModel/b2b" answers) then [ "Vos clients et parties prenantes sont de plus en plus exigeants, voire eux-mêmes soumis à la réglementation" ] else []
    b2cRisk = if (OrderedSet.member "bizModel/b2c" answers) then [ "Attentes de consommateurs de plus en plus attentifs à l'impact environnemental des produits qu'ils consomment" ] else []
    allRisks = b2bRisk ++ b2cRisk ++ risks
  in
    div [ id "risks" ]
      [ h1 [] [ text "Les risques si vous n'agissez pas" ]
      , ul [] (List.map (\o -> li [] [ text o ]) allRisks)
      ]

getLaws : Answers -> Html Msg
getLaws answers =
  let
    header = "Grâce à la loi PACTE (Plan d’Action pour la Croissance et la Transformation des Entreprises) l’entreprise doit prendre en considération les enjeux sociaux et environnementaux de son activité. Elle introduite ainsi la notion de Société à mission, et sa \"raison d’être\". Un organe de surveilleance doit vérifier la conformité des décisions de gestion de l'entreprise avec sa mission."
    
    dpefLaw =
      if (OrderedSet.member "dpef/no" answers)
      then [ "Même si vous êtes pour le moment pas concerné par ces réglementations, il est tout de même très probable que vous soyez  interrogé/challengé par votre client sur ce sujet pour poursuivre une collaboration, car ce dernier se doit également de décarboner sa chaîne de valeur" ]
      else if (OrderedSet.member "dpef/unknown" answers)
      then [ "Les PME cotées en bourse et celles qui comptent plus de 250 salariés réalisant plus de 50 M€ et/ou affichent plus de 25 M€ de bilan de CA doivent se mettre en conformité avec la CSRD. Sont également concernées les entreprises non Européennes avec un CA supérieur ou égal à 150 M€ sur le marché de l'UE." ]
      else []
    
    laws = case ( List.filter (String.startsWith "sector/") ( OrderedSet.toList answers ) |> List.head ) of
      Just "sector/services" -> [  ]
      Just "sector/agriculture" -> [ "Plan écophyto", "Stratégie nationale de gestion durable des forêts", "Politiques de transition agroécologique et de pêche durable" ]
      Just "sector/food" -> [ "EGALim" ]
      Just "sector/transport" -> [ "Info GES", "nouvelles normes ISO 14083", "Objectifs de neutralité carbone à 2050 qui implique des actions importantes pour le secteur", "Instauration de ZFE et accès aux villes" ]
      Just "sector/energy" -> [ "Certificats d'économies d'énergie", "Quota CO2", "obligations d'énergies renouvelables nationales" ]
      Just "sector/construction" -> [ "RE2020", "décret tertiaire", "multiplication des certifications environnementales des bâtiments (HQE, BREEAM)", "Plan de rénovation énergétique", "Loi ELAN" ]
      Just "sector/banking" -> [ "Taxonomie européenne des activités durables", "CSRD", "SFRD (article 29 Loi Energie Climat)" ]
      Just "sector/tourism" -> [ "Augmentation des certifiations environnementales (charte Engagé pour la Nature)", "Plan National Toursime Durable (PNTD)", "Gestion des déchats", "Loi relative à la lutte contre le gaspillage et à l'économie circulaire (AGEC)" ]
      Just "sector/health" -> [ "un comité de pilotage de la transition écologique en santé structuré autour de 7 thématiques a été mis en place en mai 2023. Il regroupe les ministères de la santé, de l’autonomie, de la transition écologique et de la cohésion des territoires, de la transformation de la fonction publique, de la caisse nationale d'assurance maladie (CNAM), de la la caisse nationale de solidarité pour l'autonomie (CNSA), de l'agence de l'environnement et de la maîtrise de l'énergie (ADEME), de l'agence nationale de sécurité du médicament et des produits de santé (ANSM) et des agences régionales de santé (ARS) Nouvelle-Aquitaine et Grand-Est au titre des ARS. ", "Décret tertiaire, déchets, BEGES, EGALim, REACH" ]
      Just "sector/trading" -> [ "Loi de Transition Energétique pour la croissance verte", "Loi REP qui impose aux distributeurs de prendre en charge la fin de vie de leurs produits" ]
      Just "sector/chemical" -> [ "REACH", "ICPE" ]
      Just "sector/software" -> [ "Directive sur la conception écologique" ]
      Just "sector/clothing" -> [ "Normes et labels environnementaux" ]
      Just "sector/manufacture" -> [ "Loi de Transition Energétique pour la Croissance Verte (LTECV)", "Système des quotas d'émissions", "certifications ISO (dotn ISO 140001)", "REP pour certains secteurs" ]
      Just "sector/arts" -> [  ]
      Just "sector/waste" -> [ "Directive Cadre sur l'eau", "LEMA", "Loi de Transition Energétique pour la Croissance Verte (LTECV)", "Plan National de Gestion des Matières et des Déchets" ]
      _ -> []
    
    allLaws = dpefLaw ++ laws
  in
    section [ id "laws" ]
      [ h1 [] [ text "Les règlementations qui s'appliquent" ]
      , div [] [ text header ]
      , ul [] (List.map (\o -> li [] [ text o ]) allLaws)
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
    (False, False) ->
      [ button [ onClick ( StartForm climateForm ) ] [ text "Recommencer le formulaire Climat"]
      , button [ onClick ( StartForm rseForm ) ] [ text "Recommencer le formulaire RSE"]
      ]
    _ -> [ button [ onClick Reset ] [ text "Recommencer depuis le début" ] ]

getScore : Bool -> Form -> Answers -> Html Msg
getScore detailed form answers =
  div [ class "digest" ] 
    (
      [ div [ class "sobriscore" ]
        [ h1 [] ([ text ((totalScore form answers) ++ "% ") ] ++ ( if detailed then [ detailedTotalScore form answers ] else [] ))
        , p [] [ renderMarkdown (getScoreComment form answers) ]
        ]
      , div [ class "section-scores" ] ( form.sections |> List.map ( sectionScore detailed answers ) )
      ]
    )

totalScore : Form -> Answers -> String
totalScore form answers =
  let
    userScore = answers |> OrderedSet.toList |> List.filterMap (optionFromId form) |> List.foldl scoreAdder 0
  in
    Round.round 0 (100 * (toFloat userScore) / (toFloat (maxPoints form)))

getScoreComment : Form -> Answers -> String
getScoreComment form answers =
  let
    userScore = answers |> OrderedSet.toList |> List.filterMap (optionFromId form) |> List.foldl scoreAdder 0
    userPercents = (100 * (toFloat userScore) / (toFloat (maxPoints form)))
  in
    if userPercents < 20 then "## C'est un début !\n\nConnaître son avancée dans la transformation écologique est un premier pas important ! Et si vous sensibilisiez vos équipes avec des **ateliers** ?"
    else if userPercents < 40 then "## Bravo, vous connaissez le sujet !\n\nVous avez fait les **premiers pas** vers la transformation durable de votre organisation. Un bilan carbone vous aidera maintenant à agir !"
    else if userPercents < 60 then "## Transition bien démarrée !\n\nVous avez su **réfléchir à l’impact environnemental** de votre structure, et aux risques de l’inaction. Pilotez le changement pour une transition fluide !"
    else if userPercents < 80 then "## Bravo, vous êtes en transition !\n\nVous comprenez votre impact environnemental et les **risques et opportunités de la transition**. Prochaine étape : consolider votre stratégie !"
    else "## Félicitations, c’est exemplaire ! \n\nVotre organisation est **particulièrement mature** sur la transition. Et si vous encouragiez vos partenaires à suivre votre exemple ?"

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
        [ div [ class "section-score" ]
          [ span [ class "section-score-label" ] [ text ( section.name ++ " : ") ]
          , bar userScore
          , span [] [ text  ( userScore ++ "%" ) ]
          , span [ class "checkup" ] [ text ( if detailed then detailedSectionScore else "" ) ]
          ]
        ]
      )

bar : String -> Html Msg
bar score = div [ class "bar-back" ] [ div [ class "bar-front", style "width" (score++"%") ] []]

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
      section [] ( [ h1 [] [ text "Nos conseils" ], p [] [ text "Nous n'avons pas de recommandation particulière." ] ] )
    else
      section []
        (
          [ h1 [] [ text "Nos conseils" ] ]
          ++ ( form.sections |> List.filterMap ( sectionFeedback answers ))
        )

mRender : (a -> Html Msg) -> Maybe a -> Html Msg
mRender render mData = case mData of
  Just data -> render data
  Nothing -> div [] []

sectionFeedback : Answers -> Section -> Maybe ( Html Msg )
sectionFeedback answers section =
  let
    feedbacks = section.questions |> List.filterMap ( questionFeedback answers ) |> List.concatMap identity
  in
    if ( List.isEmpty feedbacks )
    then Nothing
    else Just ( div [] ([ h2 [] [ text section.name ], ul [] feedbacks ] ) )

questionFeedback : Answers -> Question -> Maybe ( List ( Html Msg ) )
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
    else Just feedbacks

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
      [ h1 [] [ text "Vos réponses" ]
      , div [] ( if ( not ( List.isEmpty orderedFormAnswers )) then ( orderedFormAnswers |> List.map ( \a -> div [] [ text a.id ] ) ) else [ text "Aucune réponse donnée" ])
      ]

vAllAnswers : Answers -> Html Msg
vAllAnswers answers =
  section [ id "answers", class "checkup" ]
    [ h1 [] [ text "Vos réponses" ]
    , div [] ( if ( not ( OrderedSet.isEmpty answers )) then ( OrderedSet.toList answers |> List.map ( \a -> div [] [ text a ] )) else [ text "Aucune réponse donnée" ])
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
    relevantQuestions =
      form.sections
      |> List.concatMap .questions
      |> List.filter (shouldBeAnswered answers)
    formQuestionsID =
      relevantQuestions
      |> List.concatMap .options
      |> List.map .id
      |> List.filterMap questionFromOptionID
    answeredQuestionsID =
      answers
      |> OrderedSet.toList
      |> List.filterMap questionFromOptionID
  in
    formQuestionsID |> List.all (\q -> List.member q answeredQuestionsID)

shouldBeAnswered : Answers -> Question -> Bool
shouldBeAnswered answers question =
  case question.showIf of
    Nothing -> True
    Just condition -> if ( OrderedSet.member condition answers ) then True else False

formStatus : Answers -> Form -> Html Msg
formStatus answers form =
  case ( hasStarted form answers, hasFinished form answers ) of
    (False, False) -> text "❎"
    (True, False) -> text "⏺"
    (True, True) -> text "✅"
    (False, True) -> text "⁉"