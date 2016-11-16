module Main exposing (..)

import Html exposing (Html, div, h1, h2, label, input, text)
import Html.Attributes exposing (placeholder, value)
import Html.Events exposing (onInput)


main : Program Never Model Msg
main =
    Html.beginnerProgram { model = model, view = view, update = update }


type alias AppConfig =
    { title : String }


config : AppConfig
config =
    { title = "Tour of Heroes" }



-- MODEL


type alias Hero =
    { id : Int, name : String }


type alias Model =
    { hero : Hero }


model : Model
model =
    { hero = { id = 1, name = "Windstorm" } }



-- UPDATE


type Msg
    = Change String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Change newName ->
            let
                oldHero =
                    model.hero

                newHero =
                    { oldHero | name = newName }
            in
                { model | hero = newHero }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text config.title ]
        , h2 [] [ text (model.hero.name ++ " details!") ]
        , div []
            [ label [] [ text ("id: " ++ toString model.hero.id) ]
            ]
        , div []
            [ label [] [ text "name: " ]
            , input [ value model.hero.name, placeholder "name", onInput Change ] []
            ]
        ]
