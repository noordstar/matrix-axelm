module Internal.Values.Objects exposing (..)

import Internal.Values.SpecObjects as Object
import Internal.Tools.DecodeExtra exposing (opField)
import Json.Decode as D
import Html exposing (img)

type Image = Image { url : String, info : Maybe Object.ImageInfo }

imageDecoder : D.Decoder Image
imageDecoder =
    D.map2
        (\a b -> Image { info = a, url = b })
        (opField "info" Object.imageInfoDecoder)
        (D.field "url" D.string)

getImageUrl : Image -> String
getImageUrl (Image img) =
    img.url

getImageDimensions : Image -> Maybe { width : Int, height : Int }
getImageDimensions (Image img) =
    case img.info of
        Just info ->
            case (info.w, info.h) of
                (Just w, Just h) ->
                    Just { width = w, height = h }
                _ ->
                    Nothing
        _ ->
            Nothing

getImageSize : Image -> Maybe Int
getImageSize (Image img) =
    img.info
    |> Maybe.map .size

getImageMimetype : Image -> Maybe String
getImageMimetype (Image img) =
    img.info
    |> Maybe.map .mimetype

getImageThumbnail : Image -> Maybe Thumbnail
getImageThumbnail (Image img) =
    img.info
    |> Maybe.map .thumbnailUrl
    |> Maybe.map
        (\url ->
            Thumbnail
                { url  = url
                , file = img.info |> Maybe.map .thumbnailFile
                , info = img.info |> Maybe.map .thumbnailInfo
                }
        )

type Thumbnail 
    = Thumbnail { url : String
                , file : Maybe Object.EncryptedFile
                , info : Maybe O.ThumbnailInfo 
                }

getThumbnailUrl : Thumbnail -> String
getThumbnailUrl (Thumbnail t) =
    t.url

getThumbnailDimensions : Thumbnail -> Maybe { width : Int, height : Int }
getThumbnailDimensions (Thumbnail t) =
    Nothing

getThumbnailMimetype : Thumbnail -> Maybe String
getThumbnailMimetype (Thumbnail t) =
    t.mimetype

getThumbnailSize : Thumbnail -> Maybe Int
getThumbnailSize (Thumbnail t) =
    t.size
