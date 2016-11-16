module Update exposing (init, update)

import Json.Decode as Json exposing (map2, field, int, string)
import Task
import Http
import Messages exposing (Msg(..))
import Model exposing (Model, Hero, initialModel)
import Utils exposing (getHero, replaceHero)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
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

        LoadHeroes (Err _) ->
            model
                ! [ Cmd.none ]

        LoadHeroes (Ok heroes) ->
            { model | heroes = heroes }
                ! [ Cmd.none ]


getHeroes : Cmd Msg
getHeroes =
    let
        url =
            "http://localhost:3000/heroes"

        request =
            Http.get url decodeUrl
    in
        Http.send LoadHeroes request


decodeUrl : Json.Decoder (List Hero)
decodeUrl =
    let
        heroDecoder =
            map2 Hero (field "id" int) (field "name" string)
    in
        Json.list heroDecoder


init : ( Model, Cmd Msg )
init =
    initialModel ! [ getHeroes ]
