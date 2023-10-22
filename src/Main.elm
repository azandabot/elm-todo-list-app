module Main exposing (..)

import Browser
import Html exposing (div, input, button, text, ul, li, input)
import Html.Attributes exposing (placeholder)
import Html.Events exposing (onClick, onInput)

-- MAIN

main = Browser.sandbox { init = initialModel, update = update, view = view }


-- MODEL

type alias Task = {
        id : Int,
        description : String,
        completed : Bool
    }

type alias Model = {
        nextTaskId : Int,
        tasks : List Task
    }

initialModel : Model
initialModel = {
        nextTaskId = 1,
        tasks = []
    }

-- UPDATE

type Msg
    = AddTask String
    | ToggleTask Int
    | RemoveTask Int

update : Msg -> Model -> Model
update msg model =
    case msg of
        AddTask description ->
            let
                newTask =
                    { id = model.nextTaskId, description = description, completed = False }
            in
            { model | nextTaskId = model.nextTaskId + 1, tasks = newTask :: model.tasks }

        ToggleTask taskId ->
            let
                updatedTasks =
                    List.map
                        (\task ->
                            if task.id == taskId then
                                { task | completed = not task.completed }
                            else
                                task
                        )
                        model.tasks
            in
            { model | tasks = updatedTasks }

        RemoveTask taskId ->
            let
                updatedTasks =
                    List.filter (\task -> task.id /= taskId) model.tasks
            in
            { model | tasks = updatedTasks }

-- VIEW

view : Model -> Html.Html Msg
view model =
    div []
        [ div []
            [ input [ placeholder "Enter Todo", onInput AddTask ] []
            , button [ onClick (AddTask "") ] [ text "Add Todo" ]
            ]
        , viewTasks model.tasks
        ]

viewTasks : List Task -> Html.Html Msg
viewTasks tasks =
    ul []
        (List.map viewTask tasks)

viewTask : Task -> Html.Html Msg
viewTask task =
    li []
        [ input [ Html.Attributes.type_ "checkbox", Html.Attributes.checked task.completed, onClick (ToggleTask task.id) ] []
        , text task.description
        , button [ onClick (RemoveTask task.id) ] [ text "Delete" ]
        ]
