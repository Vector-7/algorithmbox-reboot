import sys
input =  sys.stdin.readline

class Node:
    val: str
    childs: set
    indexes: list


    def __init__(self, val=None):
        self.val=val
        self.childs = {}
        self.indexes = []


L = []
N = int(input())
for _ in range(N):
    _raw = input()[:-1].split()
    L.append(_raw[1:])

head = Node()

# setting
for foods in L:
    cur_node = head
    for food in foods:
        if food not in cur_node.indexes:
            new_node = Node(food)
            cur_node.childs[food] = new_node
            cur_node.indexes.append(food)
        cur_node = cur_node.childs[food]

# search
S = [(head, -1)]
while S:
    node, depth = S.pop()
    # sorting child
    node.indexes.sort(reverse=True)
    for child in node.indexes:
        S.append((node.childs[child], depth + 1))
    if depth > -1:
        space = "--" * depth
        print(f"{space}{node.val}")
