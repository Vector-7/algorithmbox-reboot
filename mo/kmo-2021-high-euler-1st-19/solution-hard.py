import sys
import collections
from performance_checker import PerformanceChecker
sys.setrecursionlimit(10 ** 7)

input = sys.stdin.readline
MODULA = 1_000_000_000 + 7

""" Classes """
class Point:
    def __init__(self, i, j):
        self.i = i
        self.j = j

class Vertex:
    def __init__(self, i1, j1, i2, j2):
        self.s = Point(i1, j1)
        self.e = Point(i2, j2)
    def __str__(self):
        return f"start: ({self.s.i}, {self.s.j}), end: ({self.e.i}, {self.e.j})"

def is_included(parent, child):
    # child가 parent 범위 안에 있는 지 조사
    if (parent.e.j <= child.s.j) and (parent.e.i >= child.s.i):
        return True
    else:
        return False

def make_pool_tree(pools, N):

    # 위상 그래프 생성
    pool_child_graph = collections.defaultdict(list)
    pool_parent_graph = collections.defaultdict(list)
    child_nums, parent_nums = [0] * (N+1), [0] * (N+1)
    
    def __make_pool_tree(pools, N, i):
        for j in range(i+1, N+1):
            if is_included(pools[i], pools[j]):
                if i > 0:
                    pool_parent_graph[j].append(i)
                    pool_child_graph[i].append(j)
                    child_nums[i] += 1
                    parent_nums[j] += 1

                if child_nums[j] == 0:
                    # 아직 연결이 안되어 있음
                    __make_pool_tree(pools, N, j)
    __make_pool_tree(pools, N, 0)

    return pool_parent_graph, pool_child_graph, child_nums, parent_nums

def make_factorial(n):
    # 팩토리얼 DP를 만든다
    facts = [1] * (n+1)
    for i in range(1, n+1):
        facts[i] = (facts[i-1] * i)
    return facts

def get_permutation(n, m, facts):
    # 팩토리얼 DP
    return facts[n+m] // (facts[n] * facts[m])

def calculate(                              \
    pools,                                  \
    pool_parent_graph, pool_child_graph,    \
    parent_nums, child_nums,                \
    facts, N, R, C                          \
):
    home_case, back_case = [0] * (N+1), [0] * (N+1)

    def __topological_sort(g, p):
        # 위상 정렬
        q, l = collections.deque(), collections.deque()

        for i in range(1, N+1):
            if p[i] == 0:
                q.appendleft(i)

        while q:
            i = q.pop()
            l.appendleft(i)

            for j in g[i]:
                p[j] -= 1
                if p[j] == 0:
                    q.appendleft(j)
        return list(l)


    # 위상 정렬
    sorted_list = __topological_sort(pool_parent_graph, child_nums)

    # 해당 웅덩이에서 다른 웅덩이를 거치지 않고 집으로 들어가는 경우 구하기
    for k in range(N-1, -1, -1):
        i = sorted_list[k]
        r, c = pools[i].e.i, C - pools[i].e.j
        home_case[i] = get_permutation(r, c, facts)
        
        for ni in pool_child_graph[i]:
            nr, nc = pools[i].e.i - pools[ni].s.i, pools[ni].s.j - pools[i].e.j
            nv = get_permutation(nr, nc, facts)
            home_case[i] -= (nv * home_case[ni])


    # 뒤집어서 아파트 앞마당에서 해당 웅덩이 까지 다른 웅덩이를 거치지 않고 가는 경우 구하기
    for k in range(0, N):
        i = sorted_list[k]
        r, c = R - pools[i].s.i, pools[i].s.j
        back_case[i] = get_permutation(r, c, facts)

        for ni in pool_parent_graph[i]:
            nr, nc = pools[ni].e.i - pools[i].s.i, pools[i].s.j - pools[ni].e.j
            nv = get_permutation(nr, nc, facts)
            back_case[i] -= (nv * back_case[ni])

    return home_case, back_case


""" Main Process """
R, C = map(int, input()[:-1].split())
N = int(input())

sets = [0] * (N+1)
pools = [Vertex(R, 0, R, 0)]
facts = [1] * (N*2+1)
dp = [-1] * (N+1)

for i in range(N):
    pools.append(Vertex(*list(map(int, input()[:-1].split()))))

p_checker = PerformanceChecker()
p_checker.start()

# sorting
pools = sorted(pools, key=lambda p: (p.s.j, -p.s.i))

# make pool graph
pool_parent_graph, pool_child_graph, child_nums, parent_nums = make_pool_tree(pools, N)

# 팩토리얼 계산
facts = make_factorial(R+C+1)

home_case, back_case = \
    calculate(pools, pool_parent_graph, \
    pool_child_graph, parent_nums, child_nums, \
    facts, N, R, C)

ans = 0
for i in range(1, N+1):
    ans += (home_case[i] * back_case[i])
print(ans % MODULA)

p_checker.stop()
p_checker.print()