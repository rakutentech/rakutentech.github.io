module Internal.View exposing (view)

import Browser
import Conf
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html
import Html.Attributes
import Internal.Icon as Icon
import Internal.Model as Model
import Internal.Msg as Msg
import Internal.Search as Search
import Internal.Type as Type
import Internal.Utils as Utils
import ViewBody
import ViewFooter
import ViewHeader
import ViewRepo



{-
   ██    ██ ██ ███████ ██     ██
   ██    ██ ██ ██      ██     ██
   ██    ██ ██ █████   ██  █  ██
    ██  ██  ██ ██      ██ ███ ██
     ████   ██ ███████  ███ ███
-}


attrsRepoCard : Model.Model -> List (Attribute msg)
attrsRepoCard model =
    [ width fill
    , height fill
    , alignTop
    , Border.rounded 5
    , Background.color <| Utils.c model .cardBackground
    , clip
    , Border.shadow { offset = ( 0, 2 ), size = 0, blur = 8, color = rgba 0 0 0 0.05 }
    , mouseOver <|
        if model.localStorage.nightMode then
            [ Border.shadow { offset = ( 0, 12 ), size = 0, blur = 30, color = rgba 0 0 0 0.8 } ]

        else
            [ Border.shadow { offset = ( 0, 12 ), size = 0, blur = 30, color = rgba 0 0 0 0.2 } ]
    , htmlAttribute <| Html.Attributes.style "transition-property" "box-shadow,transform"
    , htmlAttribute <| Html.Attributes.style "transition-duration" "600ms"
    , htmlAttribute <| Html.Attributes.style "transition-timing-function" "cubic-bezier(.16,1,.29,.99)"
    , htmlAttribute <| Html.Attributes.class "repoCard"
    ]


attrsRow : Model.Model -> List (Attribute msg)
attrsRow _ =
    [ width fill
    , spacing 20
    ]


repoCard : Model.Model -> Type.Repo -> Element msg
repoCard model repo =
    link (attrsRepoCard model)
        { url = repo.html_url
        , label = ViewRepo.view model 0 repo
        }


viewFirstOne : Model.Model -> List Type.Repo -> List (Element msg)
viewFirstOne model repos =
    List.map (\repo -> repoCard model repo) repos


viewFirstTwo : Model.Model -> List Type.Repo -> List (Element msg)
viewFirstTwo model repos =
    case repos of
        [] ->
            []

        x :: [] ->
            [ repoCard model x ]

        x :: y :: xs ->
            row
                (attrsRow model)
                [ repoCard model x
                , repoCard model y
                ]
                :: viewFirstTwo model xs


viewFirstThree : Model.Model -> List Type.Repo -> List (Element msg)
viewFirstThree model repos =
    case repos of
        [] ->
            []

        x :: [] ->
            [ repoCard model x ]

        x :: y :: [] ->
            [ row
                (attrsRow model)
                [ repoCard model x
                , repoCard model y
                ]
            ]

        x :: y :: z :: xs ->
            row
                (attrsRow model)
                [ repoCard model x
                , repoCard model y
                , repoCard model z
                ]
                :: viewFirstThree model xs


viewIntroduction : Model.Model -> Element msg
viewIntroduction model =
    column [ width fill ]
        [ el
            [ width fill
            , height <| px 190
            , Background.image <|
                if model.localStorage.nightMode then
                    "img/backgroundDark.png"

                else
                    "img/backgroundBright.png"
            ]
          <|
            none
        , ViewBody.viewTagline model
        , ViewBody.view
        ]


viewRepos : Model.Model -> Element msg
viewRepos model =
    let
        repos =
            Search.filteredRepos model

        length =
            List.length repos
    in
    column
        [ centerX
        , width (fill |> maximum Conf.maxWidth)
        , spacing 30
        , paddingXY (Utils.paddingResponsive model) 0
        ]
    <|
        if length == 0 then
            [ el [ centerX, paddingXY 0 100 ] <| text <| "No Repositories found for the filter \"" ++ model.filter ++ "\"" ]

        else
            (el
                []
             <|
                text <|
                    String.fromInt length
                        ++ " repositories"
            )
                :: (if model.width < 600 then
                        viewFirstOne

                    else if model.width < 900 then
                        viewFirstTwo

                    else
                        viewFirstThree
                   )
                    model
                    repos


filterText : { a | width : number } -> String
filterText model =
    "Find a repository"


filterInputText : Model.Model -> Element Msg.Msg
filterInputText model =
    el
        [ width fill
        , spacing 20
        , width (fill |> maximum Conf.maxWidth)
        , padding 20
        , centerX
        , inFront <|
            el [ alignRight, moveLeft 30, moveDown 30 ] <|
                if String.length model.filter > 0 then
                    Input.button []
                        { label = Icon.icon Icon.Close (Utils.c model .font) Conf.iconSize
                        , onPress = Just <| Msg.ChangeFilter ""
                        }

                else
                    Input.button []
                        { label = Icon.icon Icon.Search (Utils.c model .font) Conf.iconSize
                        , onPress = Nothing
                        }
        ]
    <|
        Input.text
            [ Border.width 1
            , Border.rounded 5
            , Border.color <| Utils.c model .border
            , Font.size 18
            , width fill
            , Background.color <| Utils.c model .cardBackground
            ]
            { onChange = Msg.ChangeFilter
            , text = Utils.decode model.filter
            , placeholder =
                Just <|
                    Input.placeholder
                        [ Font.color <| Utils.c model .fontLight
                        , moveDown 4
                        ]
                    <|
                        text (filterText model)
            , label = Input.labelHidden (filterText model)
            }


view : Model.Model -> Browser.Document Msg.Msg
view model =
    { title = "Rakuten Open Source"
    , body =
        [ layoutWith
            { options =
                [ focusStyle
                    { borderColor = Nothing
                    , backgroundColor = Nothing
                    , shadow =
                        Nothing
                    }
                ]
            }
            [ width fill
            , Font.family
                [ Font.typeface "Noto Sans JP"
                , Font.sansSerif
                ]
            , Font.color <| Utils.c model .font
            , Font.size 18
            , Background.color <| Utils.c model .background
            , htmlAttribute <| Html.Attributes.style "transition" "background 1000ms linear"
            , inFront <| ViewHeader.view model
            ]
          <|
            column
                [ paddingEach
                    { top =
                        if Utils.isMobile model then
                            Conf.headerHeightSmall

                        else
                            Conf.headerHeight
                    , right = 0
                    , bottom = 0
                    , left = 0
                    }
                , spacing 10
                , width fill
                ]
            <|
                [ html <| Html.node "style" [] [ Html.text <| Conf.css ]
                , viewIntroduction model
                , filterInputText model
                , viewRepos model
                , case model.error of
                    Just _ ->
                        el [ centerX, padding 80 ] <| text <| "Error while loading repositories from GitHub..."

                    Nothing ->
                        none
                , el [ height <| px 60 ] none
                , ViewFooter.view model
                ]
        ]
    }
