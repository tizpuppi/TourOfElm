module Main exposing (main)

import Model exposing (Model)
import Messages exposing (Msg(UrlChange))
import View.MainView exposing (view)
import Update exposing (init, update)
import Navigation


main : Program Never Model Msg
main =
    Navigation.program UrlChange
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }



--SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
