-- Pattern matching
-- always include a catch-all pattern

lucky :: Integral a => a -> String
lucky 7 = "LUCKY NUMBER SEVEN!"
lucky x = "Sorry, you're out of luck, pal!"

sayMe :: Integral a => a -> String
sayMe 1 = "One!"
sayMe 2 = "Two!"
sayMe 3 = "Three!"
sayMe 4 = "Four!"
sayMe 5 = "Five!"
sayMe x = "Not between 1 and 5"

factorial :: Integral a => a -> a
factorial 0 = 1
factorial n = n * factorial(n - 1)

addVectors :: Num a => (a, a) -> (a, a) -> (a, a)
addVectors (x1, y1) (x2, y2) = (x1 + x2, y1 + y2)

first :: (a, b, c) -> a
first (x, _, _) = x

second :: (a, b, c) -> b
second (_, y, _) = y

third :: (a, b, c) -> c
third (_, _, z) = z

-- let xs = [(1,2), (3,4), (5,6)]
-- [a+b | (a,b) <- xs]

-- xs
-- x:xs match the head and the rest
-- x:y:z:xs match the first three elements and the rest

head' :: [a] -> a
head' [] = error "Can't call head on an empty list, dummy!"
head' (x:_) = x

-- error
-- takes a string and generates a runtime error

tell :: Show a => [a] -> String
tell [] = "The list is empty"
tell (x:[]) = "The list has one element: " ++ show x
tell (x:y:[]) = "The list has two elements: " ++ show x
tell (x:y:_) = "This list is long. The first two elements are: " ++ show x ++ " and " ++ show y

length' :: [a] -> Int
-- length' :: (Num b) => [a] -> b
length' [] = 0
length' (_:xs) = 1 + length' xs

sum' :: (Num a) => [a] -> a
sum' [] = 0
sum' (x:xs) = x + sum' xs

capital :: String -> String
capital "" = "Empty string, whoops!"
capital all@(x:y:ys) = "The first letter of " ++ all ++ " is " ++ [x]
-- x is a character
-- [x] is a String

-- Guard
-- test whether some property of a value are true or false

bmiTell :: RealFloat a => a -> String
bmiTell bmi
    | bmi <= 18.5 = "You're underweight, you emo, you!"
    | bmi <= 25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"
    | bmi <= 30 = "You're fat! Lose some weight, fatty!"
    | otherwise = "You're a whale, congratulations!"

bmiTell2 :: RealFloat a => a -> a -> String
bmiTell2 weight height
    | weight / height^2 <= 18.5 = "You're underweight, you emo, you!"
    | weight / height^2 <= 25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"
    | weight / height^2 <= 30 = "You're fat! Lose some weight, fatty!"
    | otherwise = "You're a whale, congratulations!"

max' :: Ord a => a -> a -> a
max' a b
    | a < b = b
    | otherwise = a

compare' :: Ord a => a -> a -> Ordering
a `compare'` b
    | a > b = GT
    | a < b = LT
    | otherwise = EQ

-- Where
-- after the guard, define names or functions, only visible to the function
-- all where bindings need to align at a single column
bmiTell3 :: RealFloat a => a -> a -> String
bmiTell3 weight height
    | bmi <= 18.5 = "You're underweight, you emo, you!"
    | bmi <= 25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"
    | bmi <= 30 = "You're fat! Lose some weight, fatty!"
    | otherwise = "You're a whale, congratulations!"
    where bmi = weight / height^2

bmiTell4 :: RealFloat a => a -> a -> String
bmiTell4 weight height
    | bmi <= skinny = "You're underweight, you emo, you!"
    | bmi <= normal = "You're supposedly normal. Pffft, I bet you're ugly!"
    | bmi <= fat = "You're fat! Lose some weight, fatty!"
    | otherwise = "You're a whale, congratulations!"
    where bmi = weight / height^2
          skinny = 18.5
          normal = 25.0
          fat = 30.0

bmiTell5 :: RealFloat a => a -> a -> String
bmiTell5 weight height
    | bmi <= skinny = "You're underweight, you emo, you!"
    | bmi <= normal = "You're supposedly normal. Pffft, I bet you're ugly!"
    | bmi <= fat = "You're fat! Lose some weight, fatty!"
    | otherwise = "You're a whale, congratulations!"
    where bmi = weight / height^2
          (skinny, normal, fat) = (18.5, 25.0, 30.0)
-- where bindings can use pattern match

initials :: String -> String -> String
initials firstname lastname = [f] ++ ". " ++ [l] ++ "."
    where (f:_) = firstname
          (l:_) = lastname

calsBmis :: (RealFloat a) => [(a, a)] -> [a]
calsBmis xs = [bmi weight height | (weight, height) <- xs]
    where bmi weight height = weight / height^2

-- let...in...
-- let <bindings> in <expressions>
-- local, bind to variables anywhere and are expressions themselves
-- can be used for pattern matching

cylinder :: (RealFloat a) => a -> a -> a
cylinder r h =
    let sideArea = 2 * pi * r * h
        topArea = pi * r^2
    in  sideArea + 2 * topArea

-- 4 * (let a = 9 in a + 1) + 2
-- [let square x = x^2 in (square 5, square 3, square 2)]

-- (let a = 100; b = 200; c = 300 in a*b*c, let foo="Hey "; bar = "there!" in foo++bar)
-- use ; instead of aligning them in columns to separate them

calBmis2 :: (RealFloat a) => [(a, a)] -> [a]
calBmis2 xs = [bmi | (w, h) <- xs, let bmi = w / h^2 ]
-- let bindings can be used inside list comprehensions
-- names defined in the let are visible to the output function (before |) and all predicates and sections after the binding

-- in part of the let binding can be omitted when
-- 1. used in list comprehensions because the visibility of the names is already predefined
-- 2. defining functions and constants directly in GHCI and the names will be visible throughout the entire interactive session

-- let
-- local expressions, can't be used cross guards
-- names comes before the function ther're being used in, less readable

-- Case expressions
-- case expression of pattern -> result
--                    pattern -> result
--                    ...

describeList :: [a] -> String
describeList xs = "The list is " ++ case xs of [] -> "empty."
                                               [x] -> "a singleton list."
                                               xs -> "a longer list."

describeList' :: [a] -> String
describeList' xs = "This list is " ++ what xs
    where what [] = "empty."
          what [x] = "a singleton list."
          what xs = "a longer list."
