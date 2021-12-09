import sys
import collections

class AutomataSearcher:
    def __init__(self, table: list[tuple], start, ends):
        self.map = collections.defaultdict(dict)
        self.start_node = start
        self.end_nodes = ends

        for record in table:
            start_node, terminal, next_node = record
            self.map[start_node][terminal] = next_node

    def check(self, signal) -> bool:
        status = self.start_node
        for s in signal:
            _s = int(s)
            if _s not in self.map[status]:
                # 못찾음
                return False
            status = self.map[status][_s]
        if status not in self.end_nodes:
            return False
        return True

automata = AutomataSearcher(
    [ 
        (1, 0, 2), (2, 1, 3), (3, 0, 2), (3, 1, 4),
        (1, 1, 4), (4, 0, 5), (5, 0, 6), (6, 0, 6), (6, 1, 7), (7, 0, 2),
        (7, 1, 8), (8, 1, 8), (8, 0, 9), (9, 1, 3), (9, 0, 6)
    ], 1, [3, 7, 8]
)

signal = input()

if automata.check(signal):
    print("SUBMARINE")
else:
    print("NOISE")