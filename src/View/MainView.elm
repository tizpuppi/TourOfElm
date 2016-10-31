module View.MainView exposing (..)

import Html exposing (Html, Attribute, body, div, h1, nav, a, text)
import Html.Attributes exposing (href)
import Html.Events exposing (onWithOptions)
import Json.Decode as Json
import AppConfig exposing (config)
import Model exposing (..)
import Messages exposing (Msg(..))
import Routing
import View.HeroList
import View.Dashboard
import View.Detail


view : Model -> Html Msg
view model =
    body []
        [ h1 [] [ text config.title ]
        , nav []
            [ a (linkAttr ShowDashboard "/dashboard") [ text "Dashboard" ]
            , a (linkAttr ShowHeroes "/heroes") [ text "Heroes" ]
            ]
        , page model
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


page : Model -> Html Msg
page model =
    case model.route of
        Routing.ListRoute ->
            View.HeroList.view model

        Routing.DashboardRoute ->
            View.Dashboard.view model

        Routing.DetailRoute heroid ->
            View.Detail.view model heroid

        Routing.NotFoundRoute ->
            div [] [ text "Not Found" ]
