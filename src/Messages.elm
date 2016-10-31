module Messages exposing (Msg(..))

import Http
import Hero exposing (Hero, HeroId)


type Msg
    = ShowDashboard
    | ShowHeroes
    | ShowDetail HeroId
    | Change String
    | Select Hero
    | FetchFail Http.Error
    | FetchSucceed (List Hero)
