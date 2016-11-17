module Update exposing (init, update)

import Task
import Json.Decode as Json exposing (map2, field, int, string)
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

        GotoDetail hero ->
            { model | selectedHeroId = Just hero.id }
                ! [ Task.perform ShowDetail (Task.succeed hero.id) ]

        GoBack ->
            model ! [ Navigation.back 1 ]

        FetchedHeroes (Err _) ->
            model
                ! [ Cmd.none ]

        FetchedHeroes (Ok heroes) ->
            { model | heroes = heroes }
                ! [ Cmd.none ]

        UrlChange location ->
            let
                currentRoute =
                    Routing.parse location
            in
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

        request =
            Http.get url decodeHeroes
    in
        Http.send FetchedHeroes request


decodeHeroes : Json.Decoder (List Hero)
decodeHeroes =
    let
        heroDecoder =
            map2 Hero (field "id" int) (field "name" string)
    in
        Json.list heroDecoder


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            Routing.parse location
    in
        case currentRoute of
            Routing.DetailRoute heroid ->
                initialModel currentRoute (Just heroid) ! [ getHeroes ]

            _ ->
                initialModel currentRoute Nothing ! [ getHeroes ]
