module Internal.Msg exposing (Msg(..))

import Browser
import Http
import Internal.Type as Type
import Keyboard
import Url


type Msg
    = OnResize Int Int
    | ToggleColorMode
    | ChangeFilter String
    | PageInTopArea Bool
    | KeyUp Keyboard.RawKey
    | LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | GotData (Result Http.Error (List Type.Repo))
    | OnStoreChange String
