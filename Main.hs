module Main where

import qualified MyLib (someFunc)

import Graphics.Rendering.Cairo

drawRekt :: Render ()
drawRekt =
 do setSourceRGB 0.5 0.1 0.3
    setLineWidth 5
    rectangle 50 50 100 200
    stroke

fillRekt :: Render ()
fillRekt =
 do rectangle 0 0 450 300
    fill

drawScot (rad1, rad2) =
 do setSource rad1
    fillRekt
    setSourceRGB 1 1 1
    moveTo 0 0
    lineTo 450 300
    moveTo 0 300
    lineTo 450 0
    setLineWidth 40
    stroke

twoInverted :: Double -> Double -> Render (Pattern, Pattern)
twoInverted x y =
 do rad1 <- createRadialPattern x y 50 x y 200    
    patternAddColorStopRGB rad1 0 0 1 0
    patternAddColorStopRGB rad1 1 1 0 0

    rad2 <- createRadialPattern x y 50 x y 200    
    patternAddColorStopRGB rad2 1 0 1 0
    patternAddColorStopRGB rad2 0 1 0 0

    pure (rad1, rad2)
    
testRadial :: Double -> Render ()
testRadial x =
 do rad <- createRadialPattern (225 - x) 150 50 (225 + x) 150 200    
    patternAddColorStopRGB rad 0 0 1 0
    patternAddColorStopRGB rad 1 1 0 0
    rectangle 0 0 450 300
    setSource rad
    fill
    
  

main :: IO ()
main =
 do surface <- createImageSurface FormatARGB32 450 300
-- do surface <- imageSurfaceCreateFromPNG "test.png"
    renderWith surface (testRadial 100) -- (twoInverted 225 150 >>= drawScot)
    surfaceWriteToPNG surface "test.png"
