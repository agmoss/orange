module Main exposing (main)

import Browser
import Css exposing (Color, backgroundColor, color, fontSize, hover, margin, padding, px, rgb, textDecoration, underline)
import Html.Styled exposing (Attribute, Html, button, div, h1, h2, img, styled, text, toUnstyled)
import Html.Styled.Attributes exposing (css, src)
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
    ( Model 255 165 0, Cmd.none )



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
        oneTo255
        oneTo255
        oneTo255



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ img [ src "/logo.svg" ] []
        , h1 [ css [ color (rgb model.randRed model.randGreen model.randBlue) ] ] [ isItOrange model ]
        , h2 [] [ text ("RGB(" ++ String.fromInt model.randRed ++ "," ++ String.fromInt model.randGreen ++ "," ++ String.fromInt model.randBlue ++ ")") ]
        , btn [ onClick UpdateRgbCode ] [ text "Change Color" ]
        ]



-- Is the color orange !?!


isItOrange : Model -> Html msg
isItOrange model =
    if model.randRed > 150 && model.randGreen < 150 && model.randBlue < 100 then
        text "Orange!"

    else
        text "Not Orange"



-- Styled Elements


theme :
    { primary : Color
    , secondary : Color
    }
theme =
    { primary = rgb 255 165 0 -- Orange
    , secondary = rgb 250 240 230
    }


btn : List (Attribute msg) -> List (Html msg) -> Html msg
btn =
    styled
        button
        [ margin (px 34)
        , color theme.primary
        , backgroundColor theme.secondary
        , fontSize (px 23)
        , padding (px 6)
        , hover
            [ backgroundColor theme.primary
            , textDecoration underline
            , color theme.secondary
            ]
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
