module ReposFilter exposing (filter)

import Element exposing (..)
import Internal.Type as Type


filter : List Type.Repo -> List Type.Repo
filter repos =
    repos
        |> List.filter (\repo -> repo.description /= "")
        |> List.filter (\repo -> not <| String.contains "deprecated" <| String.toLower repo.description)
        |> List.filter (\repo -> not repo.fork)
