binarySearch :: (Ord a, Num a) => [a] -> a -> Int
--  param
--      [Num] => Array List
--      Num => Target Value
--  return
--      Int => Index
--          if search failed return -1
binarySearch [] _ = -1      -- 배열이 비어있는 경우 -1 인덱스 반환
binarySearch arr e = func arr e 0 (length arr - 1)
    where
        func :: (Ord a, Num a) => [a] -> a -> Int -> Int -> Int
        func arr e l r
            | l > r             = -1        -- 못찾음
            | target == e       = mid       -- 찾음
            | target > e        = func arr e l (mid - 1)
            | target < e        = func arr e (mid + 1) r
            | otherwise         = -1
            where
                mid     = div (l + r) 2
                target  = arr !! mid


test :: (Ord a, Num a) => [([a], a)] -> [Int]
test t
    | len == 1      = [binarySearch arr e]
    | otherwise     = (binarySearch arr e):(test (tail t))
    where
        len = length t
        c   = head t
        arr = fst c
        e   = snd c
        

main = do
    putStrLn (show (test testCase))
    where
        testCase :: (Ord a, Num a) => [([a], a)]
        testCase = [ ([1,3,4,6,7,8], 3)
                    ,([1,3,4,6,7,8], 5)
                    ,([1,3,4,6,7,8], 1)
                    ,([1,3,4,6,7,8], 8)
                    ,([1], 1)
                    ,([2], 1) ]