module ViewRepo exposing (view)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Internal.Icon as Icon
import Internal.Model as Model
import Internal.Type as Type
import Internal.Utils as Utils



{-
   ██████  ███████ ██████   ██████
   ██   ██ ██      ██   ██ ██    ██
   ██████  █████   ██████  ██    ██
   ██   ██ ██      ██      ██    ██
   ██   ██ ███████ ██       ██████
-}


labelAttrs : Model.Model -> List (Attribute msg)
labelAttrs model =
    [ padding 6
    , Border.rounded 5
    , Font.size 13
    , Background.color <| Utils.c model .labelBackground
    ]


view : Model.Model -> Int -> Type.Repo -> Element msg
view model _ repo =
    column
        [ spacing 20
        , height fill
        , width fill
        , Border.widthEach { top = 4, right = 0, bottom = 0, left = 0 }
        , Border.color <| Utils.c model .crimson
        , padding 30
        ]
        [ paragraph
            [ Font.bold
            , Font.size 24
            ]
            [ if repo.logo == "" then
                none

              else
                el
                    [ alignLeft
                    , padding 4
                    , Background.color <| rgb255 200 0 0
                    ]
                <|
                    image
                        [ height <| px 24 ]
                        { src = repo.logo, description = "Logo" }
            , text <| repo.name
            ]
        , paragraph [ Font.size 16, spacing 8 ] [ text <| repo.description ]
        , row
            [ alignBottom
            , spacing 5
            , width fill
            ]
            [ wrappedRow [ width fill, spacing 10, moveDown 6 ]
                [ case Utils.urlToLabel repo.html_url of
                    Just label ->
                        el (labelAttrs model) <| text label

                    Nothing ->
                        none
                , if repo.language == "" then
                    none

                  else
                    el (labelAttrs model) <| text <| repo.language
                ]
            , row [ alignRight, alignBottom, spacing 10 ]
                [ if repo.stargazers_count > 0 then
                    row [ spacing 8, alignRight ]
                        [ el [] <| Icon.icon Icon.Star (Utils.c model .font) 13
                        , text <| String.fromInt repo.stargazers_count
                        ]

                  else
                    none
                , if repo.forks_count > 0 then
                    row [ spacing 8, alignRight ]
                        [ el [] <| Icon.icon Icon.Fork (Utils.c model .font) 13
                        , text <| String.fromInt repo.forks_count
                        ]

                  else
                    none

                -- Number of watchers is wrong https://github.com/milo/github-api/issues/19
                ]
            ]
        ]
