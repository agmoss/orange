module Main exposing (..)

-- import Html exposing (Html, button, div, h1, img, text)
-- import Html.Attributes exposing (src)
-- import Html.Events exposing (onClick)
-- import Html

import Browser
import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, href, src)
import Html.Styled.Events exposing (onClick)
import Random



---- MODEL ----


type alias Model =
    { randRed : Int
    , randGreen : Int
    , randBlue : Int
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model 1 1 1, Cmd.none )



---- UPDATE ----


type Msg
    = UpdateRgbCode
    | NewRgbCode Model


oneTo255 : Random.Generator Int
oneTo255 =
    Random.int 1 255


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateRgbCode ->
            ( model
            , Random.generate NewRgbCode rgbCodeGenerator
            )

        NewRgbCode r ->
            ( r, Cmd.none )


rgbCodeGenerator : Random.Generator Model
rgbCodeGenerator =
    Random.map3 (\a b c -> Model a b c)
        (Random.int 50 350)
        (Random.int 50 350)
        (Random.int 50 350)



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ img [ src "/logo.svg" ] []
        , h1 [ css [ color (rgb model.randRed model.randGreen model.randBlue) ] ] [ text "Orange" ]
        , h1 [] [ text (String.fromInt model.randRed) ]
        , button [ onClick UpdateRgbCode ] [ text "Change Number" ]
        ]



---- SUBSCRIPTIONS ----


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view >> toUnstyled
        , init = init
        , update = update
        , subscriptions = subscriptions
        }
