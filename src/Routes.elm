module Routes exposing (..)

import Url
import Url.Parser exposing ((</>), Parser, int, map, oneOf, parse, s, string, top)


type Route
    = Home
    | Post String
    | NotFound


routeParser : Parser (Route -> a) a
routeParser =
    oneOf
        [ map Home top
        , map Home (s "posts")
        , map Post (s "posts" </> string)
        ]


fromUrl : Url.Url -> Route
fromUrl url =
    Maybe.withDefault NotFound (parse routeParser url)
