-- Modules
-- A Haskell module is a collection of related functions, types and typeclasses
-- A Haskell program is a collection of modules, main module loads up the other modules and then uses the functions defined in them to do something

-- importing modules
-- import <module name>

import Data.List
import Data.Function -- see line 184
import Data.Char -- see line 314
import qualified Data.Map as Map -- see line 420, functions clash with Prelude and Data.List ones
import qualified Data.Set as Set -- see line 501, functions clash with Prelude and Data.List ones

numUnique :: Eq a => [a] -> Int
numUnique = length.nub
-- nub :: Eq a => [a] -> [a]
-- takes a list and weeds out duplicate elements

-- put the functions of modules into the global namespace in GHCI
-- :m + <module 1> <module 2> <module 3> ...
-- Example
-- ghci> :m Data.List Data.Map Data.Set

-- import some functions from a module
-- import <module name> (<function 1>, <function 2>, ...)
-- Example
-- import Data.List (nub, sort)

-- exclude a few selected functions from a module
-- import <module name> hiding (<function 1>, <function 2>, ...)
-- Example
-- import Data.List hiding (nub)

-- to deal with name clashes is to do qualified imports
-- import qualified <module name>
-- Example
-- import Data.Map
-- ghci> filter (<0) [-1,1,3,-9]
-- Ambiguous occurrence ‘filter’
-- It could refer to either ‘Prelude.filter’,
--                          imported from ‘Prelude’ at 7-Modules.hs:1:1
--                          (and originally defined in ‘GHC.List’)
--                       or ‘Data.Map.filter’,
--                          imported from ‘Data.Map’ at 7-Modules.hs:9:1-15
--                          (and originally defined in ‘Data.Map.Internal’)

-- to reference <module name>'s <function name> function
-- <module name>.<function name> ...
-- rename the qualified import
-- Example
-- import qualified Data.List as L
-- Usage
-- L.filter ...

------------------------------------------------------
-- Data.List
------------------------------------------------------
-- all about lists
-- Prelude module exports some functions from Data.List for convenience, doesn;t clash with any Prelude except for those that Prelude already steals from Data.List

-- intersperse
-- intersperse :: a -> [a] -> [a]
-- takes an element and a list and then puts that element in between each pair of elements in the list
-- intersperse '.' "MONKEY" = "M.O.N.K.E.Y"

-- intercalate
-- intercalate :: [a] -> [[a]] -> [a]
-- takes a list of lists and a list and then inserts that list in between all those lists and then flattens the result
-- intercalate " " ["hey","there","guys"] = "hey there guys"

-- transpose
-- transpose :: [[a]] -> [[a]]
-- transpose a list of lists, columns become rows and vice versa
-- transpose [[1,2,3],[4,5,6]] = [[1,4],[2,5],[3,6]]

-- non-lazy fold functions
-- foldl' :: Foldable t => (b -> a -> b) -> b -> t a -> b
-- foldl1' :: (a -> a -> a) -> [a] -> a
-- strict versions of their respective lazy incarnations
-- lazy folds can cause stack overflow error since accumulators won't be computed until necessary
-- strict folds aren't lazy buggers and actually compute the intermediate values as they go along instead of filling up your stack with thunks
-- Note: Haskell expression are translated into a graph in the purpose of sharing and infinite lists

-- concat
-- concat :: Foldable t => t [a] -> [a]
-- flattens a list of lists into just a list of elements
-- concat ["foo", "bar"] = "foobar"

-- concatMap
-- concatMap :: Foldable t => (a -> [b]) -> t a -> [b]
-- map a function to a list and then concatenating the list with concat
-- concatMap (replicate 2) [1..3] = [1,1,2,2,3,3]

-- and
-- and :: Foldable t => t Bool -> Bool
-- takes a list of boolean values and returns True only if all the values in the list are True
-- and [True, True] = True
-- and [True, False] = False

-- or
-- or :: Foldable t => t Bool -> Bool
-- takes a list of boolean values and returns True any of the boolean values in a list is True
-- or [True, False] = True
-- or [False, False] = False

-- any and all
-- any :: Foldable t => (a -> Bool) -> t a -> Bool
-- all :: Foldable t => (a -> Bool) -> t a -> Bool
-- take a predicate and then check if any or all the elements in a list satisfy the predicate, like map
-- any (==4) [,2,3,5,6,1,4] = True
-- all (>4) [6,9,10] = True

-- iterate
-- iterate :: (a -> a) -> a -> [a]
-- takes a function and a starting value, applys the function to the starting value and then it applies that function to the result, etc. It returns all the results in the form of an infinite list
-- iterate (*2) 1 = [1,2,4,6,8..]

-- splitAt
-- splitAt :: Int -> [a] -> ([a], [a])
-- takes a number and a list, then splits the list at that many elements, returning the resulting two list in a tuple
-- starts from 1
-- splitAt 3 [1,2,3,4,5] = ([1,2,3],[4,5])

-- takeWhile
-- takeWhile :: (a -> Bool) -> [a] -> [a]
-- takes elements from a list where the predicate holds and when an element is encountered that doesn't satisfy the predicate, it's cut off
-- takeWhile (<3) [1,2,3,4] = [1,2]

-- dropWhile
-- dropWhile :: (a -> Bool) -> [a] -> [a]
-- drops elements from a list where the predicate holds and when an element is encountered that doesn't satisfy the predicate, it returns the rest

-- span
-- span :: (a -> Bool) -> [a] -> ([a],[a])
-- works like takeWhile and dropWhile, returns a tuple of two lists. The first list contains everything in takeWhile, the second list contains everything in dropWhile
-- span (<3) [1,2,3,4,3,2,1] = ([1,2],[3,4,3,2,1])

-- break
-- break :: (a -> Bool) -> [a] -> ([a],[a])
-- equals to span (not . <predicate>) [list content]
-- break (>=3) [1,2,3,4,3,2,1] = ([1,2],[3,4,3,2,1])

-- sort
-- sort :: Ord a => [a] -> [a]
-- implement a stable sorting algorithm to sort a list, elements are arranged from lowest to highest, keeping duplicates in the order they appeared in the input-- sort [1,6,4,3,2,5] = [1,2,3,4,5,6]

-- group
-- group :: Eq a => [a] -> [[a]]
-- takes a list and groups adjacent elements into sublists if they are equal
-- group [1,2,2,3,3,3] = [[1],[2,2],[3,3,3]]
-- group [1,2,1,2] = [[1],[2],[1],[2]]

-- inits and tails
-- inits :: [a] -> [[a]]
-- tails :: [a] -> [[a]]
-- recursively apply init and tail to a list until there's nothing left
-- inits [1,2,3] = [[],[1],[1,2],[1,2,3]]
-- tails [1,2,3] = [[1,2,3],[2,3],[3],[]]

-- Question: use fold to implement searching a list for a sublist
search :: Eq a => [a] -> [a] -> Bool
search needle haystack =
    let nlen = length needle
    in  foldl (\acc x -> if take nlen x == needle then True else acc) False (tails haystack)

-- isInfixOf
-- isInfixOf :: Eq a => [a] -> [a] -> Bool
-- searches for a sublist within a list and returns a boolean value
-- "is" `isInfixOf` "This is a dog" = True

-- isPrefixOf and isSuffixOf
-- isPrefixOf :: Eq a => [a] -> [a] -> Bool
-- isSuffixOf :: Eq a => [a] -> [a] -> Bool
-- search for a sublist at the beginning and at the end of a list
-- "hey" `isPrefixOf` "hey there!" = True
-- "there!" `isSuffixOf` "hey there!" = True

-- elem and notElem
-- elem :: (Foldable t, Eq a) => a -> t a -> Bool
-- notElem :: (Foldable t, Eq a) => a -> t a -> Bool
-- check if an element is or isn't inside a list
-- 'A' `elem` ['A'..'Z'] = True
-- 'a' `notElem` ['A'..'Z'] = False

-- partition
-- partition :: (a -> Bool) -> [a] -> ([a],[a])
-- takes a list and a predicate and returns a pair of lists, the first list contains all the elements satisfy the predicate, the second list contains all the ones that don't
-- partition (>3) [3,5,4,1,6,7,9] = ([5,4,6,7,9],[3,1])

-- find
-- find :: Foldable t => (a -> Bool) -> t a -> Maybe a
-- takes a list and a predicate and returns the first element that satisfies the predicate
-- Note: Maybe value can either be Just something or Noting
-- find (==4) [1,2,5] = Nothing
-- find (==5) [1,2,5] = Just 5
-- Maybe value contains either no element or one element
-- find (>1) [1,2,5] = Just 2

-- elemIndex
-- elemIndex :: Eq a => a -> [a] -> Maybe Int
-- like elem, maybe returns the index of the element we're looking for
-- 4 `elemIndex` [1,2,3,4,5,6] = Just 3
-- 10 `elemIndex` [1,2,3,4,5,6] = Nothing

-- elemIndices
-- elemIndices :: a -> [a] -> [Int]
-- like elemIndex, returns a list of indices, in case the element we're looking for crops up in our list several times
-- Note: don't need Maybe, list can contain nothing, one element or several elements
-- ' ' `elemIndices` "Where are the spaces?" = [5,9,13]

-- findIndex and findIndices
-- findIndex :: (a -> Bool) -> [a] -> Maybe Int
-- findIndices :: (a -> Bool) -> [a] -> [Int]
-- returns the index(indices) of the first element(s) that satisfies the predicate
-- findIndex (==4) [5,3,2,1,6,4] = Just 5
-- findIndex (==10) [5,3,2,1,6,4] = Nothing
-- findIndices (`elem` ['A'..'Z']) "Where Are The Caps?" = [0,6,10,14]

-- zip and zipWith
-- zip :: [a] -> [b] -> [(a,b)]
-- zipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
-- zip together two lists either in a tuple or with a binary function
-- Note: Haskell can zip/zipWith variants go up to 7

-- lines
-- lines :: String -> [String]
-- takes a string and returns every line in a separate list
-- useful when dealing with files or inputs
-- lines "first\nsecond\nthird" = ["first","second","third"]

-- unlines
-- unlines :: [String] -> String
-- inverse version of lines, takes a list of strings and joins them using '\n'
-- unlines ["first","second","third"] = "first\nsecond\nthird"

-- words and unwords
-- words :: String -> [String]
-- unwords :: [String] -> String
-- splitting a line of text into words or joining a list of words into a text
-- words "a    b\nc d" = ["a","b","c","d"]
-- unwords ["a","b","c"] = "a b c"

-- nub
-- nub :: Eq a => [a] -> [a]
-- takes a list and weeds out the duplicate elements, returning a list with only unique elements
-- nub "Lots of words" = "Lots fwrd"

-- delete
-- delete :: Eq a => a -> [a] -> [a]
-- takes an element and a list and deletes the first occurence of that element in the list
-- delete 4 [1,2,4,6,4,5] = [1,2,6,4,5]

-- \\
-- (||) :: Eq a => [a] -> [a] -> [a]
-- list difference function, remove matching elements in the left one from the right one
-- [1..10] \\ [2,5,9] = [1,3,4,6,7,8,10]

-- union
-- union :: Eq a => [a] -> [a] -> [a]
-- list union function, goes over every element in the left one and appends it to the right one if it isn't already in yet
-- "hey man" `union` "man what's up" = "hey manwt'sup"

-- intersect
-- intersect :: Eq a => [a] -> [a] -> [a]
-- list intersect function, returns elements found in both lists
-- [1..7] `intersect` [5..10] = [5,6,7]

-- insert
-- insert :: Ord a => a -> [a] -> [a]
-- takes an element and a list that can be sorted and inserts it into the last position where it's still less than or equal to the next element
-- insert 4 [3,5,1,2,8,2] = [3,4,5,1,2,8,2]

--NOTE:
-- length, take, drop, splitAt, !!, replicate
-- take an Int as one of their parameters, doesn't support fractional computation
-- generic version
-- genericLength, genericTake, genericDrop, genericSplitAt, genericIndex, genericReplicate
-- take an Num as one of their parameters, an Num can act like floating point number

-- NOTE:
-- nub, delete, union, intersect, group
-- use == to test for equality only
-- generic version
-- nubBy, deleteBy, unionBy, intersectBy, groupBy
-- take an self defined equality function to compare

-- Example
groupByZero = groupBy (\x y -> (x>0) == (y>0)) [-4.3, -2.4, -1.2, 0.4, 2.3, 5.9, 10.5, 29.1, 5.3, -2.4, -14.5, 2.9, 2.3]
-- Tip
-- use Data.Function.on to implement equality functions for the By functions
-- on :: (b -> b -> c) -> (a -> b) -> a -> a -> c
-- f `on` g = \x y -> f g(x) g(y)
groupByZero' = groupBy ((==) `on` (>0)) [-4.3, -2.4, -1.2, 0.4, 2.3, 5.9, 10.5, 29.1, 5.3, -2.4, -14.5, 2.9, 2.3]

-- NOTE:
-- sortBy, insertBy, maximumBy, minimumBy
-- take a function that determines if one element is greater, smaller or equal to the other

-- Question: sort list of lists by their lengths
sortByLength = sortBy (\x y -> (length x) `compare` (length y)) [[5,4,5,4,4],[1,2,3],[3,5,4,3],[],[2],[2,2]]
sortByLength' = sortBy (compare `on` length) [[5,4,5,4,4],[1,2,3],[3,5,4,3],[],[2],[2,2]]

-- NOTE:
-- By functions takes an equality function, use
-- (==) `on` <function>
-- By functions takes an ordering function, use
-- compare `on` <function>

------------------------------------------------------
-- Data.Char
------------------------------------------------------
-- exports functions deal with characters
-- filtering and mapping over strings
-- exports predicates over characters

-- predicates
-- <function> :: Char -> Bool

-- isControl
-- check whether a character is a control character
-- isControl '\n' = True

-- isSpace

-- isLower

-- isUpper

-- isAlpha
-- check whether a character is a letter
-- isAlpha '0' = False

-- isAlphaNum
-- check whether a character is a letter or a number
-- isAlphaNum '+' = False

-- isPrint
-- check whether a character is printable
-- isPrint '\n' = False

-- isDigit

-- isOctDigit

-- isHexDigit

-- isLetter
-- equivalent to isAlpha

-- isMark
-- checks for Unicode mark characters, used in French

-- isNumber

-- isPunctuation

-- isSymbol
-- check whether a character is a fancy mathematical or currency symbol

-- isSeparator
-- check for Unicode spaces and separators, space/lineSeparator/paragraphSeparator

-- isAscii
-- check whether a character falls into the first 128 characters of the Unicode character set

-- isLatin1
-- check whether a character falls into the first 256 characters of the Unicode character set

-- isAsciiUpper

-- isAsciiLower

checkUsername = all isAlphaNum "bobby283"

-- use isSpace to simulate Data.List.words
words1 = filter (/=" ") (groupBy ((==) `on` isSpace) "This is a dog")
words2 = filter (not . any isSpace) . groupBy ((==) `on` isSpace) $ "hey guyes its me"

-- generalCategory
-- enumeration, presents the category that a character falls into, about 31 categories in total
-- Eq typeclass
-- generalCategory ' ' = Space
-- generalCategory 'A' = UppercaseLetter
-- generalCategory '9' = DecimalNumber
-- generalCategory '.' = OtherPunctuation
-- generalCategory 'a' = LowercaseLetter

-- toUpper
-- converts a character to upper-case, spaces, numbers and the like remain unchanged

-- toLower
-- like toUpper

-- toTitle
-- like toUpper, except for a small number of ligature letters

-- digitToInt
-- converts a character to an Int, the character must be in the ranges of 0..9 or a..f or A..F

-- intToDigit
-- reverse function of digitToInt, converts to lowercase letters
-- the int must be in the ranges of 0..15, 0..9 is '0'..'9', 10..15 is 'a'..'f'

-- ord
-- converts characters to numbers, uniCode table

-- chr
-- converts numbers to characters, uniCode table

-- Question: Caesar cipher
encode :: Int -> String -> String
encode shift msg =
  let ords = map ord msg
      shifted = map (+ shift) ords
  in  map chr shifted

decode :: Int -> String -> String
decode shift msg = encode (negate shift) msg

------------------------------------------------------
-- Data.Map
------------------------------------------------------
-- association lists (dictionaries) are lists that used to store key-value pairs where ordering doesn't matter
-- <map> = [(<key>,<value>),(<key>,<value>)...]

-- returns the first value matches the key
findKey :: Eq k => k -> [(k,v)] -> v
findKey key xs = snd . head . filter (\(k,v) -> k == key) $ xs

-- returns Nothing for empty result 
findKey1 :: Eq k => k -> [(k,v)] -> Maybe v
findKey1 key [] = Nothing
findKey1 key ((k,v):xs) = if key == k
                             then Just v
                             else findKey1 key xs

-- fromList
-- takes an association list and returns a map with the same associations
-- discards duplicate keys in the original association list, keeps the last
-- returns the ordered association list, ordered by key so it can arrange them in a tree
-- use Data.Map for key-value association always unless keys aren't part of the Ord typeclass

-- empty
-- returns an empty map

-- insert
-- takes a key, a value and a map and returns a new map

-- Question: implement fromList with fold, insert and an empty map
fromList' :: Ord k => [(k,v)] -> Map.Map k v
fromList' = foldr (\(k,v) acc -> Map.insert k v acc) Map.empty

-- null
-- check if a map is empty

-- size
-- returns the size of a map

-- singleton
-- takes a key and a value and creates a map that has exactly one mapping
-- Map.singleton 1 2 = fromList [(1,2)]

-- lookup
-- like Data.List lookup, operates on maps
-- returns Just something if it finds something for the key, and Nothing otherwise

-- member
-- a predicate
-- takes a key and a map and returns whether the key is in the map or not

-- map and filter
-- works like list equivalents
-- Map.map (*2) $ Map.fromList [(1,2),(3,4)] = fromList [(1,4),(3,8)]
-- Map.filter isUpper $ Map.fromList [(1,'a'),(2,'B')] = fromList [(2,'B')]

-- toList
-- inverse of fromList
-- Map.toList . Map.insert 9 2 $ Map.singleton 4 3 = [(4,3),(9,2)]

-- keys and elems
-- returns list of keys and values
-- equivalent to map fst . Map.toList and map snd . Map.toList

-- fromListWith
-- acts like fromList
-- doesn't discard duplicate keys, supply a function to it to decide what to do with them
-- the provided function is operated on value only

phoneBookToMap :: Ord k => [(k, String)] -> Map.Map k String
phoneBookToMap xs = Map.fromListWith (\number1 number2 -> number1 ++ "," ++ number2) xs

phoneBookToMap' :: Ord k => [(k, a)] -> Map.Map k [a]
phoneBookToMap' xs = Map.fromListWith (++) $ map (\(k,v) -> (k,[v])) xs

-- insertWith
-- insert what fromListWith is to fromList
-- inserts a key-value pair into a map, use the passed function to determine what to do with the duplicated key
-- Map.insertWith (+) 3 100 $ Map.fromList [(1,2),(1,4),(3,8)] = fromList [(1,4),(3,108)]

------------------------------------------------------
-- Data.Set
------------------------------------------------------
-- internally implemented with trees(like Data.Map) and ordered
-- all the elements are unique

-- fromList
-- takes a list and converts it into a set
-- elements are ordered and unique

-- intersection
-- returns shared elements in two lists

-- difference
-- returns elements in the first set but not the second one

-- union
-- returns all unique elements used in both sets

-- null

-- size

-- member

-- empty

-- singleton

-- insert

-- delete

-- isSubSetOf and isProperSubsetOf

-- toList
-- inverse of fromList

-- NOTE
-- nub function in Data.List can weed out duplicates for large lists
-- fromList/toList function in Data.Set is much faster
-- nub requires Eq typeclass, Data.Set requires Ord typeclass
