module Messages exposing (Msg(..))

import Http
import Model exposing (Hero)


type Msg
    = Change String
    | Select Hero
    | FetchFail Http.Error
    | FetchSucceed (List Hero)
