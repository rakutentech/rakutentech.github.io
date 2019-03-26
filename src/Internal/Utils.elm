module Internal.Utils exposing
    ( c
    , decode
    , encode
    , isMobile
    , orderRepos
    , paddingResponsive
    , urlToLabel
    )

import Conf
import Internal.Model as Model
import Internal.Type as Type
import Url


orderRepos : List Type.Repo -> List Type.Repo
orderRepos repos =
    List.reverse <| List.sortBy .stargazers_count repos


urlToLabel : String -> Maybe String
urlToLabel url =
    List.foldl
        (\{ githubId, label } acc ->
            case acc of
                Just label_ ->
                    Just label_

                Nothing ->
                    if String.contains ("github.com/" ++ githubId) url then
                        Just label

                    else
                        Nothing
        )
        Nothing
        Conf.repos


encode : String -> String
encode string =
    string
        |> String.replace " " "_"
        |> Url.percentEncode


decode : String -> String
decode string =
    string
        |> Url.percentDecode
        |> Maybe.withDefault ""
        |> String.replace "_" " "


c : Model.Model -> (Conf.ColorPalette -> b) -> b
c model key =
    key <| Conf.colorPalette model.localStorage.nightMode


isMobile : { a | width : number } -> Bool
isMobile model =
    model.width < 700


paddingResponsive : { a | width : number } -> Int
paddingResponsive model =
    if isMobile model then
        Conf.paddingMobile

    else
        Conf.paddingDesktop
