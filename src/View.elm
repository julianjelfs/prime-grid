module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)

root: Model -> Html Msg
root model =
    div []
        [ h1 []
            [ text "Prime number visualiser" ]
        , button
            [ onClick ToggleAssist ]
            [ text ("Toggle Cheat Mode (" ++ (toString model.assist) ++ ")")]
        , button
            [ onClick Reset ]
            [ text "Reset"]
        , div [class "grid"]
            (model.grid
                |> List.map
                    (\(n, state, m) ->
                        let
                            cls =
                                case List.isEmpty m of
                                    True ->
                                        case state of
                                            Clicked -> "cell clicked"
                                            Empty -> "cell"
                                    False ->
                                        case model.assist of
                                            True -> "cell disabled"
                                            False -> "cell"
                        in
                        div
                            [ class cls
                            , onClick (ClickNumber (n, state, m))
                            , title (if List.isEmpty m then "" else (toString m))
                            ]
                            [ text (toString n)]))]


