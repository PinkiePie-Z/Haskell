-- Recursion

maximum' :: Ord a => [a] -> a
maximum' [] = error "maximum of empty list"
maximum' [x] = x
maximum' (x:xs) 
    | x > maximum' xs = x
    | otherwise = maximum' xs

maximum'' :: Ord a => [a] -> a
maximum'' [] = error "maximum of empty list"
maximum'' [x] = x
maximum'' (x:xs) = max x (maximum'' xs)

replicate' :: (Num a, Ord a) => a -> b -> [b]
replicate' n x
    | n <= 0 = []
    | otherwise = x:(replicate' (n-1) x)

take' :: (Num a, Ord a) => a -> [b] -> [b]
take' _ [] = []
take' n _
    | n <= 0 = []
take' n (x:xs) = x:(take' (n-1) xs)

reverse' :: [a] -> [a]
reverse' [] = []
reverse' (x:xs) = (reverse' xs) ++ [x]

repeat' :: a -> [a]
repeat' x = x:(repeat' x)

zip' :: [a] -> [b] -> [(a,b)]
zip' [] _ = []
zip' _ [] = []
zip' (x:xs) (y:ys) = (x,y):(zip' xs ys)

elem' :: Eq a => a -> [a] -> Bool
elem' _ [] = False
elem' a (x:xs)
    | a==x = True
    | otherwise = (elem' a xs)

-- Quick Sort

quicksort :: Ord a => [a] -> [a]
quicksort [] = []
quicksort (x:xs) = 
    let smallerSorted = quicksort [a | a <- xs, a <= x]
        biggerSorted = quicksort [a | a <- xs, a > x]
    in smallerSorted ++ [x] ++ biggerSorted
