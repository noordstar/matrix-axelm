module Internal.Api.V1_1.Objects exposing (..)

import Internal.Api.V1_1.SpecObjects as Object
import Internal.Tools.DecodeExtra exposing (opField)
import Json.Decode as D


type Image
    = Image { url : String, info : Maybe Object.ImageInfo }


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
            case ( info.w, info.h ) of
                ( Just w, Just h ) ->
                    Just { width = w, height = h }

                _ ->
                    Nothing

        _ ->
            Nothing


getImageSize : Image -> Maybe Int
getImageSize (Image img) =
    img.info
        |> Maybe.andThen .size


getImageMimetype : Image -> Maybe String
getImageMimetype (Image img) =
    img.info
        |> Maybe.andThen .mimetype


getImageThumbnail : Image -> Maybe Thumbnail
getImageThumbnail (Image img) =
    img.info
        |> Maybe.andThen .thumbnailUrl
        |> Maybe.map
            (\url ->
                Thumbnail
                    { url = url
                    , file = img.info |> Maybe.andThen .thumbnailFile
                    , info = img.info |> Maybe.andThen .thumbnailInfo
                    }
            )


type Thumbnail
    = Thumbnail
        { url : String
        , file : Maybe Object.EncryptedFile
        , info : Maybe Object.ThumbnailInfo
        }


getThumbnailUrl : Thumbnail -> String
getThumbnailUrl (Thumbnail t) =
    t.url


getThumbnailDimensions : Thumbnail -> Maybe { width : Int, height : Int }
getThumbnailDimensions (Thumbnail t) =
    Nothing


getThumbnailMimetype : Thumbnail -> Maybe String
getThumbnailMimetype (Thumbnail t) =
    t.info
    |> Maybe.andThen .mimetype


getThumbnailSize : Thumbnail -> Maybe Int
getThumbnailSize (Thumbnail t) =
    t.info
    |> Maybe.andThen .size
