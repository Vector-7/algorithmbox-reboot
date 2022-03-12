import sys
import heapq
input = sys.stdin.readline

n = int(input())
A, H = [], []
for i in range(n):
    s, t = map(int, input()[:-1].split())
    A.append((s, t))

A.sort(key=lambda x: (x[0], x[1]))
ans = 0


for i in range(len(A)):
    s, t = A[i]

    if H and H[0] <= s:
        heapq.heappop(H)
    heapq.heappush(H, t)
    ans = max(ans, len(H))

print(ans)