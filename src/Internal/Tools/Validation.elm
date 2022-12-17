module Internal.Tools.Validation exposing (..)

import Bytes.Encode as B
import Json.Decode as D


type alias Validator a =
    a -> Bool


decoder : Validator a -> D.Decoder a -> D.Decoder a
decoder validator =
    D.andThen
        (\value ->
            if validator value then
                D.succeed value

            else
                D.fail "Invalid value according to validator."
        )


maxWidth : Int -> Validator String
maxWidth i s =
    B.getStringWidth s <= i


and : Validator a -> Validator a -> Validator a
and va vb =
    \value ->
        List.all identity [ va value, vb value ]
