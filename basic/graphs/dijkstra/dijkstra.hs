import Data.List
import Text.Read
import qualified Data.Map as M

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
                _makeEdgeList (s:sx) (e:ex) (w:wx)
                    | starts == []      = []
                    | otherwise         = [(read s :: Int), (read e :: Int), (read w :: Int)]:(_makeEdgeList sx ex wx)
            makeExpectedList :: [String] -> [Int]
            {-- 예상 정답 리스트 생성 --}
            makeExpectedList = map (\e -> read e :: Int)

test :: [TestCase] -> [(String, [[Int]])]
--  param: TestCase List
--  return: [(Success or Failed, expectedList, actualList)]
test [] = []
test (t:ts) = ((checkIsSuccess expected acutal), [expected, acutal]) : (test ts)
    where
    vertexNum   = getVertexNums t
    edgeNum     = getEdgeNums t
    edges       = getEdges t
    expected    = getExpectedResult t
    acutal      = dijkstra vertexNum edgeNum edges
    checkIsSuccess :: [Int] -> [Int] -> String
    checkIsSuccess [] [] = "SUCCESS"
    checkIsSuccess (e:es) (a:as)
        | e /= a        = "FAILED"
        | otherwise     = checkIsSuccess es as

main = do
    raw <- readFile "case.txt"
    let testCases = parse raw
    putStrLn (show (test testCases))