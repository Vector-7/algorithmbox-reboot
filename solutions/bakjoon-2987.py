import sys
input = sys.stdin.readline

def ccw(p1, p2, p3):
    def __inclination(p1, p2):
        return p2[0] - p1[0], p2[1] - p1[1]
    u, v = __inclination(p1, p2), __inclination(p2, p3)
    # 시계 방향이 범위 안에 있다
    return v[0] * u[1] - v[1] * u[0]

LINE = []
TREES = []
for _ in range(3):
    x, y = map(int, input()[:-1].split())
    LINE.append((x, y))

AL = int(input())
Y = []

for _ in range(AL):
    x, y = map(int, input()[:-1].split())
    TREES.append((x, y))
    Y.append(y)

LINE.sort(key=lambda p: (p[0], p[1]))
p1 = LINE[0]
LINE = [p1] + sorted(LINE[1:], key=lambda p: -p[1])

for i in range(3):
    p1, p2 = LINE[i], LINE[(i+1)%3]
    SELECTED_TREE = []
    for tree in TREES:
        p3 = tree
        if ccw(p1, p2, p3) >= 0:
            SELECTED_TREE.append(tree)
    TREES = SELECTED_TREE

# 넓이
r = abs(
    LINE[0][0] * (LINE[1][1] - LINE[2][1]) + \
    LINE[1][0] * (LINE[2][1] - LINE[0][1]) + \
    LINE[2][0] * (LINE[0][1] - LINE[1][1])
) / 2

print(r)
print(len(TREES))