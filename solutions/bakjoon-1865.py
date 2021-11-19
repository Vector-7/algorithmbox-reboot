import sys
input = sys.stdin.readline

T = int(input())
result = []

def process(V, E, edges, weights):

    def bfs():
        for i in range(V):
            print(weights)
            for j in range(E):
                u, v, w = edges[j]
                if weights[v] > weights[u] + w:
                    weights[v] = weights[u] + w
                    if i == V - 1:
                        return True
        return False
    
    is_cycle = bfs()
    print(weights)
    if is_cycle:
        return True
    else:
        return False

for _ in range(T):
    V, E, WE = map(int, input()[:-1].split())

    EDGES = []
    R = [0] * (V + 1)
    print("")
    for _ in range(E):
        # 일반 노선 갖고오기
        u, v, w = map(int, input()[:-1].split())
        EDGES.append((u, v, w))
        EDGES.append((v, u, w))
    for _ in range(WE):
        # 웜홀
        u, v, w = map(int, input()[:-1].split())
        EDGES.append((u, v, -w))
    
    if process(V, E*2+WE, EDGES, R):
        # 시간이 줄어듦
        result.append("YES")
    else:
        result.append("NO")
print('\n'.join(result))