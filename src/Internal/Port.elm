port module Internal.Port exposing
    ( elmToLocalStorage
    , elmToLog
    , onStoreChange
    , pageInTopArea
    , toLocalStorage
    )

import Json.Encode


port pageInTopArea : (Bool -> msg) -> Sub msg


port onStoreChange : (String -> msg) -> Sub msg


port elmToLocalStorage : Maybe String -> Cmd msg


port elmToLog : String -> Cmd msg


toLocalStorage : { a | nightMode : Bool } -> Cmd msg
toLocalStorage data =
    let
        json =
            Json.Encode.object
                [ ( "nightMode", Json.Encode.bool data.nightMode )
                ]

        string =
            Json.Encode.encode 0 json
    in
    elmToLocalStorage <| Just string
