module View.HeroList exposing (view)

import Html exposing (Html, body, div, span, h1, h2, ul, li, label, input, text)
import Html.Attributes exposing (placeholder, value, class)
import Html.Events exposing (onInput, onClick)
import Messages exposing (Msg(..))
import Model exposing (Model)
import Utils exposing (getHero, isHeroSelected)
import AppConfig exposing (config)


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
