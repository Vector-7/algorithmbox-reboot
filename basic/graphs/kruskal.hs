import Data.List
import qualified Data.Map as M


makeUnionSet :: (Ord a, Num a) => a -> a-> M.Map a a
-- Make Edge Union Set
makeUnionSet start end
    | start == end  = M.fromList [(start, start)]
    | otherwise     = M.insert start start (makeUnionSet (start + 1) end)

findParentFromUnionSet :: (Ord a, Num a) => M.Map a a -> a -> a
-- Find Top Parent Vertex
findParentFromUnionSet unionSet v
    | v == parent   = v
    | otherwise     = findParentFromUnionSet unionSet parent
    where
        parent = (unionSet M.! v)

-- Edge Member Functions
__getStart    = head . tail
__getEnd      = head . tail . tail
__getWeight   = head

__kruskal :: (Ord a, Num a, Foldable t) => t [a] -> M.Map a a -> a
-- Explain: Kruskal Micro Function
-- param:   edges, unionSet
-- return:  the smallest weight
-- 
-- Edge Info (before pre-process)
-- [start, end, weight]
-- Edge Info (after pre-process)
-- [weight, start, end]
__kruskal edges unionSet = (fst . (foldl' routineKruskal elements)) edges
    where
    elements = (0, unionSet)
    routineKruskal :: (Ord a, Num a) => (a, M.Map a a) -> [a] -> (a, M.Map a a)
    -- explain: Kruskal Routine
    -- param:   (totalValue, unionSet), one edge
    -- return:  (totalValue, unionSet)
    routineKruskal kruskalElemnts edge
        -- 싸이클이 생성되는 지 측정
        | (findParent start) == (findParent end)    = kruskalElemnts
        | otherwise                                 = (totalWeight + weight, M.adjust (const start) end unionSet)
        where
            start       = __getStart    edge
            end         = __getEnd      edge
            weight      = __getWeight   edge
            totalWeight = fst kruskalElemnts
            unionSet    = snd kruskalElemnts
            findParent  = findParentFromUnionSet unionSet

-- Main Kruskal Function
kruskal :: (Ord a, Num a) => a -> [[a]] -> a
    -- same with __kruskal
kruskal 1 _ = 0                                     -- if vertex size is 1 then return 0
kruskal 2 edges = (head . tail . tail . head) edges -- elif vertex size is 2 then return weight
kruskal nv edges
    | nv <= 0   = -1    -- SEND ERROR
    | otherwise = __kruskal preProcessedEdges (makeUnionSet 1 nv)
    where   
    preProcessedEdges = (sort . (map changeEdgeSet)) edges
        -- 가중치가 가장 적은 순으로 정렬 (Reverse를 수행한 이유는 맨 끝다리부터 계산이 시작되기 때문이다.)
        where
        changeEdgeSet :: (Ord a, Num a) => [a] -> [a]
        changeEdgeSet edge = [ ((head . tail . tail) edge), (head edge), ((head . tail) edge) ]
        -- 자리 체인지 => [start, end, weight] -> [weight, start, end]


{-- TEST FUNCTIONS --}
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