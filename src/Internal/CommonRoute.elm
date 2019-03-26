module Internal.CommonRoute exposing
    ( fromUrl
    , toStringAndHash
    , urlToMaybeRoute
    )

import Url
import Url.Parser


toStringAndHash : { b | toString : a -> String } -> a -> String
toStringAndHash conf route =
    let
        string =
            conf.toString route
    in
    "#" ++ string



-- INTERNAL


fromUrl :
    { a | disabled : b, parser : Url.Parser.Parser (b -> b) b }
    -> Url.Url
    -> b
fromUrl conf url =
    Maybe.withDefault conf.disabled <| urlToMaybeRoute conf url


urlToMaybeRoute :
    { b | parser : Url.Parser.Parser (a -> a) a }
    -> Url.Url
    -> Maybe a
urlToMaybeRoute conf url =
    -- We copy the fragment in to the path first because the parser only works
    -- on the path
    Url.Parser.parse conf.parser { url | path = Maybe.withDefault "" url.fragment }
