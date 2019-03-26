module ViewBody exposing
    ( view
    , viewTagline
    )

import Element exposing (..)
import Element.Font as Font
import Internal.Utils as Utils



{-
   ██████   ██████  ██████  ██    ██
   ██   ██ ██    ██ ██   ██  ██  ██
   ██████  ██    ██ ██   ██   ████
   ██   ██ ██    ██ ██   ██    ██
   ██████   ██████  ██████     ██
-}


viewTagline : { a | width : number } -> Element msg
viewTagline model =
    if Utils.isMobile model then
        paragraph
            [ Font.size 30
            , paddingXY 40 40
            , moveDown 40
            , width (fill |> maximum 600)
            , centerX
            , spacing 10
            , Font.center
            ]
            [ el [] <| text "“"
            , text "Contribute to society by creating value through innovation"
            , el [] <| text "”"
            ]

    else
        column
            [ Font.size 30
            , paddingXY 40 40
            , moveDown 40
            , width (fill |> maximum 600)
            , centerX
            , spacing 10
            , Font.center
            ]
            [ row [ centerX ]
                [ el [ Font.size 70 ] <| text "“"
                , text "Contribute to society by"
                ]
            , row [ centerX, moveUp 30 ]
                [ text "creating value through innovation"
                , el [ Font.size 70, moveDown 30 ] <| text "”"
                ]
            ]


view : Element msg
view =
    let
        attrs =
            [ Font.center, width <| maximum 900 <| fill, paddingXY 20 10, spacing 10 ]
    in
    column [ centerX ]
        [ paragraph attrs
            [ text "We believe that open source is good for society and innovation. We have been using open source in our projects and this is our contribution back to the open source community. We encourage collaboration and contributions are always welcome!" ]
        , el [ centerX, padding 30, Font.size 20 ] <|
            text "At Rakuten we ❤️ open-source."
        ]
