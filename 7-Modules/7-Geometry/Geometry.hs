-- Making Our Own Modules

-- module exports functions
-- defines functions that its functions call internally, but we can only see and use the ones that it exports

-- Step 1: specify the module name
module Geometry
-- Step 2: specify the functions that it exports
( sphereVolume
, sphereArea
, cubeVolume
, cubeArea
, cuboidArea
, cuboidVolume
) where

-- Step 3: writing functions
sphereVolume :: Float -> Float
sphereVolume radius = (4.0 /3.0) * pi * (radius ^3)

sphereArea :: Float -> Float
sphereArea radius = 4 * pi * (radius ^ 2)

cubeVolume :: Float -> Float
cubeVolume side = cuboidVolume side side side

cubeArea :: Float -> Float
cubeArea side = cuboidArea side side side

cuboidVolume :: Float -> Float -> Float -> Float
cuboidVolume a b c = rectangleArea a b*c

cuboidArea :: Float -> Float -> Float -> Float
cuboidArea a b c = rectangleArea a b*2 + rectangleArea a c*2 + rectangleArea c b*2

-- internal function
rectangleArea :: Float -> Float -> Float
rectangleArea a b = a*b

-- NOTE
-- use
-- :l <module 1> <module 2> <module 3> ...
-- to load multiple modules
