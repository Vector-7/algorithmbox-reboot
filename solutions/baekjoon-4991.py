import sys
import collections
input = sys.stdin.readline

di, dj = [0, 0, 1, -1], [1, -1, 0, 0]

while True:
    G, robot, dirties = [], [], []
    W, H = map(int, input()[:-1].split())

    if W == 0 and H == 0:
        break

    for i in range(H):
        __raw = list(input()[:-1])
        for j in range(W):
            if __raw[j] == 'o':
                robot = (i, j)
            if __raw[j] == '*':
                dirties.append((i, j))
        G.append(__raw)

    N = len(dirties) + 1
    E = [[float('inf') for _ in range(N)] for _ in range(N)]
    V = [robot] + dirties

    for k in range(N):

        DP = [[float('inf')] * (W) for _ in range(H)]
        Q = collections.deque()

        Q.appendleft((V[k], 0))
        DP[V[k][0]][V[k][1]], E[k][k] = 0, 0
        

        while Q:
            u, w = Q.pop()
            ui, uj = u

            for i in range(4):
                vi, vj = ui + di[i], uj + dj[i]

                if not((0 <= vi < H) and (0 <= vj < W)):
                    # 범위 밖
                    continue
                
                if G[vi][vj] != 'x' and DP[vi][vj] > (w + 1):
                    DP[vi][vj] = (w + 1)
                    Q.appendleft(((vi, vj), (w + 1)))

                    if G[vi][vj] == '*' or G[vi][vj] == 'o':
                        p = V.index((vi, vj))
                        E[k][p] = (w + 1)
        
    visited = 1<<0
    full_mask = 2 ** N - 1
    ans = float('inf')
    def __backtracking(u, w):
        global visited
        global ans
        if not (visited ^ full_mask):
            ans = min(ans, w)
        else:
            for v in range(N):
                if E[u][v] != float('inf') and u != v and (not (1 << v) & visited) and (ans > w + E[u][v]):
                    visited |= 1<<v
                    __backtracking(v, w + E[u][v])
            
        visited &= ((1<<u) ^ full_mask)
    __backtracking(0, 0)
    if ans == float('inf'):
        print(-1)
    else:
        print(ans)