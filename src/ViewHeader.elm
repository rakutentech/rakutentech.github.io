module ViewHeader exposing (view)

import Conf
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Html.Attributes
import Internal.Icon as Icon
import Internal.Model as Model
import Internal.Msg as Msg
import Internal.Utils as Utils



{-
   ██   ██ ███████  █████  ██████  ███████ ██████
   ██   ██ ██      ██   ██ ██   ██ ██      ██   ██
   ███████ █████   ███████ ██   ██ █████   ██████
   ██   ██ ██      ██   ██ ██   ██ ██      ██   ██
   ██   ██ ███████ ██   ██ ██████  ███████ ██   ██
-}


logo : Model.Model -> Element msg
logo model =
    row [ spacing 7 ]
        [ if Utils.isMobile model then
            el [] <| Icon.icon Icon.Logo_Rakuten (Utils.c model .logo) 28

          else
            el [] <| Icon.icon Icon.Logo_Rakuten (Utils.c model .logo) 32
        ]


view : Model.Model -> Element Msg.Msg
view model =
    el
        ([ clip
         , width fill
         , Background.color <| Utils.c model .headerBackground
         , htmlAttribute <| Html.Attributes.style "transition" "all 400ms linear"
         ]
            ++ (if model.pageInTopArea && not (Utils.isMobile model) then
                    [ height <| px Conf.headerHeight ]

                else
                    [ height <| px Conf.headerHeightSmall
                    , Border.shadow { offset = ( 0, 0 ), size = 5, blur = 10, color = rgba 0 0 0 0.2 }
                    ]
               )
        )
    <|
        row
            [ width (fill |> maximum Conf.maxWidth)
            , centerX
            , centerY
            , spacing 8
            , htmlAttribute <| Html.Attributes.style "transition" "padding 400ms linear"
            , paddingXY (Utils.paddingResponsive model) 0
            ]
            [ logo model
            , el
                [ Font.size <|
                    if Utils.isMobile model then
                        16

                    else
                        18
                ]
              <|
                text "Open Source"
            ]
