import sys
import collections
import heapq

sys.setrecursionlimit(100_000)

input = sys.stdin.readline

N = int(input())
tree = collections.defaultdict(list)
vals = collections.defaultdict(tuple)
# (간선 값, 지름 값)

if N == 1:
    print("0")
    exit(0)

for _ in range(N-1):
    start, end, value = list(map(int, input()[:-1].split()))
    tree[start].append(end)
    vals[end] = (value, -1)
vals[1] = (0, -1)

def __search(k: int):
    # k: key

    # if leafnode
    if k not in tree:
        # 지름 값 없음
        vals[k] = (vals[k][0], 0)
    else:
        # 아닌 경우
        candidate_edges = []

        for child_k in tree[k]:
            # child edge 순회
            __search(child_k)
            # 후보 Edge값 push
            heapq.heappush(candidate_edges, -vals[child_k][0])

        # child edge가 하나인 경우
        # 해당 key에서 지름 못구함 따라서 지름은 추가 하지 않고 누적 edge 값만
        if len(candidate_edges) == 1:
            vals[k] = (vals[k][0] + -(heapq.heappop(candidate_edges)), 0)
        else:
            # 두개 이상이면 가장 값이 큰 두개 사용
            fst_e = -heapq.heappop(candidate_edges)
            snd_e = -heapq.heappop(candidate_edges)
            vals[k] = (vals[k][0] + fst_e, fst_e + snd_e)
        # 간선 값 리턴
        return vals[k][0]

__search(1)

# 1의 자식 노드가 1개일 경우 리프노드에 해당되므로 예외 처리
if len(tree[1]) == 1:
    vals[1] = (vals[1][0], vals[1][0])

r = list(vals.values())
r.sort(key=lambda x: x[1], reverse=True)
answer = r[0][1]
print(answer)