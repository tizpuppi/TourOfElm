module Utils exposing (replaceHero, getHero, isHeroSelected)

import Model exposing (Model)
import Hero exposing (Hero)


replaceHero : Int -> Hero -> List Hero -> List Hero
replaceHero i h hs =
    case hs of
        [] ->
            hs

        x :: xs ->
            if i == x.id then
                h :: xs
            else
                x :: (replaceHero i h xs)


getHero : Int -> List Hero -> Hero
getHero i heroes =
    case heroes of
        [] ->
            Hero -1 ""

        x :: xs ->
            if x.id == i then
                x
            else
                getHero i xs


isHeroSelected : Maybe Int -> Hero -> Bool
isHeroSelected index h =
    case index of
        Nothing ->
            False

        Just i ->
            if i == h.id then
                True
            else
                False
