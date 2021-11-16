import Data.Maybe

queuePush :: Num a => [a] -> a -> [a]
queuePush queue element = queue ++ [element]

queuePop :: Num a => [a] -> ([a], Maybe a)
queuePop [] = ([], Nothing)
queuePop (element:queue) = (queue, Just element)

queueIsEmpty :: Num a => [a] -> Bool
queueIsEmpty queue = null queue

main = do

    let queue = []
    
    let queue2 = queuePush queue 1
    putStrLn ("Push 1: " ++ show queue2)

    let queue = queuePush queue2 2
    putStrLn ("Push 2: " ++ show queue)

    let queue2 = queuePush queue 3
    putStrLn ("Push 3: " ++ show queue2)

    putStrLn ""

    putStrLn "Start pop"
    
    -- pop 3
    let r = queuePop queue2
    let queue2 = fst r
    let e = fromMaybe 0 (snd r)
    putStrLn ("Pop: " ++ show e)
    
    -- pop 2
    let r = queuePop queue2
    let queue2 = fst r
    let e = fromMaybe 0 (snd r)
    putStrLn ("Pop: " ++ show e)

    -- pop 1
    let r = queuePop queue2
    let queue2 = fst r
    let e = fromMaybe 0 (snd r)
    putStrLn ("Pop: " ++ show e)

    
    -- empty error
    let r = queuePop queue2
    let queue2 = fst r
    let e = snd r
    putStrLn ("Pop: " ++ show e)