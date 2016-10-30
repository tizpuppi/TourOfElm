module View.MainView exposing (..)

import Html exposing (Html, Attribute, body, h1, nav, a, text)
import Html.Attributes exposing (href)
import Html.Events exposing (onWithOptions)
import Json.Decode as Json
import AppConfig exposing (config)
import Model exposing (..)
import Messages exposing (Msg(..))


view : Model -> Html Msg
view model =
    body []
        [ h1 [] [ text config.title ]
        , nav []
            [ a (linkAttr ShowDashboard "/dashboard") [ text "Dashboard" ]
            , a (linkAttr ShowHeroes "/heroes") [ text "Heroes" ]
            ]
        , text (toString model.route)
        ]


linkAttr : Msg -> String -> List (Attribute Msg)
linkAttr msg link =
    [ onClick msg
    , href link
    ]


onClick : Msg -> Attribute Msg
onClick msg =
    let
        noBubble =
            { stopPropagation = True, preventDefault = True }
    in
        onWithOptions "click" noBubble (Json.succeed msg)
