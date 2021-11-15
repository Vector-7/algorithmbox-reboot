import Data.Maybe

arrayQueuePush :: Num a => [a] -> a -> [a]
arrayQueuePush queue element = element:queue

arrayQueuePop :: Num a => [a] -> ([a], Maybe a)
arrayQueuePop [] = ([], Nothing)
arrayQueuePop (element:queue) = (queue, Just element)

arrayQueueIsEmpty :: Num a => [a] -> Bool
arrayQueueIsEmpty queue = null queue

main = do

    let queue = []
    
    let queue2 = arrayQueuePush queue 1
    putStrLn ("Push 1: " ++ show queue2)

    let queue = arrayQueuePush queue2 2
    putStrLn ("Push 2: " ++ show queue)

    let queue2 = arrayQueuePush queue 3
    putStrLn ("Push 3: " ++ show queue2)

    putStrLn ""

    putStrLn "Start pop"
    
    -- pop 3
    let r = arrayQueuePop queue2
    let queue2 = fst r
    let e = fromMaybe 0 (snd r)
    putStrLn ("Pop: " ++ show e)
    
    -- pop 2
    let r = arrayQueuePop queue2
    let queue2 = fst r
    let e = fromMaybe 0 (snd r)
    putStrLn ("Pop: " ++ show e)

    -- pop 1
    let r = arrayQueuePop queue2
    let queue2 = fst r
    let e = fromMaybe 0 (snd r)
    putStrLn ("Pop: " ++ show e)

    
    -- empty error
    let r = arrayQueuePop queue2
    let queue2 = fst r
    let e = snd r
    putStrLn ("Pop: " ++ show e)