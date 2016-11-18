module Main exposing (..)

import Html exposing (..)
import View
import Types exposing (..)
import State


init : ( Model, Cmd Msg )
init =
    ( initialModel 1000, Cmd.none )



--WIRING


main =
    Html.program
        { init = init
        , update = State.update
        , view = View.root
        , subscriptions = (\m -> Sub.none)
        }
