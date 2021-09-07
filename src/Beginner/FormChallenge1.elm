module Application exposing (..)
import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import  Html.Events exposing (onInput)
import String exposing (length, any)
import Char exposing (isDigit, isLower, isUpper)

main =
    Browser.sandbox { init = init, update = update, view = view}

type alias Model =
    {
    name : String,
    password : String,
    password_again : String
    }

init : Model
init = Model "" "" ""


type Msg
    = Name String
    | Password String
    | PasswordAgain String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Name name ->
            {model | name = name}
        Password password ->
            {model | password = password}
        PasswordAgain passwordAgain ->
            {model | password_again = passwordAgain}


view : Model -> Html Msg
view model =
    div []
    [ viewInput "text" "Name" model.name Name
    , viewInput "password" "Password" model.password Password
    , viewInput  "password" "Re-enter Password" model.password_again PasswordAgain
    , viewValidation model
    ]

viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
    input [type_ t, placeholder p, value v, onInput toMsg] []


viewValidation : Model -> Html msg
viewValidation model =
    if validPassword model  then
        div [style "color" "green"] [text "Ok"]
    else
        div [style "color" "red"] [text "passwords do not match or is less then 8 character and must contain a upper case and lower case character.!"]



validPassword : Model -> Bool
validPassword model =
    model.password == model.password_again && length model.password >= 8 && any isDigit model.password && any isUpper model.password && any isLower model.password