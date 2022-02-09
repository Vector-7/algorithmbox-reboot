import sys
import collections
from performance_checker import PerformanceChecker
input = sys.stdin.readline

R, C = map(int, input()[:-1].split())
N = int(input())

R += 1
C += 1
start, end = [R-1, 0], [0, C-1]
di, dj = [-1, 0], [0, 1]

# 그래프 생성
graph = [[0] * C for _ in range(R)]
for i in range(N):
    i1, j1, i2, j2 = map(int, input()[:-1].split())
    graph[i1][j1] = graph[i2][j2] = 1


# checker start
p_checker = PerformanceChecker()
p_checker.start()

stack = [(start[0], start[1], 0)]
ans = 0

while stack:
    i, j, cnt = stack.pop()

    if (i == end[0]) and (j == end[1]):
        if cnt == 1:
            ans += 1
    else:
        for k in range(2):
            ni, nj = i + di[k], j + dj[k]
            if not ((0 <= ni < R) and (0 <= nj < C)):
                continue
            
            if (graph[ni][nj] == 1) and (graph[i][j] == 1):
                if cnt == 1:
                    continue
                else:
                    stack.append((ni, nj, 1))
            else:
                stack.append((ni, nj, cnt))


print(ans)


p_checker.stop()
p_checker.print()