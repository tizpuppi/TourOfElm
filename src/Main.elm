module Main exposing (..)

import Html exposing (Html, body, div, span, h1, h2, ul, li, label, input, text)
import Html.Attributes exposing (placeholder, value, class)
import Html.Events exposing (onInput, onClick)
import Http
import Json.Decode as Json


main : Program Never Model Msg
main =
    Html.program { init = init, view = view, update = update, subscriptions = subscriptions }


type alias AppConfig =
    { title : String }


config : AppConfig
config =
    { title = "Tour of Heroes" }



-- MODEL


type alias Hero =
    { id : Int, name : String }


type alias Model =
    { selectedHeroId : Maybe Int, heroes : List Hero }


initialModel : Model
initialModel =
    { selectedHeroId = Nothing, heroes = [] }


init : ( Model, Cmd Msg )
init =
    initialModel ! [ getHeroes ]



-- UPDATE


type Msg
    = Change String
    | Select Hero
    | FetchedHeroes (Result Http.Error (List Hero))


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

        FetchedHeroes (Err _) ->
            model
                ! [ Cmd.none ]

        FetchedHeroes (Ok heroes) ->
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
        Http.send FetchedHeroes request


decodeUrl : Json.Decoder (List Hero)
decodeUrl =
    let
        heroDecoder =
            Json.map2 Hero (Json.field "id" Json.int) (Json.field "name" Json.string)
    in
        Json.list heroDecoder



-- UTILS


replaceHero : Int -> Hero -> List Hero -> List Hero
replaceHero i h hs =
    case hs of
        [] ->
            hs

        x :: xs ->
            if i == x.id then
                h :: xs
            else
                x :: (replaceHero i h xs)


getHero : Int -> List Hero -> Hero
getHero i heroes =
    case heroes of
        [] ->
            Hero -1 ""

        x :: xs ->
            if x.id == i then
                x
            else
                getHero i xs


isHeroSelected : Maybe Int -> Hero -> Bool
isHeroSelected index h =
    case index of
        Nothing ->
            False

        Just i ->
            if i == h.id then
                True
            else
                False



-- VIEW


showDetail : Model -> Html Msg
showDetail model =
    case model.selectedHeroId of
        Nothing ->
            text ""

        Just i ->
            div []
                [ h2 []
                    [ text ((getHero i model.heroes).name ++ " details!")
                    ]
                , div []
                    [ label [] [ text ("id: " ++ toString i) ]
                    ]
                , div []
                    [ label [] [ text "name: " ]
                    , input
                        [ value (getHero i model.heroes).name
                        , placeholder "name"
                        , onInput Change
                        ]
                        []
                    ]
                ]


showList : Model -> List (Html Msg)
showList model =
    List.map
        (\e ->
            li
                [ onClick (Select e)
                , if isHeroSelected model.selectedHeroId e then
                    (class "selected")
                  else
                    class ""
                ]
                [ span [ class "badge" ] [ text (toString e.id) ], text e.name ]
        )
        model.heroes


view : Model -> Html Msg
view model =
    body []
        [ h1 [] [ text config.title ]
        , h2 [] [ text "My Heroes" ]
        , ul [ class "items" ] (showList model)
        , showDetail model
        ]



--SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
