module Main exposing (..)

import Browser
import Html exposing (Html, button, div, h1, img, text)
import Html.Attributes exposing (src)
import Html.Events exposing (onClick)
import Random



---- MODEL ----


type alias Model =
    { randRgb : Int }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model 1, Cmd.none )



---- UPDATE ----


type Msg
    = UpdateNumber
    | CreateNewNumber Int


oneTo255 : Random.Generator Int
oneTo255 =
    Random.int 1 255


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateNumber ->
            ( model, Random.generate CreateNewNumber oneTo255 )

        CreateNewNumber val ->
            ( Model val, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ img [ src "/logo.svg" ] []
        , h1 [] [ text "Orange" ]
        , h1 [] [ text (String.fromInt model.randRgb) ]
        , button [ onClick UpdateNumber ] [ text "Change Number" ]
        ]



---- SUBSCRIPTIONS ----


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = init
        , update = update
        , subscriptions = subscriptions
        }
