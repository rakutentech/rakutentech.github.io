module Internal.Model exposing (Model)

import Browser.Navigation
import ElmTextSearch
import Http
import Internal.Type as Type
import Url


type alias Model =
    { url : Url.Url
    , key : Browser.Navigation.Key
    , filter : String
    , width : Int
    , pageInTopArea : Bool
    , localStorage : Type.LocalStorage
    , error : Maybe Http.Error
    , indexForRepo : ( ElmTextSearch.Index Type.Repo, List ( Int, String ) )
    , repos : List Type.Repo
    }
