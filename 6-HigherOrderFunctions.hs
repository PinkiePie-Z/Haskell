-- Higher Order Functions
-- functions take functions as parameters or return functions as return values
-- define computations by defining what stuff is instead of defining steps that change some state and maybe looping them

-- Curried Functions
-- every function in Haskell officially only takes one parameter
-- all the functions that accepted several parameters so far have been curried functions

-- Example
-- max : takes two parameters and returns the bigger one
--
-- max 4 5
-- step1: creates a function that takes a parameter and returns either 4 or that parameter, depending on which is bigger
-- step2: 5 is applied to that function and that function produces the result
--
-- That is:
-- max 4 5 == (max 4) 5
-- max :: Ord a => a -> a -> a == max :: Ord a => a -> (a -> a)
-- max takes an a and returns a function that takes an a and returns an a
-- 
multThree :: Num a => a -> a -> a -> a
multThree x y z = x * y * z
-- multThree :: Num a => a -> (a -> (a -> a))

compareWithHundred :: (Num a, Ord a) => a -> Ordering
compareWithHundred x = compare 100 x
-- compare :: Ord a => a -> (a -> Ordering)

-- infix function can be partially applied by using sections
-- surround it with parentheses and only supply a parameter on one side
-- creates a function that takes one parameter and applies it to the side that;s missing an operand
divideByTen :: Floating a => a -> a
divideByTen = (/10)

isUpperAlphanum :: Char -> Bool
isUpperAlphanum = (`elem` ['A'..'Z'])

subtractByFour :: Floating a => a -> a
subtractByFour = (subtract 4)
-- (subtract 4) :: Num a => a -> a

-- let multTwelve = (multThree 3 4)
-- multTwelve 5 = 60:

-- Some Higher-orderism Is In Order
-- functions can take functions as parameters and also return functions

applyTwice :: (a -> a) -> a -> a
applyTwice f x = f (f x)

zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' _ [] _ = []
zipWith' _ _ [] = []
zipWith' f (x:xs) (y:ys) = (f x y):(zipWith' f xs ys)

-- flip :: (a -> b -> c) -> b -> a -> c
-- that is
-- flip :: (a -> b -> c) -> (b -> a -> c)
flip1 :: (a -> b -> c) -> (b -> a -> c)
flip1 f = g
    where g x y = f y x

flip2 :: (a -> b -> c) -> (b -> a -> c)
flip2 f x y = f y x

-- Maps And Filters

-- map: takes a function and a list and applies that function to every element in the list, producing a new list
-- map :: (a -> b) -> [a] -> [b]
-- map (+3) [1,5,3,1,6] == [x+3 | x<-[1,5,3,1,6]]

-- filter: takes a predicate and a list and returns the list of elements that satisfy the predicate
-- filter :: (a -> Book) -> [a] -> [b]
-- filter (==3) [1,2,3,4,5] == [x| x<-[1,2,3,4,5], x==3]

largestDivisible :: Integral a => a
largestDivisible = head (filter p [100000,99999..])
    where p x = x `mod` 3829 == 0

-- takeWhile: takes a predicate and a list and then goes from the beginning of the list and returns its elements while the predicate holds true, once an element is found which the predicate doesn't hold, it stops
-- takeWhile :: (a -> Bool) -> [a] -> [a]

-- Collatz sequence
-- take a natural number
-- if it is even, divided by two
-- if it is odd, multiply it by 3 and then add 1 to that
-- take the resulting number and apply the same thing to it, and so on
-- then we get a chain of numbers
-- it is thought that for all starting numbers, the chains finish at the number 1
-- Example: given 13, we get the sequence: 13, 40, 20, 10, 5, 16, 8, 4, 2, 1
-- Question: for all starting numbers between 1 and 100, how many chains have a length greater than 15

-- produce a chain
chain :: Integral a => a -> [a]
chain 1 = [1]
chain n
    | odd n = n: chain (n*3+1)
    | otherwise = n: chain (n `div` 2)
-- collatzSeq
collatzSeq :: Int
collatzSeq = length (filter isLong (map chain [1..100]))
    where isLong xs = length xs > 15

-- map (*) [0..]  :: (Num a, Enum a) => [a -> a]
-- let listOfFuns = map (*) [0..]
-- (listOfFuns !! 4) 5 = 20

-- Lambdas
-- expression, can extend all the way to the right
-- anonymous functions, used only once
-- the purpose is to pass it to a higher-order function
-- usage: (\<parameters> -> <function body>)

collatzSeq1 :: Int
collatzSeq1 = length (filter (\xs -> length xs>15) (map chain [1..100]))

-- lambdas can take any number of parameters
-- zipWith (\a b -> (a*30 + 3)/b) [5,4,3,2,1] [1,2,3,4,5]

-- lambdas can pattern match
-- can only define one pattern for one parameter
-- if a pattern match fails, a runtime error occurs
-- map (\(a,b) -> a+b) [(1,2),(3,4)]

flip3 :: (a -> b -> c) -> b -> a -> c
-- flip3 :: (a -> b -> c) -> (b -> a -> c)
flip3 f = \x y -> f y x

-- Only Folds And Horses
-- functions used to encapsulate x:xs pattern
-- takes a binary function, a starting value and a list to fold up
-- the binary function takes two parameters, the accumulator and the first(or last) element and produces a new accumulator

-- foldl :: Foldable t => (b -> a -> b) -> b -> t a -> b
-- left fold, folds the list up from the left side
sum1 :: Num a => [a] -> a
sum1 xs = foldl (\acc x -> acc+x) 0 xs
-- Example: sum1 [3,5,2,1]
-- start with [3]
-- step 1: acc=0, x=3, 0+3=3, new_acc=3
-- step 2: acc=3, x=5, 3+5=8, new_acc=8
-- step 3: acc=8, x=2, 8+2=10, new_acc=10
-- step 4: acc=10, x=1, 10+1=11, new_acc=11

-- binary function: \acc x -> acc+x
-- starting value: 0
-- list to be folded up: xs
sum2 :: Num a => [a] -> a
sum2 = foldl (+) 0
-- because of currying, xs can be omitted
-- sum2 xs = foldl (+) 0 xs

-- the accumulator is the first parameter
-- \acc x -> ...
elem1 :: Eq a => a -> [a] -> Bool
elem1 y ys = foldl (\acc x -> if x == y then True else acc) False ys

-- foldr :: Foldable t => (a -> b -> b) -> b -> t a -> b
-- right fold, folds the list from the right side
-- the accumulator is the second parameter
-- \x acc -> ...
elem2 :: Eq a => a -> [a] -> Bool
elem2 y ys = foldr (\x acc -> if x == y then True else acc) False ys

map1 :: (a -> b) -> [a] -> [b]
map1 f xs = foldr (\x acc -> (f x):acc) [] xs
-- Example: map1 (+3) [1,2,3]
-- start with 3
-- step 1: x=3, (f x)=3+3=6, acc=[], 6:[]=[6], new_acc=[6]
-- step 2: x=2, (f x)=2+3=5, acc=[6], 5:[6]=[5,6], new_acc=[5,6]
-- step 3: x=1,(f x)=1+3=4, acc=[5,6], 4:[5,6], new_acc=[4,5,6]

map2 :: (a -> b) -> [a] -> [b]
map2 f xs = foldl (\acc x -> acc ++ [f x]) [] xs
-- Example: map2 (+3) [1,2,3]
-- start with 1
-- step 1: x=1, [f x]=[1+3]=[4], acc=[], []++4=[4], new_acc=[4]
-- step 2: x=2, [f x]=[2+3]=[5], acc=[4], [4]++[5]=[4,5], new_acc=[4,5]
-- step 3: x=3, [f x]=[3+3]=[6], acc=[4,5], [4,5]++[6]=[4,5,6], new_acc=[4,5,6]

-- Note: ++ is expensive than :
-- use : when building up new lists from a list

-- foldr works on infinite list
-- take an infinite list at some point and fold it up from the right
-- you'll eventually reach the beginning of the list
-- doesn't work for foldl
-- cause you'll never reach an end

-- foldl1 and foldr1 works much like foldl and foldr
-- don't need to provide them with an explicit starting value
-- assume the first or last element of the list to be the starting value
sum3 :: Num a => [a] -> a
sum3 xs = foldl1 (\acc x -> x+acc) xs
-- sum3 = foldl1 (+)
sum4 :: Num a => [a] -> a
sum4 xs = foldr1 (\x acc -> x+acc) xs
-- sum4 = foldr1 (+)

maximum1 :: Ord a => [a] -> a
maximum1 xs = foldl1 (\acc x -> if x>acc then x else acc) xs
maximum2 :: Ord a => [a] -> a
maximum2 xs = foldr1 (\x acc -> if x>acc then x else acc) xs

reverse1 :: [a] -> [a]
reverse1 xs = foldl (\acc x -> x:acc) [] xs
reverse2 :: [a] -> [a]
reverse2 xs = foldr (\x acc -> acc++[x]) [] xs

product1 :: Num a => [a] -> a
product1 = foldl1 (*)
product2 :: Num a => [a] -> a
product2 = foldr1 (*)

filter1 :: (a -> Bool) -> [a] -> [a]
filter1 f xs = foldl (\acc x -> if (f x)==True then acc++[x] else acc) [] xs
filter2 :: (a -> Bool) -> [a] -> [a]
filter2 f xs = foldr (\x acc -> if (f x)==True then x:acc else acc) [] xs

head1 :: [a] -> a
head1 = foldr1 (\x _ -> x)

last1 :: [a] -> a
last1 = foldl1 (\_ x -> x)

-- foldr
-- binary function is f, starting value is z
-- Example: [3,4,5,6]
-- f 3 (f 4 (f 5 (f 6 z)))
-- foldl
-- binary function is g, starting value is z
-- Example: [3,4,5,6]
-- g (g (g (g z 3) 4) 5) 6
reverse3 :: [a] -> [a]
reverse3 = foldl (flip (:)) []

-- scanl and scanr are like foldl and foldr
-- scanl1 and scanr1 are like foldl1 and foldr1
-- report all the intermediate accumulator states in the form of a list

-- Example
-- scanr (*) 2 [3,4,5]
-- [5*4*3*2,5*4*2,5*2,2] = [120,40,10,2]
-- scanl (*) 2 [3,4,5]
-- [2,2*3,2*3*4,2*3*4*5]
-- scanl1 (\acc x -> if x>acc then x else acc) [3,4,5,3,7,9,2,1]
-- [3,4,5,5,7,9,9,9]
-- scanr1 (\x acc -> if x>acc then x else acc) [3,4,5,3,7,9,2,1]
-- [9,9,9,9,9,9,2,1]
-- scanl (flip (:)) [] [3,2,1]
-- [[],[3],[2,3],[1,2,3]]

-- scan functions are used to monitor the progression of a function that can be implemented as a fold

-- Question: How many elements does it take for the sum of the roots of all natural numbers to exceed 1000?
-- Answer:
sqrtNum :: Int
sqrtNum = length (takeWhile (<1000) (scanl (+) 0 (map sqrt [1..]))) + 1
-- map sqrt [1..] : roots of all natural number
-- scanl (+) 0 ... : calculate the sum
-- takeWhile (<1000) ... : take all the sum below 1000, return a list
-- length ... : length of the list
-- ... +1 : plus the first one exceed 1000

-- Function Application With $
-- ($) :: (a -> b) -> a -> b
-- right-associative function

-- Note: f a b c == ((f a) b) c left-associative

-- Example
-- sqrt 4 + 12 = 2 + 12 = 14.0
-- sqrt $ 4 + 12 = sqrt 16 = 4.0

-- sum (filter (>10) (map (*2) [2..10])) == sum $ filter (>10) (map (*2) [1..10])
-- omit the (..)

-- map ($ 3) [(4+), (10*), (^2), sqrt] = [7.0,30.0,9.0,1.7320508075688772]
-- $ means that function application can be treated just like another function
-- can map function application over a list of functions

-- Function Composition
-- composing two functions produces a new function
-- (.) :: (b -> c) -> (a -> b) -> a -> c
-- f . g = \x -> f (g x)
-- f must take as its parameter a value that has the same type as g's return value
-- the resulting function takes a parameter of the same type that g takes and returns a value of the same type that f returns
-- (f . g . z) x = f (g (z x))

-- a point free style function is more readable and concise
-- fn x = ceiling (negate (tan (cos (max 50 x))))
-- that is
-- fn = ceiling . negate .tan . cos . max 50
-- think more about function

oddSquareSum :: Integer
oddSquareSum = sum (takeWhile (<10000) (filter odd (map (^2) [1..])))

oddSquareSum1 :: Integer
oddSquareSum1 = sum . takeWhile (<10000) . filter odd . map (^2) $ [1..]

oddSquareSum2 :: Integer
oddSquareSum2 =
    let oddSquares = filter odd . map (^2) $ [1..]
        belowLimit = takeWhile (<10000) oddSquares
    in sum belowLimit
