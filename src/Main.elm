import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import Random exposing (Generator)
import Random.Extra exposing (sample)
import Array exposing (..)

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
    separator : String,
    current : String
  }

trixList = ["trix1", "trix2", "trix3", "trix4", "trix5"]


init : () -> (Model, Cmd Msg)
init _ = 
  (Model trixList "👉" "kiss"
  , Random.generate NewTrix (randomTrickGenerator trixList))

-- UPDATE

type Msg = New 
  | NewTrix String


update: Msg -> Model -> (Model, Cmd Msg)
update msg model = 
  case msg of
    New -> ( model, Random.generate NewTrix (randomTrickGenerator model.trix)) 
    NewTrix trix ->  
      ({model | current = trix}, Cmd.none)

randomTrickGenerator : List String -> Random.Generator String
randomTrickGenerator array = 
  Random.Extra.sample array
  |> Random.map (Maybe.withDefault("FEL"))


randomNum : Int -> Int -> Random.Generator Int
randomNum min max = Random.int min max


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

-- VIEW

view: Model -> Html Msg
view model =
  div []
    [ currentTrick model.current
      , submitButton 
    ]

currentTrick :  String -> Html Msg
currentTrick trick = div [] [text trick]

submitButton = div [] [ button [onClick New ] [ text "RIP IT 'N' SNIFF IT"]]