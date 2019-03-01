import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import Random exposing (Generator)
import Random.Extra exposing (sample)
import Array exposing (..)
import String

-- MAIN 
main =
  Browser.element
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }

-- MODEL

type alias Model = 
  {
    trix : List String,
    current : String
  }

init : List String -> (Model, Cmd Msg)
init trix = 
  (Model trix ""
  , Random.generate NewTrix (lineGenerator trix))

-- UPDATE

type Msg = New 
  | NewTrix String


update: Msg -> Model -> (Model, Cmd Msg)
update msg model = 
  case msg of
    New -> ( model, Random.generate NewTrix (lineGenerator model.trix)) 
    NewTrix trix ->  
      ({model | current = trix}, Cmd.none)

lineGenerator : List String -> Generator String
lineGenerator list = 
  Random.int 3 5
   |> Random.andThen (\len -> listToString (Random.list len (randomTrickGenerator list)))

listToString : Generator (List String) -> Generator String
listToString list = Random.map (\l -> String.join " 👉 " l) list

randomTrickGenerator : List String -> Random.Generator String
randomTrickGenerator array = 
  Random.Extra.sample array
  |> Random.map (Maybe.withDefault("FEL"))

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

-- VIEW

view: Model -> Html Msg
view model =
  div [class "mainContent", class "content"]
    [ currentTrick model.current
      , submitButton 
    ]

currentTrick :  String -> Html Msg
currentTrick trick = h2 [] [text trick]

submitButton = div [] [ button [id "trix", onClick New ] [ text "RIP IT 'N' SNIFF IT 👏"]]