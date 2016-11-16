module Messages exposing (Msg(..))

import Http
import Model exposing (Hero)


type Msg
    = Change String
    | Select Hero
    | LoadHeroes (Result Http.Error (List Hero))
