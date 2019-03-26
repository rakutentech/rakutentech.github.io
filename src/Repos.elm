module Repos exposing (repos)

import Element exposing (..)
import Internal.Type as Type



{- This list can be used to add extra repositories manually -}


repos : List Type.Repo
repos =
    []



{- This is an usage example -}
{-
   repos : List Type.Repo
   repos =
       [ { name = "Rakuten Web Service"
         , description = "Provides information about items listed for sale on Rakuten sites, shopping cart, and other functionality for use by developers and corporate enterprise teams."
         , fork = False
         , updated_at = ""
         , homepage = "http://webservice.rakuten.co.jp/sdk/"
         , language = ""
         , html_url = "https://github.com/rakuten-ws/"
         , logo = ""
         , stargazers_count = 0
         , watchers_count = 0
         , forks_count = 0
         }
       , { name = "LeoFS"
         , description = "LeoFS is an unstructured object/data storage for the Web and a highly available, distributed, eventually consistent storage system."
         , fork = False
         , updated_at = ""
         , homepage = "http://leo-project.net/leofs/"
         , language = ""
         , html_url = "https://github.com/leo-project/leofs"
         , logo = "logo/leofs.png"
         , stargazers_count = 0
         , watchers_count = 0
         , forks_count = 0
         }
       , { name = "ROMA"
         , description = "A Distributed Key-Value Store in Ruby."
         , fork = False
         , updated_at = ""
         , homepage = "http://roma-kvs.org/"
         , language = ""
         , html_url = "https://github.com/roma/roma"
         , logo = "logo/roma.png"
         , stargazers_count = 0
         , watchers_count = 0
         , forks_count = 0
         }
       , { name = "Egison"
         , description = "Egison is a purely functional programming language that realizes non-linear pattern-matching against unfree data types."
         , fork = False
         , updated_at = ""
         , homepage = "http://www.egison.org/"
         , language = ""
         , html_url = "https://github.com/egison/egison"
         , logo = ""
         , stargazers_count = 0
         , watchers_count = 0
         , forks_count = 0
         }
       ]
-}
