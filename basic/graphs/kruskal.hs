import Data.List

kruskal :: (Ord a, Num a) => a -> [[a]] -> a
-- param: NumberOfVertex, edges
-- return: Value of the smallest
-- edges
-- [[start, end, weight]]
kruskal 1 _ = 0
    -- if vertex size is 1 then return 0
kruskal 2 edges = (head . tail . tail . head) edges
    -- elif vertex size is 2 then return weight
kruskal nv edges
    -- otherwise
    | nv <= 0   = -1    -- SEND ERROR
    | otherwise = 2
    where
        -- 데이터 추출 함수
        getWeight   = head
        getStart    = (head . tail)
        getEnd      = (head . tail . tail)
        preProcessedEdges = (sort . preProcessEdge) edges
        -- 가중치가 가장 적은 순으로 정렬
            where
                -- Change [start, end, weight] to [weight, start, end]
                preProcessEdge :: (Ord a, Num a) => [[a]] -> [[a]] 
                preProcessEdge (e:ex)
                    | ex == []      = [(changeEdgeSet e)]
                    | otherwise     = (changeEdgeSet e):(preProcessEdge ex)
                    where
                        changeEdgeSet :: (Ord a, Num a) => [a] -> [a]
                        changeEdgeSet edge = [ ((head . tail . tail) edge), (head edge), ((head . tail) edge) ]
                        -- 자리 체인지 => [start, end, weight] -> [weight, start, end]


test :: (Ord a, Num a) => [a] -> [(a, [[a]])] -> [String]
test (ans:anss) (t:ts)
    | anss == []    = [(checkResult ans (runKruskal t))]
    | otherwise     = (checkResult ans (runKruskal t)):(test anss ts)
    where
        checkResult :: (Ord a, Num a) => a -> a -> String
        checkResult exAns ans
            | exAns == ans  = "SUCCESS"
            | otherwise     = "FAILED"
        runKruskal :: (Ord a, Num a) => (a, [[a]]) -> a
        runKruskal t = kruskal (fst t) (snd t)

main = do
    putStrLn (show (test answers testCases))
    where
        answers = [0, 3, 6, 99]
        testCases = [
            (1, [   [1, 1, 0] ]),
            (2, [   [1, 2, 3] ]),
            (4, [   [1, 2, 1], [1, 4, 2], [2, 4, 2], [2, 3, 3], [3, 4, 4] ]),
            (7, [   [1, 2, 28], [2, 3, 16], [3, 4, 12], [4, 5, 22], [5, 6, 25], [6, 1, 10], [2, 7, 14], [7, 5, 24], [7, 4, 18] ]) ]