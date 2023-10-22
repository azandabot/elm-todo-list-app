module Main exposing (..)
import Browser
import Html exposing (Html, div, input, button, ul, li, text)
import Html.Attributes exposing (placeholder)
import Html.Events exposing (onInput, onClick)

-- MAIN

main = Browser.sandbox {
        init = init, 
        update = update,
        view = view
    }

-- MODEL 
type alias Model = {
        tasks: List String
    }

init:Model
init = {
        tasks = []
    }


-- UPDATE
type Msg = AddTask String

update: Msg -> Model -> Model 
update model msg = 
    case msg of
        AddTask newTask -> 
            { model | tasks = newTask :: model.tasks }


-- VIEW

view: Model -> Html Msg
view model = 
    div []
    [
        input [placeholder "Enter a new task", onInput AddTask] [],
        button [onClick (AddTask "")] [text "Add Task"],
        ul [] (List.map(\task -> li [] [text task]) model.tasks)
    ]