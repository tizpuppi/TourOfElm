module View.Dashboard exposing (..)

import Model exposing (Model)
import Messages exposing (Msg(..))
import Hero exposing (Hero)
import Html exposing (Html, div, h3, h4, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)


view : Model -> Html Msg
view model =
    div []
        [ h3 []
            [ text "Top Heroes" ]
        , div
            [ class "grid grid-pad" ]
            (viewHeroList <| List.take 4 <| Maybe.withDefault [] <| List.tail model.heroes)
        ]


viewHeroList : List Hero -> List (Html Msg)
viewHeroList list =
    List.map
        (\e ->
            div
                [ class "col-1-4", onClick (GotoDetail e) ]
                [ div [ class "module hero" ] [ h4 [] [ text e.name ] ] ]
        )
        list
