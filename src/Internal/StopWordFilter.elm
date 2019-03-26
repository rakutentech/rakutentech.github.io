module Internal.StopWordFilter exposing (createMyStopWordFilter)

import StopWordFilter



-- createMyStopWordFilter : Index.Model.Index doc -> ( Index.Model.Index doc, String -> Bool )


createMyStopWordFilter =
    {- The type signature for this function would be:

       createMyStopWordFilter : Index.Model.Index doc -> ( Index.Model.Index doc, String -> Bool )

       but these types are not exposed.
    -}
    StopWordFilter.createFilterFunc
        []
