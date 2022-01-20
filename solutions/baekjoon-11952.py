import sys
import collections
input = sys.stdin.readline

N, M, K, S = map(int, input()[:-1].split())
P, Q = map(int, input()[:-1].split())

costs = [P] * (N+1)         # 비용
zombied = [False] * (N+1)   # 좀비에게 점령당한 도시 (여긴 이동 불가능)
g = collections.defaultdict(list)


for _ in range(K):
    # 좀비에게 점령당한 곳 처리
    zombied[int(input())] = True

# 도로 정보
for _ in range(M):
    u, v = map(int, input()[:-1].split())
    g[u].append(v)
    g[v].append(u)

def set_hazard_area():
    # 위험 구역 설정
    # dfs 처리
    visited = [0] * (N+1)
    for i in range(1, N+1):
        if zombied[i]:
            # run DFS
            q = collections.deque()
            q.appendleft((i, 0))
            visited[i] = i

            while q:
                u, d = q.pop()
                # node, depth
                if d >= S:
                    continue
                
                for v in g[u]:
                    if visited[v] == i:
                        continue
                    # stack add
                    costs[v] = Q
                    visited[v] = i
                    q.appendleft((v, d+1))

def get_minimal_cost():
    clist = [float('inf')] * (N+1)
    q = collections.deque()
    q.appendleft((1, 0))

    while q:
        u, c = q.pop()
        for v in g[u]:
            # zombie 접근 불가
            if zombied[v]:
                continue
            if v == N:
                # 해당 지점이 끝지점인 경우 값을 계산하지 않는다
                clist[N] = min(clist[N], c)
            else:
                # 값 비교
                if c + costs[v] < clist[v]:
                    clist[v] = c + costs[v]
                    q.appendleft((v, clist[v]))
    #print(clist)
    return clist[N]

set_hazard_area()
#print(costs)
print(get_minimal_cost())