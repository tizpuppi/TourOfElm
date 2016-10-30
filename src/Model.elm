module Model exposing (Hero, Model, initialModel)


type alias Hero =
    { id : Int, name : String }


type alias Model =
    { selectedHeroId : Maybe Int, heroes : List Hero }


initialModel : Model
initialModel =
    { selectedHeroId = Nothing, heroes = [] }
