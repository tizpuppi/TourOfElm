module View.Detail exposing (..)

import Model exposing (Model)
import Hero exposing (HeroId)
import Messages exposing (Msg(..))
import Utils exposing (getHero)
import Html exposing (Html, div, h2, label, input, button, text)
import Html.Attributes exposing (value, placeholder)
import Html.Events exposing (onInput, onClick)


view : Model -> HeroId -> Html Msg
view model heroid =
    case model.selectedHeroId of
        Nothing ->
            div []
                [ h2 []
                    [ text ("Hero " ++ (toString heroid) ++ " is missing!") ]
                ]

        Just id ->
            div []
                [ h2 []
                    [ text ((getHero id model.heroes).name ++ " details!")
                    ]
                , div []
                    [ label [] [ text ("id: " ++ toString id) ]
                    ]
                , div []
                    [ label [] [ text "name: " ]
                    , input
                        [ value (getHero id model.heroes).name
                        , placeholder "name"
                        , onInput Change
                        ]
                        []
                    ]
                , button [ onClick (GoBack) ]
                    [ text "Back" ]
                ]
