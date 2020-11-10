module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html)
import Html.Attributes
import Routes exposing (Route(..), fromUrl, routeParser)
import Url



-- MAIN


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }



-- MODEL


type alias Model =
    { key : Nav.Key
    , url : Url.Url
    , route : Route
    , count : Int
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( Model key url (fromUrl url) 0, Cmd.none )



-- UPDATE


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | Increment
    | Decrement


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            ( { model | route = fromUrl url, url = url }
            , Cmd.none
            )

        Increment ->
            ( { model | count = model.count + 1 }
            , Cmd.none
            )

        Decrement ->
            ( { model | count = model.count - 1 }
            , Cmd.none
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Browser.Document Msg
view model =
    { title = "Route Test"
    , body =
        [ Element.layout [] <|
            column []
                [ text "The current URL is: "
                , el [] (text (Url.toString model.url))
                , column []
                    [ link [] { url = "/posts", label = text "all posts" }
                    , link [] { url = "/posts/post1", label = text "post1" }
                    , link [] { url = "/posts/post2", label = text "post2" }
                    ]
                -- , buttonsRow model.count
                , content model.route
                ]
        ]
    }


content : Route -> Element msg
content route =
    case route of
        Routes.Home ->
            el [] (text "home!")

        Routes.Post name ->
            el [] (text name)

        Routes.NotFound ->
            el [] (text "not found!")


buttonsRow : Int -> Element Msg
buttonsRow count =
    Element.row
        [ Element.width fill
        , Element.height fill
        , spacingXY 5 2
        ]
        [ decrementButton
        , el
            [ centerX, centerY ]
            (Element.text (String.fromInt count))
        , incrementButton
        ]


grey =
    Element.rgb 0.4 0.4 0.4


dark =
    Element.rgb 0.2 0.2 0.2


light =
    Element.rgb 0.8 0.8 0.8


light2 =
    Element.rgb 0.9 0.9 0.9


white =
    Element.rgb 1 1 1


red =
    Element.rgb 0.8 0 0


blue =
    Element.rgb255 0 149 255


blueDark =
    Element.rgb255 0 119 204


noOutline =
    htmlAttribute <| Html.Attributes.style "box-shadow" "none"


incrementButton =
    Input.button
        [ centerX
        , centerY
        , Background.color blue
        , Font.color white
        , paddingXY 16 8
        , Border.rounded 3
        , Font.size 13
        , mouseOver [ Background.color blueDark ]
        ]
        { onPress = Just Increment, label = Element.text "+" }


decrementButton =
    Input.button
        [ centerX
        , centerY
        , Background.color blue
        , Font.color white
        , paddingXY 16 8
        , Border.rounded 3
        , Font.size 13
        , mouseOver [ Background.color blueDark ]
        ]
        { onPress = Just Decrement, label = Element.text "-" }
