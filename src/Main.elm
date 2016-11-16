module Main exposing (main)

import Html
import Model exposing (Model)
import Messages exposing (Msg)
import MainView exposing (view)
import Update exposing (init, update)


main : Program Never Model Msg
main =
    Html.program { init = init, view = view, update = update, subscriptions = subscriptions }



--SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
