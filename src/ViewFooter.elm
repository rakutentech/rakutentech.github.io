module ViewFooter exposing (view)

import Conf
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html.Attributes
import Internal.Icon as Icon
import Internal.Model as Model
import Internal.Msg as Msg
import Internal.Utils as Utils



{-
   ███████  ██████   ██████  ████████ ███████ ██████
   ██      ██    ██ ██    ██    ██    ██      ██   ██
   █████   ██    ██ ██    ██    ██    █████   ██████
   ██      ██    ██ ██    ██    ██    ██      ██   ██
   ██       ██████   ██████     ██    ███████ ██   ██
-}


view : Model.Model -> Element Msg.Msg
view model =
    let
        alignL =
            if Utils.isMobile model then
                centerX

            else
                alignLeft

        alignR =
            if Utils.isMobile model then
                centerX

            else
                alignRight
    in
    el
        [ centerX
        , paddingXY 20 60
        , Background.color <| Utils.c model .footerBackground
        , width fill
        , Font.color <| Utils.c model .footerFont
        , Font.size 15
        ]
    <|
        column
            [ -- width (fill |> maximum 500)
              centerX
            , spacing 60
            ]
            [ (if Utils.isMobile model then
                column

               else
                row
              )
                [ width fill
                , spacing 80
                ]
                [ column
                    [ spacing 30
                    , alignL
                    , alignTop
                    ]
                    [ el [ alignL, Font.bold ] <| text "GitHub"
                    , column [ alignL, spacing 12, Font.color <| Utils.c model .footerFontLight ] <|
                        List.map
                            (\{ githubId, label } ->
                                link [ alignL ] { label = text label, url = "https://github.com/" ++ githubId }
                            )
                            Conf.repos
                    ]
                , column
                    [ spacing 30
                    , alignL
                    , alignTop
                    ]
                    [ el [ alignL, Font.bold ] <| text "Resources"
                    , column [ alignL, spacing 12, Font.color <| Utils.c model .footerFontLight ]
                        [ link [ alignL ] { label = text "Rakuten Developers", url = "https://webservice.rakuten.co.jp/" }
                        , link [ alignL ] { label = text "Rakuten RapidAPI", url = "https://api.rakuten.co.jp/" }
                        , link [ alignL ] { label = text "Rakuten Institute of Technology", url = "https://rit.rakuten.co.jp/oss/" }
                        ]
                    ]
                , column [ alignR, spacing 14, alignTop ]
                    [ link [ alignR ] { label = Icon.icon Icon.Logo_Rakuten (Utils.c model .footerLogo) 32, url = "https://global.rakuten.com/corp/" }
                    , el [ alignR, Font.size 15, Font.color <| Utils.c model .footerFontLight ] <| text "© Rakuten, inc."
                    , Input.button [ alignR, paddingXY 0 20 ]
                        { label =
                            column [ spacing 10, Font.color <| Utils.c model .footerFontLight ]
                                [ text "Night mode"
                                , el
                                    [ width <| px 60
                                    , height <| px 30
                                    , Border.rounded 14
                                    , alignR
                                    , Background.color <|
                                        rgb255 150 150 150
                                    , inFront <|
                                        el
                                            [ width <| px 26
                                            , height <| px 26
                                            , Border.rounded 13
                                            , htmlAttribute <| Html.Attributes.style "transition" "all 100ms linear"
                                            , Background.color <| Utils.c model .footerBackground
                                            , moveRight <|
                                                if model.localStorage.nightMode then
                                                    32

                                                else
                                                    3
                                            , moveDown 2
                                            ]
                                        <|
                                            none
                                    ]
                                  <|
                                    none
                                ]
                        , onPress = Just Msg.ToggleColorMode
                        }
                    ]
                ]
            , row [ spacing 30, centerX ]
                [ link [] { label = text "About", url = "https://global.rakuten.com/corp/" }
                , link [] { label = text "Careers", url = "https://rakuten.careers/" }
                , link [] { label = text "Contact", url = "mailto:dev-opensource@mail.rakuten.com" }
                ]
            ]
