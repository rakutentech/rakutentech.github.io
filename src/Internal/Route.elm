module Internal.Route exposing
    ( Route(..)
    , conf
    , routeToRestoreFilter
    , toString
    )

import Url.Parser exposing ((</>))


routeToRestoreFilter : String -> Route
routeToRestoreFilter filter =
    if filter == "" then
        Empty

    else
        Filter filter


type Route
    = Empty
    | SelectedLink String
    | SelectedPerson String
    | SelectedKeyword String
    | Filter String


urlLabel :
    { filter : String
    , keyword : String
    , link : String
    , person : String
    }
urlLabel =
    { keyword = "keyword"
    , link = "link"
    , person = "person"
    , filter = "filter"
    }


toString : Route -> String
toString route =
    let
        pieces =
            case route of
                Empty ->
                    []

                SelectedLink id ->
                    [ urlLabel.link, id ]

                SelectedKeyword id ->
                    [ urlLabel.keyword, id ]

                SelectedPerson id ->
                    [ urlLabel.person, id ]

                Filter filter ->
                    [ urlLabel.filter, filter ]
    in
    if pieces == [] then
        ""

    else
        "/" ++ String.join "/" pieces


parser : Url.Parser.Parser (Route -> a) a
parser =
    Url.Parser.oneOf
        [ Url.Parser.map SelectedLink (Url.Parser.s urlLabel.link </> Url.Parser.string)
        , Url.Parser.map SelectedKeyword (Url.Parser.s urlLabel.keyword </> Url.Parser.string)
        , Url.Parser.map SelectedPerson (Url.Parser.s urlLabel.person </> Url.Parser.string)
        , Url.Parser.map Filter (Url.Parser.s urlLabel.filter </> Url.Parser.string)
        ]


conf :
    { disabled : Route
    , parser : Url.Parser.Parser (Route -> a) a
    , toString : Route -> String
    }
conf =
    { parser = parser
    , toString = toString
    , disabled = Empty
    }
