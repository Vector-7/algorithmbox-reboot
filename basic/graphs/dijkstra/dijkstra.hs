import Data.List
import Text.Read
import qualified Data.Map as M
import Debug.Trace

data TestCase = 
    TestCase Int Int [[Int]] [Int]
    -- vertexNums edgeNums Edges (start, end, weight), Expected Result

-- 테스트 케이스 데이터 추출 함수들
getVertexNums (TestCase vn en es ex) = vn
getEdgeNums (TestCase vn en es ex) = en
getEdges (TestCase vn en es ex) = es
getExpectedResult (TestCase vn en es ex) = ex

split :: Char -> String -> [String]
{-- 띄어쓰기나 콤마 등 을 기준으로 문자열 나누기
    param: delimiter str
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
-- case.txt로부터 데이터 파싱
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


covertResultMap2Array :: (Ord a, Num a, Show a) => M.Map a a -> a -> a -> [a]
covertResultMap2Array resultMap start end
    | start == end  = [resultMap M.! start]
    | otherwise     = (resultMap M.! start):(covertResultMap2Array resultMap (start + 1) end)

test :: [TestCase] -> [([Int], [Int])]
--  테스팅 함수
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

{-- 메인 알고리즘 --}
makeGraph :: (Ord a, Num a, Show a) => [[a]] -> M.Map a [(a, a)]
--  2차원 배열을 Map 형태로 전환
makeGraph [] = M.fromList []
makeGraph (x:xs) = _makeGraph p2 p1 w (_makeGraph p1 p2 w (makeGraph xs))   -- 양방향 그래프
    where
    p1 = x !! 0
    p2 = x !! 1
    w = x !! 2
    _makeGraph :: (Ord a, Num a, Show a) => a -> a -> a -> M.Map a [(a, a)] -> M.Map a [(a, a)]
    -- Map에 데이터를 생성 및 추가하는 서브 루틴
    -- params:  start, end, weight, graph
    _makeGraph start end weight g
        | not (M.member start g)    = M.insert start [(end, weight)] g
        | otherwise                 = M.adjust ((end, weight):) start g

dijkstra :: (Ord a, Num a, Show a) => a -> a -> [[a]] -> M.Map a a
-- param: vertexNum, edgeNum, edges 
-- return: weight result list
dijkstra vertexNum edgeNum edges = _dijkstra graph wList queue
    where
    queue = [(1, 0)]                        -- 큐
    wList = _initWeightList 1 vertexNum     -- 가중치 리스트
    graph = makeGraph edges                 -- 그래프
    _initWeightList :: (Ord a, Num a, Show a) => a -> a -> M.Map a a
    -- 가중치 리스트 초기화: 전부 -1로 초기화 한다
    -- 중간 인덱스에 데이터를 수정해야 하는 상황이 있으므로 배열이 아닌 Map으로 구현한다.
    _initWeightList start end
        | start >= end      = M.fromList [(end, -1)]
        | otherwise         = M.insert start (-1) (_initWeightList (start + 1) end)
    _dijkstra :: (Ord a, Num a, Show a) => M.Map a [(a, a)] -> M.Map a a -> [(a, a)] -> M.Map a a
    -- 다익스트라 루틴 함수 (큐가 다 빌 때 가지 진행)
    _dijkstra graph wList [] = wList    -- 큐에 데이터가 더이상 존재하지 않는 경우
    _dijkstra graph wList (e:q)         -- 큐에 데이터가 남아있는 경우
        | isAleadyVisited == True   = _dijkstra graph newWList (updateQ []) -- 이미 방문한 정점일 경우, 자식노드를 검색할 필요 X
        | otherwise                 = _dijkstra graph newWList (updateQ (graph M.! point))  -- 처음 방문
        where
        point       = fst e     -- 정점
        weight      = snd e     -- 누적 가중치 값
        updatedListNVisited = _updateList wList point weight    -- 가중치 리스트 갱신, visited와 list가 리턴값
        isAleadyVisited     = fst updatedListNVisited           -- 이미 정점을 방문했는지에 대한 Bool 값
        newWList            = snd updatedListNVisited           -- 갱신된 가중치 리스트
        updateQ             = _updateQueue q weight             -- 큐 데이터 추가 함수
        _updateList :: (Ord a, Num a, Show a) => M.Map a a -> a -> a -> (Bool, M.Map a a)
        -- 가중치 리스트 갱신
        -- params: 가중치 리스트, 정점, 갱신할 가중치
        _updateList list point weight
            | prevWeight == -1  = (False, M.adjust (const weight) point list)   -- -1인 경우 처음 방문
            | otherwise         = (True, M.adjust ((const . (min weight)) prevWeight) point list) -- 아닌 경우 가장 작은 값으로 갱신
            where
            prevWeight = list M.! point -- 해당 정점의 가중치 값 구하기
        _updateQueue :: (Ord a, Num a, Show a) => [(a, a)] -> a -> [(a, a)] -> [(a, a)]
        -- 큐에 데이터를 추가하는 함수
        -- params: 큐, 가중치, 추가대상 리스트
        _updateQueue q _ [] = q
        _updateQueue q w (n:ns) = _updateQueue (q ++ [(fst n, (snd n) + w)]) w ns

main = do
    raw <- readFile "case.txt"
    let testCases = parse raw
    putStrLn (show (test testCases))