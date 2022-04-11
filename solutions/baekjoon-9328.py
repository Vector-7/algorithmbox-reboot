import sys
import collections

input = sys.stdin.readline

def get_outline(h, w):
    return [(0, k) for k in range(w)] + \
        [(h-1, k) for k in range(w)] + \
        [(k, 0) for k in range(1, h-1)] + \
        [(k, w-1) for k in range(1, h-1)]

def in_range(i, j, n, m):
    return ((0 <= i < n) and (0 <= j < m))

di, dj = [1, -1, 0, 0], [0, 0, 1, -1]

for _ in range(int(input())):
    H,W = map(int, input()[:-1].split())
    ans = 0

    G, Q, D = [], collections.deque(), collections.defaultdict(list)
    V = [[False] * W for _ in range(H)]
    for _ in range(H):
        G.append(list(input()[:-1]))
    keys = set(list(input()[:-1]))

    outlines = get_outline(H, W)
    for si, sj in outlines:
        v = G[si][sj]
        if v != '*':
            V[si][sj] = True
            Q.appendleft((si, sj))
    
    while Q:
        i, j = Q.pop()
        v = G[i][j]

        if v == '.' or v == '$' or (ord('a') <= ord(v) <= ord('z')):
            if v == '$':
                ans += 1
            if ord('a') <= ord(v) <= ord('z'):
                # 열쇠를 찾은 경우
                keys.add(v)
                while D[v]:
                    Q.appendleft(D[v].pop())
            for k in range(4):
                ni, nj = i + di[k], j + dj[k]
                if not in_range(ni, nj, H, W):
                    continue
                if G[ni][nj] != '*' and not V[ni][nj]:
                    V[ni][nj] = True
                    Q.appendleft((ni, nj))

        elif ord('A') <= ord(v) <= ord('Z'):
            if v.lower() in keys:
                # 통과
                for k in range(4):
                    ni, nj = i + di[k], j + dj[k]
                    if not in_range(ni, nj, H, W):
                        continue
                    if G[ni][nj] != '*' and not V[ni][nj]:
                        V[ni][nj] = True
                        Q.appendleft((ni, nj))
            else:
                D[v.lower()].append((i, j))
    print(ans)