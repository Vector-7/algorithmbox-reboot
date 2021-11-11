import sys
import collections
import heapq

sys.setrecursionlimit(100_000_000)
input = sys.stdin.readline


N = int(input())
tree = collections.defaultdict(list)
diameters = [0] * (N + 1)    # 지름 길이 저장
visited = [False] * (N + 1)

for _ in range(N):
    l = list(map(int, input()[:-1].split()))[:-1]
    start = l[0]
    l = l[1:]
    for i in range(0, len(l), 2):
        end, value = l[i], l[i + 1]
        tree[start].append((end, value))

def __search(k, w) -> int:
    # 재귀 함수
    # 파라미터: 정점, 해당 정점으로 가는 것에 대한 가중치 값
    # 누적 간선값을 리턴한다.
    visited[k] = True # 방문 처리
    if k != 1 and len(tree[k]) == 1:
        # 리프 노드임 (1번 제외)
        # 가중치 값 리턴
        return w
    else:
        # 브랜치 노드
        weights = [] # 하위 노드로부터의 가중치 값 수집
        for child in tree[k]:
            child_k, child_w = child
            
            # 아직 방문 안함 == 하위 정점
            if not visited[child_k]:
                heapq.heappush(weights, -__search(child_k, child_w))
            
            
        if len(weights) == 1:
            # 하위 정점이 1개일 경우 해당 정점으 중심으로 지름 생성 불가
            # 간선 값만 누적해서 리턴
            return w + (-weights[0])
        else:
            # 두개 이상일 경우
            # 가장 큰 두개의 간선 값을 뽑아서 지름 데이터 저장
            fst_w = -heapq.heappop(weights)
            snd_w = -heapq.heappop(weights)

            diameters[k] = fst_w + snd_w
            # 가장 큰 간선 값으로 해당 위치로부터의 간선 값을 누적해서 리턴
            return w + fst_w

diameter_in_one = __search(1, 0)
if len(tree[1]) == 1:
    # 1번 정점의 자식 정점이 1개일 경우 1번 정점도 리프노드로 간주한다.
    diameters[1] = diameter_in_one
print(max(diameters))