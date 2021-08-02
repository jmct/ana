Drawing Model
=============

Nouns
-----

The drawing model involves the following `Nouns`:

* Destination: The thing you're drawing on (Pixels, SVG, PDF, etc.)
* Source: The thing you're drawing with (the 'paint', though it doesn't have
          to be a single color, it can be another image or pattern)
* Mask: What determines what bits of the source get on the destination (think
        of the screen in screen-printing)
* Path: ??? I'm unsure
* Context: The 'environment' that everything happens in. This keeps track of
           things like line width, mask shape, etc. etc.

Verbs
-----

Verbs affect how the source and mask interact. There are 5:

* Stroke: Takes a pen along a path. The mask is the resulting shape.
* Fill: Fills within the path, the mask is the resulting 'filled' shape.
* Show Text/Glyphs: The mask is the rendered text/glyphs
* Paint: Entire source is transferred to the destination
* Mask: Use a second source (with transparency) to act as a mask

Drawing
=======

Almost all of the above (possibly all?), require a source in order to make
sense. So one of the first things we'll have to do when drawing with Cairo is
to select a source.

Sources
-------

* Colors
* Gradients
* Images

### Gradients

#### Radial Gradients

A radial gradient is based on _two_ circles. The centers and diameters are
completely independent. Let's look at how changing those things affects an
image.

Take the following code:


```{haskell}
testRadialX :: Double -> Render ()
testRadialX x =
 do rad <- createRadialPattern (225 - x) 150 50 (225 + x) 150 200    
    patternAddColorStopRGB rad 0 0 1 0 -- Inner color of gradient
    patternAddColorStopRGB rad 1 1 0 0 -- Outer color of gradient

    rectangle 0 0 450 300              -- A rectangle to draw in
    setSource rad                      -- Using the gradiant to 'draw'
    fill
```
    
Calling with with 0 as an input creates a gradient based on two circles with
the same center point but different radii. The 'inner' gradient is the color
set by the first call to `patternAddColorStopRGB`, the order isn't what
matters, but the 0 or 1 as the first argument. Second call sets the outer
color. Here's what we get:

[Radial Gradient Test 1](images/test-radial-x-1.png)

[Radial Gradient Test 2](images/test-radial-x-2.png)

[Radial Gradient Test 3](images/test-radial-x-3.png)
