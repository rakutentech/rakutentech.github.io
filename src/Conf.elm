module Conf exposing
    ( ColorPalette
    , colorPalette
    , css
    , headerHeight
    , headerHeightSmall
    , iconSize
    , maxWidth
    , paddingDesktop
    , paddingMobile
    , repos
    )

import Element exposing (..)



{-
    ██████  ██████  ███    ██ ███████
   ██      ██    ██ ████   ██ ██
   ██      ██    ██ ██ ██  ██ █████
   ██      ██    ██ ██  ██ ██ ██
    ██████  ██████  ██   ████ ██
-}


repos : List { githubId : String, label : String }
repos =
    [ { githubId = "rakutentech"
      , label = "Rakuten Tech"
      }
    , { githubId = "rakuten-frontend"
      , label = "Rakuten Front-end"
      }
    , { githubId = "roma"
      , label = "Roma"
      }
    , { githubId = "rakuten-ws"
      , label = "Rakuten Web Service"
      }
    , { githubId = "leo-project"
      , label = "Leo Project"
      }
    , { githubId = "egison"
      , label = "Egison"
      }
    , { githubId = "kobolabs"
      , label = "Rakuten Kobo"
      }
    , { githubId = "wuakitv"
      , label = "Rakuten TV"
      }
    , { githubId = "viki-org"
      , label = "Rakuten Viki"
      }
    , { githubId = "rakuten-nlp"
      , label = "Rakuten NLP"
      }
    , { githubId = "Viber"
      , label = "Rakuten Viber"
      }
    ]


headerHeight : Int
headerHeight =
    120


headerHeightSmall : Int
headerHeightSmall =
    70


maxWidth : Int
maxWidth =
    1200


iconSize : Int
iconSize =
    32


paddingDesktop : Int
paddingDesktop =
    20


paddingMobile : Int
paddingMobile =
    14



{-
    ██████ ███████ ███████
   ██      ██      ██
   ██      ███████ ███████
   ██           ██      ██
    ██████ ███████ ███████
-}


css : String
css =
    """
.animatedItem {
    transition: all 100ms linear;
}
.animatedItem:hover {
    transform: scale(1.7, 1.7);
    z-index: 1;
}
.repoCard {
    transform: translate3d(0,0,0);
}
.repoCard:hover {
    transform: translate3d(0,-4px,0);
}
"""



{-
    ██████  ██████  ██       ██████  ██████  ███████
   ██      ██    ██ ██      ██    ██ ██   ██ ██
   ██      ██    ██ ██      ██    ██ ██████  ███████
   ██      ██    ██ ██      ██    ██ ██   ██      ██
    ██████  ██████  ███████  ██████  ██   ██ ███████
-}


type alias ColorPalette =
    { background : Color
    , cardBackground : Color
    , labelBackground : Color
    , repoBackground : Color
    , repoShadow : Color
    , font : Color
    , fontLight : Color
    , headerBackground : Color
    , footerBackground : Color
    , footerFont : Color
    , footerFontLight : Color
    , footerLogo : Color
    , border : Color
    , logo : Color
    , crimson : Color
    }


colorPalette : Bool -> ColorPalette
colorPalette nightMode =
    if nightMode then
        { background = rgb 0.2 0.2 0.2
        , cardBackground = rgb255 20 20 20
        , labelBackground = rgb 0.2 0.2 0.2
        , repoBackground = rgb 0.18 0.18 0.18
        , repoShadow = rgb 0 0 0
        , font = rgb 0.8 0.8 0.8
        , fontLight = rgb 0.5 0.5 0.5
        , headerBackground = rgb255 20 20 20
        , footerBackground = rgb255 20 20 20
        , footerFont = rgb255 200 200 200
        , footerFontLight = rgb255 153 153 153
        , footerLogo = rgb255 255 255 255
        , border = rgb 0.2 0.2 0.2
        , logo = rgb255 255 255 255
        , crimson = rgb255 140 0 0
        }

    else
        { background = rgb 0.95 0.95 0.95
        , cardBackground = rgb 1 1 1
        , labelBackground = rgb 0.9 0.9 0.9
        , repoBackground = rgb 0.97 0.97 0.97
        , repoShadow = rgb 0.8 0.8 0.8

        -- Font color from Rakuten Guidelines: #686868 rgb(105, 105, 105)
        --, font = rgb 0.3 0.3 0.3
        , font = rgb255 105 105 105
        , fontLight = rgb 0.4 0.4 0.4
        , headerBackground = rgb255 255 255 255
        , footerBackground = rgb255 51 51 51
        , footerFont = rgb255 200 200 200
        , footerFontLight = rgb255 153 153 153
        , footerLogo = rgb255 255 255 255
        , border = rgb 0.8 0.8 0.8
        , logo = rgb255 191 0 0
        , crimson = rgb255 191 0 0
        }
