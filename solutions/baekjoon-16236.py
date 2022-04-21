import sys
import collections
input = sys.stdin.readline

N = int(input())
s_loc, s_size = None, 2
s_exp = 0


di, dj = [0, 0, 1, -1], [1, -1, 0, 0]

G = []
for i in range(N):
    G.append(list(map(int, input()[:-1].split())))
    _i = len(G)-1
    for _j in range(N):
        if G[_i][_j] == 9:
            s_loc = [_i, _j]
G[s_loc[0]][s_loc[1]] = 0

ans = 0
while True:
    # RUN BFS
    V = [[False] * N for _ in range(N)]
    fishes = []
    # data => [length, i, j]

    Q = collections.deque()
    Q.appendleft((*s_loc, 0))
    V[s_loc[0]][s_loc[1]] = True

    while Q:
        i, j, w = Q.pop()

        for k in range(4):
            ni, nj = i+di[k], j+dj[k]

            if not ((0 <= ni < N) and (0 <= nj < N)):
                continue
            if V[ni][nj] or G[ni][nj] > s_size:
                continue
            
            V[ni][nj] = True
            if G[ni][nj] == 0 or G[ni][nj] == s_size:
                Q.appendleft((ni, nj, w+1))
            elif 0 < G[ni][nj] < s_size:
                fishes.append((w+1, ni, nj))

    # 물고기 정렬
    fishes.sort(key=lambda e: (e[0], e[1], e[2]))

    if len(fishes) == 0:
        break

    # 물고기 잡기
    el, ei, ej = fishes[0]
    G[ei][ej] = 0
    s_loc = [ei, ej]
    ans += el
    
    s_exp += 1
    if s_exp >= s_size:
        s_exp = 0
        s_size += 1


print(ans)