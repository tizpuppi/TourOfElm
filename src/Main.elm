module Main exposing (main)

import Html.App as App
import Model exposing (Model, initialModel)
import Messages exposing (Msg)
import MainView exposing (view)
import Update exposing (update, getHeroes)


main : Program Never
main =
    App.program { init = init, view = view, update = update, subscriptions = subscriptions }


init : ( Model, Cmd Msg )
init =
    initialModel ! [ getHeroes ]



--SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
