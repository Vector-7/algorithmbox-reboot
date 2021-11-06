import Data.List
import qualified Data.Map as M

main = do
    raw <- readFile "case.txt"
    putStrLn raw