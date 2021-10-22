binarySearch :: (Ord a, Num a) => [a] -> a -> Int
--  param
--      [a] => 정렬된 Number 리스트
--      a => 찾고자 하는 값
--  return
--      Int => 해당 값에 해당되는 인덱스
--          if search failed return -1 실패시 -1 리턴
binarySearch [] _ = -1      -- 배열이 비어있는 경우 -1 인덱스 반환
binarySearch arr e = func arr e 0 (length arr - 1)
    where
        -- func: __binary_search
        func :: (Ord a, Num a) => [a] -> a -> Int -> Int -> Int
        {-
            param
                [a]: 정렬된 Num 리스트
                a: 찾고자 하는 값
                Int, Int: left, right
            return
                Int: 해당 값에 해당되는 인덱스
        -}
        func arr e l r
            | l > r             = -1        -- 못찾음
            | target == e       = mid       -- 찾음
            | target > e        = func arr e l (mid - 1)
            | target < e        = func arr e (mid + 1) r
            | otherwise         = -1        -- else 예외처리
            where
                mid     = div (l + r) 2     -- 인덱스 중간값
                target  = arr !! mid        -- 중간 인덱스에 대한 값


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