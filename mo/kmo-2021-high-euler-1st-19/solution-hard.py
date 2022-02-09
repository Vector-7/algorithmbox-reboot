import sys
import collections
from functools import cmp_to_key
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

""" Functions """
def compare(v1, v2):
    if v1.e.j < v2.s.j:
        return -1
    elif v1.e.j == v2.s.j:
        if v1.e.i <= v2.s.i:
            return -1
        else:
            return 1
    else:
        return 1

def is_included(parent, child):
    if (parent.e.j <= child.s.j) and (parent.e.i >= child.e.i):
        return True
    else:
        return False

def make_pool_tree(pools, N):
    
    # 위상 그래프 생성
    pool_child_graph = collections.defaultdict(list)
    pool_parent_graph = collections.defaultdict(list)
    child_nums = [0] * (N+1)
    
    def __make_pool_tree(pools, N, i):
        for j in range(i+1, N+1):
            if is_included(pools[i], pools[j]):
                if i > 0:
                    pool_parent_graph[j].append(i)
                    pool_child_graph[i].append(j)
                    child_nums[i] += 1

                if child_nums[j] == 0:
                    # 아직 연결이 안되어 있음
                    __make_pool_tree(pools, N, j)
    __make_pool_tree(pools, N, 0)

    return pool_parent_graph, pool_child_graph, parent_nums



""" Main Process """
R, C = map(int, input()[:-1].split())
N = int(input())

sets = [0] * (N+1)
pools = [Vertex(R, 0, R, 0)]
facts = [1] * (N*2+1)
dp = [-1] * (N+1)

for i in range(N):
    pools.append(Vertex(*list(map(int, input()[:-1].split()))))

# sorting
pools = sorted(pools, key=cmp_to_key(compare))

# make pool graph
pool_parent_graph, pool_child_graph, child_nums = make_pool_tree()