module Model exposing (Model, initialModel)

import Routing
import Hero exposing (Hero, HeroId)


type alias Model =
    { selectedHeroId : Maybe Int, heroes : List Hero, route : Routing.Route }


initialModel : Routing.Route -> Maybe HeroId -> Model
initialModel route heroid =
    { selectedHeroId = heroid, heroes = [], route = route }
