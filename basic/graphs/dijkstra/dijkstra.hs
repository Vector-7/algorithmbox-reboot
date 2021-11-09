import Data.List
import Text.Read
import qualified Data.Map as M
import Debug.Trace

data TestCase = 
    TestCase Int Int [[Int]] [Int]
    -- vertexNums edgeNums Edges (start, end, weight), Expected Result

getVertexNums (TestCase vn en es ex) = vn
getEdgeNums (TestCase vn en es ex) = en
getEdges (TestCase vn en es ex) = es
getExpectedResult (TestCase vn en es ex) = ex

split :: Char -> String -> [String]
{-- param: delimiter str
    return splited list
--}
split delimiter str =  _split str delimiter ""
    where
    _split :: String -> Char -> String -> [String]
    {-- param: str, delimiter, strBuf, curSplitedStringList
        return splited list
    --}
    _split str delimiter strBuf
        | str == "" && strBuf == ""             = []
        | str == "" && strBuf /= ""             = [strBuf]
        | front == delimiter && strBuf /= ""    = strBuf:(_split backStr delimiter "")  -- Found delimiter
        | front == delimiter && strBuf == ""    = _split backStr delimiter strBuf
        | otherwise                             = _split backStr delimiter (strBuf ++ [front])
        where   front:backStr = str

parse :: String -> [TestCase]
parse str = _parse (split '\n' str) 0
    where
    _parse :: [String] -> Int -> [TestCase]
    _parse splited idx
        | (length splited) == idx       = []
        | otherwise                     = (makeTestCase splited idx) : (_parse splited (idx + 6))
        where
        makeTestCase :: [String] -> Int -> TestCase
        makeTestCase splited idx = TestCase vertexNum edgeNum
                                            (makeEdgeList (idx + 2) 0 splited)
                                            (makeExpectedList rawEx)
            where
            vertexNum   = read (splited !! idx) :: Int
            edgeNum     = read (splited !! (idx + 1)) :: Int
            rawEx       = split ' ' (splited !! (idx + 5))
            makeEdgeList :: Int -> Int -> [String] -> [[Int]]
            {--
                Edge 리스트 생성
                idx + 0     = Start Point Index
                idx + 1     = End Point Index
                idx + 2     = Weight Point Index 
            --}
            makeEdgeList startLoc idx splited = _makeEdgeList starts ends weights
                where
                starts  = split ' ' (splited !! startLoc)
                ends    = split ' ' (splited !! (startLoc + 1))
                weights = split ' ' (splited !! (startLoc + 2))
                _makeEdgeList :: [String] -> [String] -> [String] -> [[Int]]
                _makeEdgeList [] [] [] = []
                _makeEdgeList (s:sx) (e:ex) (w:wx) = [(read s :: Int), (read e :: Int), (read w :: Int)]:(_makeEdgeList sx ex wx)
            makeExpectedList :: [String] -> [Int]
            {-- 예상 정답 리스트 생성 --}
            makeExpectedList = map (\e -> read e :: Int)


covertResultMap2Array :: (Num a, Ord a) => M.Map a a -> a -> a -> [a]
covertResultMap2Array resultMap start end
    | start == end  = [resultMap M.! start]
    | otherwise     = (resultMap M.! start):(covertResultMap2Array resultMap (start + 1) end)

test :: [TestCase] -> [([Int], [Int])]
--  param: TestCase List
--  return: [(Success or Failed, expectedList, actualList)]
test [] = []
test (t:ts) = (expected, acutal) : (test ts)
    where
    vertexNum   = getVertexNums t
    edgeNum     = getEdgeNums t
    edges       = getEdges t
    expected    = getExpectedResult t
    acutal      = covertResultMap2Array (dijkstra vertexNum edgeNum edges) 1 vertexNum

{-- MAIN ALGORITHM --}
makeGraph :: (Num a, Ord a) => [[a]] -> M.Map a [(a, a)]
makeGraph [] = M.fromList []
makeGraph (x:xs) = _makeGraph p2 p1 w (_makeGraph p1 p2 w (makeGraph xs))
    where
    p1 = x !! 0
    p2 = x !! 1
    w = x !! 2
    _makeGraph :: (Num a, Ord a) => a -> a -> a -> M.Map a [(a, a)] -> M.Map a [(a, a)]
    _makeGraph start end weight g
        | M.member start g      = M.insert start [(end, weight)] g
        | otherwise             = M.adjust ((end, weight):) end g

dijkstra :: (Num a, Ord a) => a -> a -> [[a]] -> M.Map a a
-- param: vertexNum, edgeNum, edges 
-- return: weight result list
dijkstra vertexNum edgeNum edges = _dijkstra graph wList queue
    where
    queue = [(1, 0)]
    wList = _initWeightList 1 vertexNum
    graph = makeGraph edges
    _initWeightList :: (Num a, Ord a) => a -> a -> M.Map a a
    -- 가중치 리스트 초기화
    _initWeightList start end
        | start == end      = M.fromList[(end, -1)]
        | otherwise         = M.insert start (-1) (_initWeightList (start + 1) end)
    _dijkstra :: (Ord a, Num a) => M.Map a [(a, a)] -> M.Map a a -> [(a, a)] -> M.Map a a
    -- 다익스트라 루틴 함수 (큐가 다 빌 때 가지 진행)
    _dijkstra graph wList [] = wList
    _dijkstra graph wList (q:qs)
        | isAleadyExists == False   = _dijkstra graph newWList (updateQ (graph M.! point))
        | otherwise                 = _dijkstra graph newWList (updateQ [])
        where
        point = fst q
        weight = snd q
        updatedW        = _updateWList newWList point weight
        isAleadyExists  = fst updatedW
        newWList        = snd updatedW
        updateQ         = _updateQueue qs weight
        _updateWList :: (Ord a, Num a) => M.Map a a -> a -> a -> (Bool, M.Map a a)
        -- 가중치 리스트 갱신
        -- return: (isAleadyExists, Updated W List)
        _updateWList newWList point weight
            | prevWeight == -1      = (False, M.adjust (const weight) point newWList)
            | otherwise             = (True, M.adjust ((const . (max weight)) prevWeight) point newWList)
            where
            prevWeight = newWList M.! point
        _updateQueue :: (Ord a, Num a) => [(a, a)] -> a -> [(a, a)] -> [(a, a)]
        -- 큐에 새 데이터 추가
        -- param: Queue, New Element List, +Weight
        _updateQueue q _ [] = q
        _updateQueue q w (n:ns) = _updateQueue (q ++ [(fst n, (snd n) + w)]) w ns

main = do
    raw <- readFile "case.txt"
    let testCases = parse raw
    let edge0 = getEdges (testCases !! 0)
    putStrLn (show edge0)
    let g = makeGraph edge0
    putStrLn (show g)
    -- putStrLn (show (test (parse raw)))