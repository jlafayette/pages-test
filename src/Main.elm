module Main exposing (main)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font

main =
    layout [] view

view =
    el [ centerX, centerY ] (text "Hello from elm")
