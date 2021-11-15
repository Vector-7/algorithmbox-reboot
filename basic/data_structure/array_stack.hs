import Data.Maybe

arrayStackPush :: Num a => [a] -> a -> [a]
arrayStackPush stack num = num:stack

arrayStackPop :: Num a => [a] -> ([a], Maybe a)
arrayStackPop [] = ([], Nothing)
arrayStackPop (element:stack) = (stack, Just element)

arrayStackIsEmpty :: Num a => [a] -> Bool
arrayStackIsEmpty [] = False
arrayStackIsEmpty _ = True

main = do

    let stack = []
    -- 1, 2, 3 순서로 puah
    
    -- element 1 push
    putStrLn "element 1 push"
    let stack1 = arrayStackPush stack 1
    putStrLn ("stack status: " ++ show stack1)

    -- element 2 push
    putStrLn "element 2 push"
    let stack2 = arrayStackPush stack1 2
    putStrLn ("stack status: " ++ show stack2)

    -- element 3 push
    putStrLn "element 3 push"
    let stack3 = arrayStackPush stack2 3
    putStrLn ("stack status: " ++ show stack3)

    putStrLn ""

    -- 3, 2, 1 순서로 pop

    -- pop 3
    let result = arrayStackPop stack3
    let stack2 = fst result
    let element = fromMaybe 0 (snd result)
    putStrLn ("pop element: " ++ (show element))
    putStrLn ("stack status: " ++ (show stack2))

    -- pop 2
    let result = arrayStackPop stack2
    let stack1 = fst result
    let element = fromMaybe 0  (snd result)
    putStrLn ("pop element: " ++ (show element))
    putStrLn ("stack status: " ++ (show stack1))

    -- pop 1
    let result = arrayStackPop stack1
    let stack0 = fst result
    let element = fromMaybe 0  (snd result)
    putStrLn ("pop element: " ++ (show element))
    putStrLn ("stack status: " ++ (show stack0))

    -- empty
    let result = arrayStackPop stack0
    let empty_stack = fst result
    let element = snd result
    putStrLn ("pop element: " ++ (show element))
