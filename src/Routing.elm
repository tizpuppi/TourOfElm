module Routing exposing (..)

import String
import Navigation
import UrlParser exposing (Parser, oneOf, format, s)


type Route
    = ListRoute
    | DashboardRoute
    | NotFoundRoute


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ format DashboardRoute (s "")
        , format DashboardRoute (s "dashboard")
        , format ListRoute (s "heroes")
        ]


parse : Navigation.Location -> Route
parse { pathname } =
    let
        path =
            if String.startsWith "/" pathname then
                String.dropLeft 1 pathname
            else
                pathname
    in
        case UrlParser.parse identity matchers path of
            Err err ->
                NotFoundRoute

            Ok route ->
                route


parser : Navigation.Parser Route
parser =
    Navigation.makeParser parse
