module Hero exposing (Hero, HeroId)


type alias Hero =
    { id : HeroId, name : String }


type alias HeroId =
    Int
