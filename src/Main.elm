module Main exposing (main)

import Browser
import Browser.Dom exposing (Element)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html)
import Html.Attributes



-- MAIN


main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
    Int


init : Model
init =
    0



-- UPDATE


type Msg
    = Increment
    | Decrement


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            model + 1

        Decrement ->
            model - 1



-- VIEW


view : Model -> Html Msg
view model =
    Element.layout [] <|
        row
            [ width fill
            , height fill
            , spacingXY 5 2
            ]
            [ decrementButton
            , el
                [ centerX, centerY ]
                (text (String.fromInt model))
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
        { onPress = Just Increment, label = text "+" }


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
        { onPress = Just Decrement, label = text "-" }
