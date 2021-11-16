import Data.Maybe

stackPush :: Num a => [a] -> a -> [a]
stackPush stack num = num:stack

stackPop :: Num a => [a] -> ([a], Maybe a)
stackPop [] = ([], Nothing)
stackPop (element:stack) = (stack, Just element)

stackTop :: Num a => [a] -> Maybe a
stackTop [] = Nothing
stackTop stack = Just (head stack)

stackIsEmpty :: Num a => [a] -> Bool
stackIsEmpty [] = False
stackIsEmpty _ = True

main = do

    let stack = []
    -- 1, 2, 3 순서로 puah
    
    -- element 1 push
    putStrLn "element 1 push"
    let stack1 = stackPush stack 1
    putStrLn ("stack status: " ++ show stack1)

    -- element 2 push
    putStrLn "element 2 push"
    let stack2 = stackPush stack1 2
    putStrLn ("stack status: " ++ show stack2)

    -- element 3 push
    putStrLn "element 3 push"
    let stack3 = stackPush stack2 3
    putStrLn ("stack status: " ++ show stack3)

    putStrLn ""

    -- 3, 2, 1 순서로 pop

    -- top
    let result = stackTop stack3
    putStrLn ("top element: " ++ (show (fromJust result)))

    -- pop 3
    let result = stackPop stack3
    let stack2 = fst result
    let element = fromJust (snd result)
    putStrLn ("pop element: " ++ (show element))
    putStrLn ("stack status: " ++ (show stack2))

    -- pop 2
    let result = stackPop stack2
    let stack1 = fst result
    let element = fromJust (snd result)
    putStrLn ("pop element: " ++ (show element))
    putStrLn ("stack status: " ++ (show stack1))

    -- pop 1
    let result = stackPop stack1
    let stack0 = fst result
    let element = fromJust (snd result)
    putStrLn ("pop element: " ++ (show element))
    putStrLn ("stack status: " ++ (show stack0))

    -- empty
    let result = stackPop stack0
    let empty_stack = fst result
    let element = snd result
    putStrLn ("pop element: " ++ (show element))


    -- empty by top
    let result = stackTop stack0
    putStrLn ("top element: " ++ (show result))
