module Internal.Search exposing
    ( filteredRepos
    , indexBuilderforRepo
    , resultSearch
    )

import ElmTextSearch
import Index.Defaults
import Internal.StopWordFilter as StopWordFilter
import Internal.Utils as Utils
import StopWordFilter



-- HELPERS
-- SEARCH ENGINE
--createMyStopWordFilter : Index.Model.Index doc -> ( Index.Model.Index doc, String -> Bool )


indexBuilderforRepo :
    List { a | description : String, language : String, name : String }
    -> ( ElmTextSearch.Index { a | description : String, language : String, name : String }, List ( Int, String ) )
indexBuilderforRepo repos =
    let
        index =
            ElmTextSearch.newWith
                { ref = \repo -> repo.name
                , fields =
                    [ ( \repo -> repo.name, 5.0 )
                    , ( \repo -> repo.description, 1.0 )
                    , ( \repo -> repo.language, 1.0 )
                    ]
                , listFields = []
                , indexType = "Rakuten Open Source - Customized Stop Words v1"
                , initialTransformFactories = Index.Defaults.defaultInitialTransformFactories
                , transformFactories = Index.Defaults.defaultTransformFactories
                , filterFactories = [ StopWordFilter.createMyStopWordFilter ]
                }
    in
    ElmTextSearch.addDocs repos index


resultSearch :
    ( ElmTextSearch.Index doc, b )
    -> String
    -> Result String ( ElmTextSearch.Index doc, List ( String, Float ) )
resultSearch index searchString =
    ElmTextSearch.search searchString (Tuple.first index)


filteredRepos :
    { c
        | filter : String
        , indexForRepo : ( ElmTextSearch.Index doc, b )
        , repos : List { a | name : String }
    }
    -> List { a | name : String }
filteredRepos model =
    let
        searchResults =
            Result.map Tuple.second <|
                resultSearch model.indexForRepo (Utils.decode model.filter)

        itemsToShow =
            case searchResults of
                Ok result ->
                    List.concatMap
                        (\item ->
                            let
                                id =
                                    Tuple.first item
                            in
                            List.filter (\item_ -> item_.name == id) model.repos
                        )
                        result

                Err _ ->
                    model.repos
    in
    itemsToShow
