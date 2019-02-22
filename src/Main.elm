import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)

-- MAIN 
main = 
  Browser.sandbox { init = init, update = update, view = view } 
  
-- MODEL

type alias Model = 
  {
    trix : List String,
    separator : String,
    current : String
  }

init : Model
init = 
  Model ["trix1", "trix2", "trix3", "trix4", "trix5"] "👉" "kiss"

-- UPDATE

type Msg = New

update: Msg -> Model -> Model
update msg model = 
  case msg of
    New -> { model | current = "bajs" }

-- VIEW

view: Model -> Html Msg
view model =
  div []
    [ currentTrick model.current
      , submitButton 
    ]

currentTrick : String -> Html Msg
currentTrick trick = div [] [text trick]

submitButton = div [] [ button [onClick New ] [ text "RIP IT 'N' SNIFF IT"]]