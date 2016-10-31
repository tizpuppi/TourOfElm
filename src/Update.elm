module Update exposing (init, update, urlUpdate)

import Json.Decode as Json exposing ((:=))
import Task
import Http
import Messages exposing (Msg(..))
import Model exposing (Model, initialModel)
import Hero exposing (Hero)
import Utils exposing (getHero, replaceHero)
import Routing
import Navigation


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ShowDashboard ->
            model
                ! [ Navigation.newUrl "/dashboard" ]

        ShowHeroes ->
            model
                ! [ Navigation.newUrl "/heroes" ]

        ShowDetail heroid ->
            model
                ! [ Navigation.newUrl ("/detail/" ++ toString heroid) ]

        Change newName ->
            case model.selectedHeroId of
                Nothing ->
                    model
                        ! [ Cmd.none ]

                Just i ->
                    let
                        h =
                            getHero i model.heroes
                    in
                        { model | heroes = (replaceHero i (Hero h.id newName) model.heroes) }
                            ! [ Cmd.none ]

        Select hero ->
            { model | selectedHeroId = Just hero.id }
                ! [ Cmd.none ]

        FetchFail _ ->
            model
                ! [ Cmd.none ]

        FetchSucceed heroes ->
            { model | heroes = heroes }
                ! [ Cmd.none ]


urlUpdate : Routing.Route -> Model -> ( Model, Cmd Msg )
urlUpdate currentRoute model =
    case currentRoute of
        Routing.DetailRoute heroid ->
            { model | selectedHeroId = Just heroid, route = currentRoute } ! [ Cmd.none ]

        _ ->
            { model | route = currentRoute } ! [ Cmd.none ]


getHeroes : Cmd Msg
getHeroes =
    let
        url =
            "http://localhost:3000/heroes"
    in
        Task.perform FetchFail FetchSucceed (Http.get decodeUrl url)


decodeUrl : Json.Decoder (List Hero)
decodeUrl =
    let
        hero =
            Json.object2 (\id name -> Hero id name)
                ("id" := Json.int)
                ("name" := Json.string)
    in
        Json.list hero


init : Routing.Route -> ( Model, Cmd Msg )
init currentRoute =
    case currentRoute of
        Routing.DetailRoute heroid ->
            initialModel currentRoute (Just heroid) ! [ getHeroes ]

        _ ->
            initialModel currentRoute Nothing ! [ getHeroes ]
