import Data.List
import Text.Read
import qualified Data.Map as M

-- 
split :: String -> String -> [String]
-- params: string, delimiter
-- result: string array
split "" _ = []
split str "" = [str]
split str delimiter = _split str delimiter "" "" []
    where
    _split :: String -> String -> String -> String -> [String] -> [String]
    -- param: string, delimiter, strBuf, bufDel, collectedStr
    -- return: split list
    _split curStr delimiter strBuf bufDel collectedStr = collectedStr
        where
        curStrFst:curStrOther = curStr



main = do
    raw <- readFile "case.txt"
    putStrLn raw