-- Type
-- :t
-- tell the type

-- ::
-- has type of

removeNonUppercase :: [Char] -> [Char]
removeNonUppercase st = [ c | c <- st, c `elem` ['A'..'Z'] ]
-- [Char] -> [Char]
-- takes one string as a parameter and returns another as a result
-- equals String -> String

addThree :: Int -> Int -> Int -> Int
addThree x y z = x + y + z

-- Int, more efficient
-- 32-bit: maximum = 2147483647, minimum = -2147483648
-- Integer
-- not bounded

factorial :: Int -> Int
factorial n = product [1..n]

-- Float
-- single precision

circumference :: Float -> Float
circumference r = 2 * pi * r

-- Double
-- double precision

circumference' :: Double -> Double
circumference' r = 2 * pi * r

-- Bool
-- True and False

-- Char
-- represents a character, denoted by single quotes
-- a list of characters is a string

-- Type Variables
-- [a] -> a, a is a type variable, means a can be any type
-- polymorphic functions

-- :t head
-- head :: [a] -> a
-- takes a list of any type a and returns one element of type a

-- :t fst
-- fst :: (a, b) -> a
-- a and b are different type variables but don't have to be different types

-- Typeclasses
-- defines type behaviors

-- :t (==)
-- (==) :: (Eq a) => a -> a -> Bool
-- class constraint => ...
-- the equality function takes any two values that are of the same type and returns a Bool, the type of those two values must be a member of Eq class

-- Eq
-- typeclass
-- types that support equality testing, == and /=
-- elem :: (Foldable t, Eq a) => a -> t a -> Bool

-- Ord
-- typeclass
-- types that have an ordering, have membership in Eq
-- :t (>)
-- (>) :: Ord a => a -> a -> Bool

-- compare
-- takes two Ord members of the same type and returns an ordering
-- compare :: Ord a => a -> a -> Ordering
-- Ordering: GT LT EQ

-- show
-- takes a value whose type is a member of Show and returns it as a String
-- :t show
-- show :: Show a => a -> String

-- Show
-- typeclass

-- read
-- takes a string and returns a type which is a member of Read
-- :t read
-- read :: Read a => String -> a

-- Read
-- typeclass

-- Note:
-- read "4" - Error
-- no parse, GHCI need to know what it had to return
-- read "4" :: Int - Correct
-- GHCI returns an Int

-- Enum
-- typeclass
-- sequentially ordered types, can be used in list ranges, have defined successors and predecesors
-- (), Bool, Char, Ordering, Int, Integer, Fload, Double

-- :t succ
-- succ :: Enum a => a -> a
-- :t pred
-- pred :: Enum a => a -> a

-- Bounded
-- typeclass
-- members have an upper and a lower bound

-- minBound :: Bounded a => a
-- maxBound :: Bounded a => a

-- Num
-- typeclass
-- real numbers and integeral numbers, have membership in Show and Eq
-- :t 20
-- 20 :: Num p => p
-- :t (*)
-- (*) :: Num a => a -> a -> a

-- Integeral
-- typeclass
-- integeral numbers, Int and Integer

-- Floating
-- typeclass
-- floating point numbers, Float and Double

-- fromEnum :: Enum a => a -> Int
-- fromInteger :: Num a => Integer -> a
-- fromIntegral :: (Integral a, Num b) => a -> b
-- fromRational :: Fractional a => Rational -> a

-- :t length
-- length :: Foldable t => t a -> Int
