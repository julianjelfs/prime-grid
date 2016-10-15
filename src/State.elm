module State exposing (..)

import Types exposing (..)

toggleCell: Int -> CellState -> Grid -> Grid
toggleCell n s grid =
    grid
        |> List.map
            (\(num, state, m) ->
                if n == num then
                    (num, s, m)
                else
                    (num, state, m))

newState: CellState -> CellState
newState state =
    case state of
        Empty -> Clicked
        Clicked -> Empty

updateMultiples: Cell -> Grid -> Grid
updateMultiples (n, state, multiples) grid =
    case state of
        Clicked ->
            grid
                |> List.map
                    (\(num, s, m) ->
                        if num % n == 0 && num /= n && n /= 1 then
                            (num, s, n :: m)
                        else
                            (num, s, m))
        Empty ->
            grid
                |> List.map
                    (\(num, s, m) ->
                        if num % n == 0 then
                            (num, s, (m |> List.filter (\x -> x /= n)))
                        else
                            (num, s, m))

isPrime: Int -> Bool
isPrime n =
    if n == 1 then
        False
    else
        [2..n-1]
            |> List.filter (\x -> n % x == 0)
            |> List.isEmpty

update : Msg -> Model -> (Model,  Cmd Msg)
update msg model =
    case msg of
        Reset ->
            (initialModel 1000, Cmd.none)
        ToggleAssist ->
            ({model|assist = (not model.assist)}, Cmd.none)

        ClickNumber (num, state, m) ->
            let
                s = newState state
                update = (toggleCell num s) >> (updateMultiples (num, s, m))
                grid =
                    if isPrime num then
                        update model.grid
                    else
                        model.grid
            in
                ({model|grid = grid}, Cmd.none)

