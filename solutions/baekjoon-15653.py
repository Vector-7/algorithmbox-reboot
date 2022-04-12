import sys
import heapq
input = sys.stdin.readline

N, M = map(int, input()[:-1].split())
G = []
for _ in range(N):
    G.append(list(input()[:-1]))

# locations
R, B, W = [0, 0], [0, 0], [0, 0]
di, dj = [0, 0, 1, -1], [1, -1, 0, 0]

for i in range(N):
    for j in range(M):
        if G[i][j] == 'B':
            G[i][j] = '.'
            B = [i, j]
        if G[i][j] == 'R':
            G[i][j] = '.'
            R = [i, j]
        if G[i][j] == 'O':
            W = [i, j]

def hash_visited(r, b):
    return b[0] + b[1] * 100 + r[0] * (100**2) + r[1] * (100**3)

ans = float('inf')
Q = [(0, R.copy(), B.copy())]
visited = [False] * 10101011
visited[hash_visited(R, B)] = True

error_r, error_b = [2, 6], [3, 7]

while Q:
    cnt, red, blue = heapq.heappop(Q)
    for k in range(4):
        n_red, n_blue = red.copy(), blue.copy()
        is_red_whole, is_blue_whole = False, False

        if ans != float('inf'):
            break

        if di[k] == 0:
            # 왼쪽/오른쪽
            if red[0] == blue[0]:
                # 수평선에 있는 경우
                if red[1] * dj[k] > blue[1] * dj[k]:
                    # 빨강 우선
                    while G[n_red[0]][n_red[1]] == '.':
                        n_red[1] += dj[k]
                    if G[n_red[0]][n_red[1]] == 'O':
                        is_red_whole = True
                    else:
                        n_red[1] -= dj[k]
                
                    # 파랑 돌리기
                    while G[n_blue[0]][n_blue[1]] == '.' and n_blue != n_red:
                        n_blue[1] += dj[k]
                    if G[n_blue[0]][n_blue[1]] == 'O':
                        continue
                    elif is_red_whole:
                        ans = cnt + 1
                        break

                    # 나머지의 경우
                    n_blue[1] -= dj[k]
                    hv = hash_visited(n_red, n_blue)
                    if not visited[hv]:
                        # 신규 위치
                        visited[hv] = True
                        heapq.heappush(Q, (cnt + 1, n_red, n_blue))
                else:
                    # 파랑 우선
                    while G[n_blue[0]][n_blue[1]] == '.':
                        n_blue[1] += dj[k]
                    if G[n_blue[0]][n_blue[1]] == 'O':
                        continue
                    n_blue[1] -= dj[k]

                    while G[n_red[0]][n_red[1]] == '.' and n_blue != n_red:
                        n_red[1] += dj[k]
                    if G[n_red[0]][n_red[1]] == 'O':
                        ans = cnt + 1
                        break
                    # 나머지의 경우
                    n_red[1] -= dj[k]
                    hv = hash_visited(n_red, n_blue)
                    if not visited[hv]:
                        # 신규 위치
                        visited[hv] = True
                        heapq.heappush(Q, (cnt + 1, n_red, n_blue))

            else:
                # 서로 다른 위치에 있는 경우
                # 각자 돌리기
                while G[n_blue[0]][n_blue[1]] == '.':
                    n_blue[1] += dj[k]
                if G[n_blue[0]][n_blue[1]] == 'O':
                    continue
                n_blue[1] -= dj[k]
                
                while G[n_red[0]][n_red[1]] == '.':
                    n_red[1] += dj[k]
                if G[n_red[0]][n_red[1]] == 'O':
                    ans = cnt + 1
                    break
                n_red[1] -= dj[k]
                hv = hash_visited(n_red, n_blue)
                if not visited[hv]:
                    # 신규 위치
                    visited[hv] = True
                    heapq.heappush(Q, (cnt + 1, n_red, n_blue))
                
        else:
            # 위/아래
            if red[1] == blue[1]:
                # 수직선에 있는 경우
                if red[0] * di[k] > blue[0] * di[k]:
                    # 빨강 우선
                    while G[n_red[0]][n_red[1]] == '.':
                        n_red[0] += di[k]
                    if G[n_red[0]][n_red[1]] == 'O':
                        is_red_whole = True
                    else:
                        n_red[0] -= di[k]

                    while G[n_blue[0]][n_blue[1]] == '.' and n_blue != n_red:
                        n_blue[0] += di[k]
                    if G[n_blue[0]][n_blue[1]] == 'O':
                        continue
                    elif is_red_whole:
                        ans = cnt + 1
                        break

                    # 나머지의 경우
                    n_blue[0] -= di[k]
                    hv = hash_visited(n_red, n_blue)
                    if not visited[hv]:
                        # 신규 위치
                        visited[hv] = True
                        heapq.heappush(Q, (cnt + 1, n_red, n_blue))
                else:
                    # 파랑 우선
                    while G[n_blue[0]][n_blue[1]] == '.':
                        n_blue[0] += di[k]
                    if G[n_blue[0]][n_blue[1]] == 'O':
                        continue
                    n_blue[0] -= di[k]

                    while G[n_red[0]][n_red[1]] == '.' and n_blue != n_red:
                        n_red[0] += di[k]
                    if G[n_red[0]][n_red[1]] == 'O':
                        ans = cnt + 1
                        break
                    # 나머지의 경우
                    n_red[0] -= di[k]
                    
                    hv = hash_visited(n_red, n_blue)
                    if not visited[hv]:
                        # 신규 위치
                        visited[hv] = True
                        heapq.heappush(Q, (cnt + 1, n_red, n_blue))
                    
            else:
                # 서로 다른 위치에 있는 경우
                # 각자 돌리기
                while G[n_blue[0]][n_blue[1]] == '.':
                    n_blue[0] += di[k]
                if G[n_blue[0]][n_blue[1]] == 'O':
                    continue
                n_blue[0] -= di[k]
                
                while G[n_red[0]][n_red[1]] == '.':
                    n_red[0] += di[k]
                if G[n_red[0]][n_red[1]] == 'O':
                    ans = cnt + 1
                    break
                n_red[0] -= di[k]

                hv = hash_visited(n_red, n_blue)
                if not visited[hv]:
                    # 신규 위치
                    visited[hv] = True
                    heapq.heappush(Q, (cnt + 1, n_red, n_blue))

if ans == float('inf'):
    print(-1)
else:
    print(ans)