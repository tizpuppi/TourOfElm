module Main exposing (..)

import Html exposing (Html, body, div, span, h1, h2, ul, li, label, input, text)
import Html.Attributes exposing (placeholder, value, class)
import Html.Events exposing (onInput, onClick)
import Html.App as App
import Maybe exposing (withDefault)


main : Program Never
main =
    App.beginnerProgram { model = model, view = view, update = update }


type alias AppConfig =
    { title : String }


config : AppConfig
config =
    { title = "Tour of Heroes" }



-- MODEL


type alias Hero =
    { id : Int, name : String }


heroes : List Hero
heroes =
    [ Hero 11 "Mr. Nice"
    , Hero 12 "Narco"
    , Hero 13 "Bombasto"
    , Hero 14 "Celeritas"
    , Hero 15 "Magneta"
    , Hero 16 "RubberMan"
    , Hero 17 "Dynama"
    , Hero 18 "Dr IQ"
    , Hero 19 "Magma"
    , Hero 20 "Tornado"
    ]


type alias Model =
    { selectedHeroId : Maybe Int, heroes : List Hero }


model : Model
model =
    { selectedHeroId = Nothing, heroes = heroes }



-- UPDATE


type Msg
    = Change String
    | Select Hero


update : Msg -> Model -> Model
update msg model =
    case msg of
        Change newName ->
            case model.selectedHeroId of
                Nothing ->
                    model

                Just i ->
                    let
                        h =
                            getHero (Just i) model.heroes
                    in
                        { model | heroes = (replaceHero i (Hero h.id newName) model.heroes) }

        Select hero ->
            { model | selectedHeroId = Just hero.id }



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


getHero : Maybe Int -> List Hero -> Hero
getHero i heroes =
    case i of
        Nothing ->
            Hero -1 ""

        Just i ->
            case heroes of
                [] ->
                    Hero -1 ""

                x :: xs ->
                    if x.id == i then
                        x
                    else
                        getHero (Just i) xs


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


view : Model -> Html Msg
view model =
    body []
        [ h1 [] [ text config.title ]
        , h2 [] [ text "My Heroes" ]
        , ul [ class "items" ]
            (List.map
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
            )
        , (if model.selectedHeroId /= Nothing then
            div []
                [ h2 []
                    [ text ((getHero model.selectedHeroId model.heroes).name ++ " details!")
                    ]
                , div []
                    [ label [] [ text ("id: " ++ toString (withDefault -1 model.selectedHeroId)) ]
                    ]
                , div []
                    [ label [] [ text "name: " ]
                    , input
                        [ value (getHero model.selectedHeroId model.heroes).name
                        , placeholder "name"
                        , onInput Change
                        ]
                        []
                    ]
                ]
           else
            text ""
          )
        ]
