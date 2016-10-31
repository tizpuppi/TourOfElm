module View.Detail exposing (..)

import Model exposing (Model)
import Hero exposing (HeroId)
import Messages exposing (Msg(..))
import Utils exposing (getHero)
import Html exposing (Html, div, h2, label, input, button, text)
import Html.Attributes exposing (value, placeholder)
import Html.Events exposing (onInput)


view : Model -> HeroId -> Html Msg
view model heroid =
    case model.selectedHeroId of
        Nothing ->
            div []
                [ h2 []
                    [ text ("Hero " ++ (toString heroid) ++ " is missing!") ]
                ]

        Just heroid ->
            div []
                [ h2 []
                    [ text ((getHero heroid model.heroes).name ++ " details!")
                    ]
                , div []
                    [ label [] [ text ("id: " ++ toString heroid) ]
                    ]
                , div []
                    [ label [] [ text "name: " ]
                    , input
                        [ value (getHero heroid model.heroes).name
                        , placeholder "name"
                        , onInput Change
                        ]
                        []
                    ]
                , button []
                    [ text "Back" ]
                ]
