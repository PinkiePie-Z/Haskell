-- Function
-- FunctionName parameter1 parameter2 ... = operations

doubleMe x = x + x

doubleUs x y = x*2 + y*2

doubleSmallNumber x = if x > 100
                        then x
                        else x*2
doubleSmallNumber' x = (if x > 100 then x else x*2) +1

conanO'Brien = "It is a-me, Conan O'Brien!"


-- List
-- homogenous data structure

-- let lostNumbers = [4,8,15,16,23,42]

-- ++
-- put two lists together
-- [1,2,3,4] ++ [9,10,11,12]
-- "hello" ++ " " ++ "world"
-- ['w','o'] ++ ['o','t']

-- :
-- put something at the beginning of a list
-- 'A':" SMALL CAT"
-- 5:[1,2,3,4,5]

-- !!
-- get an element out of a list by index
-- "Steve Buscemi" !! 6
-- [9.4,33.2,96.2,11.2,23.25] !! 1

-- >,>=,<,<=
-- compare lists, in lexigographical order, from head to tail

-- head
-- takes a list and returns its head

-- tail
-- takes a list and returns everything after the head

-- last
-- takes a list and returns its last element

-- init
-- takes a list and returns everything before the last

-- length
-- takes a list and returns its length

-- null
-- checks if a list is empty, return True or False

-- reverse
-- reverse a list

-- take
-- takes number and a list, returns that many elements from the beginning of the list

-- drop
-- takes number and a list, drops that many elements from the beginning of the list and returns the rest

-- maximum
-- takes a list and returns the biggest element

-- minimum
-- takes a list and returns the smallest element

-- sum
-- takes a list and returns the sum

-- product
-- takes a list and returns their product

-- elem
-- takes a thing and a list, check if that thing is an element of the list, return True of False
-- infix function

-- Texas ranges
-- [1..20]
-- ['a'..'z']
-- ['K'..'Z']
-- [2,4..20]
-- [3,6..20]
-- [20,19..1]
-- [13,26..]

-- cycle
-- takes a list and cycle it infinitly, returns a list

-- repeat
-- takes an element and cycle it infinitly, returns a list

-- replicate
-- takes number and an element, returns that many the element in a list

-- List Comprehension
-- [output function | input set, predicate]
-- [ x*2 | x <- [1..10]]
-- [ x*2 | x <- [1..10], x*2 >= 12]
-- [ x | x <- [50..100], x `mod` 7 == 3]
-- [ x | x <- [10..20], x /= 13, x /= 15, x /= 19]
-- [ x*y | x <- [2,5,10], y <- [8,10,11]]
-- [ x*y | x <- [2,5,10], y <- [8,10,11], x*y > 50]

boomBangs xs = [ if x < 10 then "BOOM!" else "BANG!" | x <- xs, odd x]
-- x belongs to xs, and x is odd, if x<10, output "BOOM!" else output "BANG!"

length' xs = sum [ 1 | _ <- xs]

removeNonUppercase st = [ c | c <- st, c `elem` ['A'..'Z']]

-- Tuples
-- store several values into a single value
-- can contain combination of several types
-- (1,2)
-- ("One",2)
-- ("Christopher", "Walken", 55)

-- fst
-- takes a pair and returns its first component

-- snd
-- takes a pair and returns its second component

-- zip
-- takes two list and then zips them together into one list by joining the matching elements into pairs
-- can zip infinite lists with finite lists
-- zip [1,2,3,4] [5,5,5,5] = [(1,5), (2,5), (3,5), (4,5)]

-- Example: Triangles
-- let triangles = [ (a,b,c) | a <- [1..10], b <- [1..10], c <- [1..10] ]
-- let rightTriangles = [ (a,b,c) | a <- [1..10], b <- [1..10], c <- [1..10], a^2 + b^2 == c^2 ]
-- let rightTriangles = [ (a,b,c) | a <- [1..10], b <- [1..10], c <- [1..10], a^2 + b^2 == c^2, a+b+c == 24 ]
