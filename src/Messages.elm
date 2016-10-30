module Messages exposing (Msg(..))

import Http
import Hero exposing (Hero)


type Msg
    = ShowDashboard
    | ShowHeroes
    | Change String
    | Select Hero
    | FetchFail Http.Error
    | FetchSucceed (List Hero)
