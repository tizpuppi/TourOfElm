module Main exposing (main)

import Html.App as App
import Model exposing (Model)
import Messages exposing (Msg)
import MainView exposing (view)
import Update exposing (init, update)


main : Program Never
main =
    App.program { init = init, view = view, update = update, subscriptions = subscriptions }



--SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
