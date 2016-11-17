module Routing exposing (..)

import Navigation
import UrlParser exposing (Parser, oneOf, map, s, (</>), int)
import Hero exposing (HeroId)


type Route
    = ListRoute
    | DashboardRoute
    | DetailRoute HeroId
    | NotFoundRoute


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map DashboardRoute (s "")
        , map DashboardRoute (s "dashboard")
        , map ListRoute (s "heroes")
        , map DetailRoute (s "detail" </> int)
        ]


parse : Navigation.Location -> Route
parse location =
    case UrlParser.parsePath matchers location of
        Nothing ->
            NotFoundRoute

        Just route ->
            route
