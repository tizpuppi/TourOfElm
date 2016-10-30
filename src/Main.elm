module Main exposing (main)

import Model exposing (Model)
import Messages exposing (Msg)
import View.MainView exposing (view)
import Update exposing (init, update, urlUpdate)
import Navigation
import Routing


main : Program Never
main =
    Navigation.program Routing.parser
        { init = init
        , view = view
        , update = update
        , urlUpdate = urlUpdate
        , subscriptions = subscriptions
        }



--SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
