module Types exposing (..)

type CellState =
    Empty
    | Clicked

type alias MultipleOf = List Int

type alias Cell = (Int, CellState, MultipleOf)

type alias Grid = List Cell

type alias Model =
    { grid : Grid
    , assist: Bool
    }

type Msg =
    ClickNumber Cell
    | ToggleAssist
    | Reset

initialModel : Int -> Model
initialModel n =
    Model ([1..n]
        |> List.map (\n -> (n, Empty, [])))
        False
