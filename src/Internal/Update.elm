module Internal.Update exposing (update)

import Browser
import Browser.Navigation
import Http
import Internal.CommonRoute as CommonRoute
import Internal.Model as Model
import Internal.Msg as Msg
import Internal.Port as Port
import Internal.Route as Route
import Internal.Search as Search
import Internal.Type as Type
import Internal.Utils as Utils
import Json.Decode
import Json.Decode.Pipeline
import Keyboard
import ReposFilter
import Url


commandToCloseModal :
    { a
        | filter : String
        , key : Browser.Navigation.Key
    }
    -> Cmd msg
commandToCloseModal { filter, key } =
    Browser.Navigation.pushUrl key <|
        CommonRoute.toStringAndHash Route.conf <|
            Route.routeToRestoreFilter filter


decoder : Json.Decode.Decoder Type.LocalStorage
decoder =
    Json.Decode.succeed Type.LocalStorage
        |> Json.Decode.Pipeline.required "nightMode" Json.Decode.bool


update : Msg.Msg -> Model.Model -> ( Model.Model, Cmd Msg.Msg )
update msg model =
    case msg of
        Msg.OnStoreChange ls ->
            let
                localStorageResult =
                    Json.Decode.decodeString decoder ls
            in
            case localStorageResult of
                Ok localStorage ->
                    ( { model | localStorage = localStorage }, Cmd.none )

                Err _ ->
                    ( model, Cmd.none )

        Msg.GotData response ->
            let
                ( repos, error, cmd ) =
                    case response of
                        Ok repos_ ->
                            ( Utils.orderRepos (model.repos ++ ReposFilter.filter repos_), Nothing, Cmd.none )

                        Err err ->
                            ( model.repos
                            , Just err
                            , Port.elmToLog <|
                                "Error while loading repositories from GitHub: "
                                    ++ (case err of
                                            Http.BadUrl e ->
                                                e

                                            Http.Timeout ->
                                                "Timeout"

                                            Http.NetworkError ->
                                                "Network Error"

                                            Http.BadStatus _ ->
                                                "Bad Status"

                                            Http.BadPayload e _ ->
                                                e
                                       )
                            )
            in
            ( { model
                | repos = repos
                , indexForRepo = Search.indexBuilderforRepo repos
                , error = error
              }
            , cmd
            )

        Msg.LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model
                    , Browser.Navigation.pushUrl model.key (Url.toString url)
                    )

                Browser.External href ->
                    ( model
                    , Browser.Navigation.load href
                    )

        Msg.UrlChanged url ->
            let
                route =
                    CommonRoute.fromUrl Route.conf url

                filter =
                    case route of
                        Route.Filter filter_ ->
                            filter_

                        Route.Empty ->
                            ""

                        _ ->
                            model.filter
            in
            ( { model | url = url, filter = filter }, Cmd.none )

        Msg.KeyUp key ->
            if Keyboard.rawValue key == "Escape" then
                ( model
                , commandToCloseModal model
                )

            else
                ( model, Cmd.none )

        Msg.PageInTopArea state ->
            ( { model | pageInTopArea = state }, Cmd.none )

        Msg.OnResize x _ ->
            ( { model | width = x }, Cmd.none )

        Msg.ToggleColorMode ->
            let
                localStorage =
                    model.localStorage

                newLocalStorage =
                    { localStorage | nightMode = not localStorage.nightMode }
            in
            ( { model | localStorage = newLocalStorage }
            , Port.toLocalStorage newLocalStorage
            )

        Msg.ChangeFilter filter ->
            ( { model | filter = filter }
            , Browser.Navigation.replaceUrl model.key <|
                CommonRoute.toStringAndHash
                    Route.conf
                <|
                    if filter == "" then
                        Route.Empty

                    else
                        Route.Filter <| Utils.encode filter
            )
