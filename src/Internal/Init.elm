module Internal.Init exposing (init)

import Browser.Navigation
import Conf
import Internal.APIRequest as APIRequest
import Internal.CommonRoute as CommonRoute
import Internal.Model as Model
import Internal.Msg as Msg
import Internal.Route as Route
import Internal.Search as Search
import Internal.Type as Type
import Repos
import Url



-- INIT


init : Type.Flags -> Url.Url -> Browser.Navigation.Key -> ( Model.Model, Cmd Msg.Msg )
init flags url key =
    let
        filter =
            case CommonRoute.fromUrl Route.conf url of
                Route.Filter filter_ ->
                    filter_

                _ ->
                    ""
    in
    ( { url = url
      , key = key
      , filter = filter
      , width = flags.width
      , pageInTopArea = True
      , localStorage = flags.localStorage
      , error = Nothing
      , indexForRepo = Search.indexBuilderforRepo Repos.repos
      , repos = Repos.repos
      }
    , Cmd.batch <|
        List.map
            (\{ githubId, label } ->
                let
                    apiUrl =
                        if url.host == "localhost" then
                            "test-api/" ++ githubId ++ ".json"

                        else
                            "https://api.github.com/orgs/" ++ githubId ++ "/repos?type=source&per_page=100"
                in
                APIRequest.request apiUrl
            )
            Conf.repos
    )
