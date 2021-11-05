import heapq
import collections

def kruskal(m):
    # m => [[start, end, value], ...]

    union = collections.defaultdict(int)
    H = []
    r = 0

    def __redef():
        while m:
            start, end, value = m.pop()
            union[start], union[end] = start, end
            heapq.heappush(H, [value, start, end])
    
    def __find_parent(a):
        while union[a] != a:
            a = union[a]
        return a

    __redef()    
    N = len(union)

    while H:
        value, start, end = heapq.heappop(H)

        # 사이클 확인
        if __find_parent(start) == __find_parent(end):
            continue

        union[end] = start
        r += value
    return r

case = [
    [
        ["a", "b", 1],
        ["a", "d", 2],
        ["b", "d", 2],
        ["b", "c", 3],
        ["c", "d", 4],
        6
    ],
    [
        [1, 2, 28],
        [2, 3, 16],
        [3, 4, 12],
        [4, 5, 22],
        [5, 6, 25],
        [6, 1, 10],
        [2, 7, 14],
        [7, 5, 24],
        [7, 4, 18],
        99
    ]
]

for c in case:
    r = kruskal(c[:-1])
    print(r)
    assert r == c[-1]

