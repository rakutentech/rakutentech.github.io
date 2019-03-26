module Internal.Icon exposing
    ( Icon(..)
    , icon
    )

import Color as ElmColor
import Color.Convert
import Element
import Svg
import Svg.Attributes as SA


elementColorToElmColor : Element.Color -> ElmColor.Color
elementColorToElmColor elementColor =
    ElmColor.fromRgba <| Element.toRgb elementColor



{-
   ███████ ██    ██  ██████      ██  ██████  ██████  ███    ██ ███████
   ██      ██    ██ ██           ██ ██      ██    ██ ████   ██ ██
   ███████ ██    ██ ██   ███     ██ ██      ██    ██ ██ ██  ██ ███████
        ██  ██  ██  ██    ██     ██ ██      ██    ██ ██  ██ ██      ██
   ███████   ████    ██████      ██  ██████  ██████  ██   ████ ███████
-}


type Icon
    = Close
    | Star
    | Fork
    | Search
      -- Logos
    | Logo_Rakuten


saFill : Element.Color -> Svg.Attribute msg
saFill cl =
    SA.fill <| Color.Convert.colorToHex <| elementColorToElmColor cl


icon : Icon -> Element.Color -> Int -> Element.Element msg
icon icon_ cl size =
    let
        ( viewBox, paths ) =
            iconViewBoxAndPaths icon_ cl
    in
    Element.html <|
        Svg.svg
            [ SA.xmlSpace "http://www.w3.org/2000/svg"
            , SA.viewBox viewBox
            , SA.height <| String.fromInt size
            ]
            paths


iconViewBoxAndPaths : Icon -> Element.Color -> ( String, List (Svg.Svg msg) )
iconViewBoxAndPaths icon_ cl =
    case icon_ of
        Search ->
            ( "0 0 32 32"
            , [ Svg.path [ saFill cl, SA.d "M13 2a11 11 0 1 0 11 11A11 11 0 0 0 13 2zm0 20a9 9 0 1 1 9-9 9.01 9.01 0 0 1-9 9zm9.86-.55a13.11 13.11 0 0 1-1.41 1.41L28.59 30 30 28.59z" ] []
              , Svg.path [ SA.fill "none", SA.d "M0 0h32v32H0z" ] []
              ]
            )

        Fork ->
            ( "0 0 10 16"
            , [ Svg.path [ saFill cl, SA.fillRule "evenodd", SA.d "M8 1a1.993 1.993 0 0 0-1 3.72V6L5 8 3 6V4.72A1.993 1.993 0 0 0 2 1a1.993 1.993 0 0 0-1 3.72V6.5l3 3v1.78A1.993 1.993 0 0 0 5 15a1.993 1.993 0 0 0 1-3.72V9.5l3-3V4.72A1.993 1.993 0 0 0 8 1zM2 4.2C1.34 4.2.8 3.65.8 3c0-.65.55-1.2 1.2-1.2.65 0 1.2.55 1.2 1.2 0 .65-.55 1.2-1.2 1.2zm3 10c-.66 0-1.2-.55-1.2-1.2 0-.65.55-1.2 1.2-1.2.65 0 1.2.55 1.2 1.2 0 .65-.55 1.2-1.2 1.2zm3-10c-.66 0-1.2-.55-1.2-1.2 0-.65.55-1.2 1.2-1.2.65 0 1.2.55 1.2 1.2 0 .65-.55 1.2-1.2 1.2z" ] [] ]
            )

        Close ->
            ( "0 0 53 53"
            , [ Svg.path
                    [ saFill cl
                    , SA.d "M26 0a26 26 0 1 0 0 52 26 26 0 0 0 0-52zm0 50a24 24 0 1 1 0-48 24 24 0 0 1 0 48z"
                    ]
                    []
              , Svg.path
                    [ saFill cl
                    , SA.d "M35.7 16.3a1 1 0 0 0-1.4 0L26 24.6l-8.3-8.3a1 1 0 1 0-1.4 1.4l8.3 8.3-8.3 8.3a1 1 0 1 0 1.4 1.4l8.3-8.3 8.3 8.3a1 1 0 0 0 1.4 0c.4-.4.4-1 0-1.4L27.4 26l8.3-8.3c.4-.4.4-1 0-1.4z"
                    ]
                    []
              ]
            )

        Logo_Rakuten ->
            ( "0 0 166 49.4"
            , [ Svg.path
                    [ saFill cl
                    , SA.d "M41.2 49.4l92.3-8H33.2l8 8zm1.3-14.3v1.2h6.2V9.1h-6.2v1.2a10 10 0 0 0-5.8-1.9c-7 0-12.4 6.4-12.4 14.3S29.6 37 36.7 37c2.3 0 4-.7 5.8-1.9zM30.7 22.7c0-4.3 2.5-7.7 6-7.7s5.9 3.4 5.9 7.7c0 4.3-2.5 7.7-5.9 7.7-3.5 0-6-3.4-6-7.7zm56 14.3c3 0 5.3-1.7 5.3-1.7v1h6.2V9.1H92v16c0 3-2.1 5.5-5.1 5.5s-5.1-2.5-5.1-5.5v-16h-6.2v16c0 6.6 4.5 11.9 11.1 11.9zm68.2-28.6c-3 0-5.3 1.7-5.3 1.7v-1h-6.2v27.2h6.2v-16c0-3 2.1-5.5 5.1-5.5s5.1 2.5 5.1 5.5v16h6.2v-16c0-6.6-4.5-11.9-11.1-11.9zM22.4 14c0-6.5-5.3-11.7-11.7-11.7H0v34h6.5V25.8h4.6L19 36.3h8.1l-9.6-12.7c3-2.1 4.9-5.6 4.9-9.6zm-11.7 5.3H6.5V8.7h4.2c2.9 0 5.3 2.4 5.3 5.3s-2.4 5.3-5.3 5.3zm92.9 8c0 6.1 4.6 9.7 9.2 9.7a13 13 0 0 0 6-1.7l-4-5.4c-.6.4-1.3.7-2.1.7-1 0-2.9-.8-2.9-3.3V15.6h5.3V9.1h-5.3V2.3h-6.2v6.8h-3.3v6.5h3.3v11.7zm-45.1-2.2l9.2 11.2h8.6L64 21.8 74.6 9.1H66l-7.5 9.5V0h-6.3v36.3h6.3V25.1zm70.6-16.7c-7.2 0-12.3 6.3-12.3 14.3 0 8.4 6.4 14.3 12.9 14.3 3.3 0 7.4-1.1 10.9-6.1l-5.5-3.2c-4.2 6.2-11.3 3.1-12.1-3.2h17.8c1.7-9.7-4.7-16.1-11.7-16.1zm-5.7 10.8c1.3-6.4 9.9-6.8 11.1 0h-11.1z"
                    ]
                    []
              ]
            )

        Star ->
            ( "0 0 14 16"
            , [ Svg.path [ saFill cl, SA.fillRule "evenodd", SA.d "M14 6l-4.9-.64L7 1 4.9 5.36 0 6l3.6 3.26L2.67 14 7 11.67 11.33 14l-.93-4.74L14 6z" ] [] ]
            )
