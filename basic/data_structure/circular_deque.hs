import Data.Maybe
import Data.Array

data Circular = CircularDeque Int Int Int (Array Int Int)
-- 변수(왼쪽부터): max_len, front, rear, container

circularDequeInit :: Int -> Circular
circularDequeInit k = CircularDeque k 0 0 initedContainer
    where
    initedContainer = array (0, k) [(x, 0) | x <- [0..k]]

dequeIsEmpty :: Circular -> Bool
dequeIsEmpty (CircularDeque _ f r _) = f == r

dequeIsFull :: Circular -> Bool
dequeIsFull (CircularDeque m f r _) = (_rear - _front) == 1
    where
    _front = f
    _rear
        | r == 0    = m + 1
        | otherwise = r

dequeInsertFront :: Circular -> Int -> (Bool, Circular)
dequeInsertFront (CircularDeque m f r c) val
    | dequeIsFull _deque    = (False, _deque)   -- 이미 차 있음
    | otherwise             = (True, CircularDeque m new_front r (c // [(new_front, val)]))
    where
    _deque = CircularDeque m f r c  -- 함수 적용하기 위해 복사
    new_front = snd (divMod (f + 1) (m + 1))

dequeInsertLast :: Circular -> Int -> (Bool, Circular)
dequeInsertLast (CircularDeque m f r c) val
    | dequeIsFull _deque    = (False, _deque)
    | otherwise             = (True, CircularDeque m f new_rear (c // [(r, val)]))
    where
    _deque = CircularDeque m f r c
    new_rear
        | r == 0    = m
        | otherwise = r - 1

dequePopFront :: Circular -> (Maybe Int, Circular)
dequePopFront (CircularDeque m f r c)
    | dequeIsEmpty _deque   = (Nothing , _deque)
    | otherwise             = (Just (c ! f), CircularDeque m new_front r c)
    where
    _deque = CircularDeque m f r c
    new_front
        | f == 0    = m
        | otherwise = f - 1

dequePopLast :: Circular -> (Maybe Int, Circular)
dequePopLast (CircularDeque m f r c)
    | dequeIsEmpty _deque   = (Nothing, _deque)
    | otherwise             = (Just (c ! new_rear), CircularDeque m f new_rear c)
    where
    _deque = CircularDeque m f r c
    new_rear = snd (divMod (r + 1) (m + 1))
