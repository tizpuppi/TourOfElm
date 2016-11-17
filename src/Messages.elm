module Messages exposing (Msg(..))

import Http
import Hero exposing (Hero, HeroId)
import Navigation


type Msg
    = ShowDashboard
    | ShowHeroes
    | ShowDetail HeroId
    | Change String
    | Select Hero
    | GotoDetail Hero
    | GoBack
    | FetchedHeroes (Result Http.Error (List Hero))
    | UrlChange Navigation.Location
