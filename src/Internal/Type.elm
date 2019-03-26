module Internal.Type exposing
    ( ClickData
    , Flags
    , LocalStorage
    , Repo
    )


type alias LocalStorage =
    { nightMode : Bool }


type alias Flags =
    { width : Int
    , localStorage : LocalStorage
    }


type alias ClickData =
    { id1 : String
    , id2 : String
    , id3 : String
    , id4 : String
    , id5 : String
    }


type alias Repo =
    { name : String
    , description : String
    , fork : Bool
    , updated_at : String
    , homepage : String
    , language : String
    , html_url : String
    , logo : String
    , stargazers_count : Int
    , watchers_count : Int
    , forks_count : Int
    }
