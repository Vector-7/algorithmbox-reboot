import Data.Maybe

data LinkedListNode = LinkedListNode Int (Maybe LinkedListNode)
-- 연결리스트 노드
-- Int: 데이터
-- LinkedListNode: Next
-- NonLinkedNode -> 다른곳에 연결하지 않은 상태의 노드, Head와 Tail이 이에 해당한다
-- LinkedNode -> 연결된 노드


getValueOfNode :: LinkedListNode -> Int
-- 값 가져오기
getValueOfNode (LinkedListNode val next) = val

getNextOfNode :: LinkedListNode -> Maybe LinkedListNode
-- 다음 링크 데이터 가져오기
getNextOfNode (LinkedListNode val next) = next

isNodeNothing :: Maybe LinkedListNode -> Bool
isNodeNothing Nothing = True
isNodeNothing _ = False


data LinkedList = LinkedList (Maybe LinkedListNode)
-- 연결 리스트
-- 연결 리스트 데이터 갯수
-- LinkedListNode: Head

initLinkedList :: LinkedList
-- 연결 리스트 초기화
initLinkedList = LinkedList Nothing

getLinkedListHead :: LinkedList -> Maybe LinkedListNode
getLinkedListHead (LinkedList head) = head



addDataToLinkedList :: LinkedList -> Int -> LinkedList
-- 링크리스트의 맨 끝에 데이터 추가하기
-- param: 리스트, 추가할 값
-- return: 변경된 리스트
addDataToLinkedList l v = LinkedList (_add head v)
    where
    head = getLinkedListHead(l)
    _add :: Maybe LinkedListNode -> Int -> Maybe LinkedListNode
    _add Nothing v  = Just (LinkedListNode v Nothing)
    _add node v     = Just (LinkedListNode curVal (_add next v))
        where
        cur     = fromJust node
        curVal  = getValueOfNode cur
        next    = getNextOfNode cur


removeDataToLinkedList :: LinkedList -> Int -> (LinkedList, Bool)
-- 해당 인덱스의 데이터 지우기
-- param: 링크리스트, 인덱스
-- return: (변경된 리스트, 성공 여부)
removeDataToLinkedList l i = (LinkedList (fst result), snd result)
    where
    head = getLinkedListHead(l)
    result = _remove head i
    _remove :: Maybe LinkedListNode -> Int -> (Maybe LinkedListNode, Bool)
    _remove Nothing _ =  (Nothing, False)       -- 비어있는 리스트
    _remove node idx
        | idx < 0 || isNodeNothing next    = (node, False) -- 인덱스 범위 값이거나 인덱스가 음수
        | idx == 0              = (next, True)  -- 맨 앞부분 삭제
        | idx == 1              = (Just (LinkedListNode curVal (getNextOfNode (fromJust next))), True)  -- 노드 수정 및 리턴
        | otherwise             = (Just (LinkedListNode curVal (fst result)), snd result)    -- 커서 옮기기
        where
            cur     = fromJust node
            curVal  = getValueOfNode cur
            next    = getNextOfNode cur
            result  = _remove next (idx - 1)


circuitLinkedList :: LinkedList -> [Int]
-- 연결리스트 순회
circuitLinkedList l = _circuit head
    where
    head = getLinkedListHead(l)
    _circuit :: Maybe LinkedListNode -> [Int]
    _circuit Nothing = []
    _circuit node = _val : (_circuit _next)
        where
            _node   = fromJust node
            _val    = getValueOfNode(_node)
            _next   = getNextOfNode(_node)

add1To10 :: LinkedList -> LinkedList
add1To10 l = _add1To10 l 10
    where
    _add1To10 :: LinkedList -> Int -> LinkedList
    _add1To10 l 0 = l
    _add1To10 l i = addDataToLinkedList (addData (i - 1)) i
        where
        addData = _add1To10 l

main = do
    let l = initLinkedList
    
    -- 1부터 10까지 순차적으로
    let afterL = add1To10 l
    let l = afterL
    putStrLn "Add 1 to 10"
    putStrLn (show (circuitLinkedList l))

    putStrLn "Remove Index 3"
    let r = removeDataToLinkedList l 9
    let l = fst r
    putStrLn (show (circuitLinkedList l))

    putStrLn "Remove Index 0"
    let r = removeDataToLinkedList l 0
    let l = fst r
    putStrLn (show (circuitLinkedList l))

    putStrLn "Remove Index 100 (Failed)"
    let r = removeDataToLinkedList l 100
    let l = fst r
    putStrLn (show (circuitLinkedList l))
    
    putStrLn "Remove Index -1 (Failed)"
    let r = removeDataToLinkedList l (-1)
    let l = fst r
    putStrLn (show (circuitLinkedList l))


