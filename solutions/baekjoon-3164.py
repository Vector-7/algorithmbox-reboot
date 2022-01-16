import sys
import math
input = sys.stdin.readline

MODULA = 1_000_000_007
x1, y1, x2, y2 = map(int, input()[:-1].split())

def process(x, y):
    min_p, max_p = min(x, y), max(x, y)
    res = 0

    res += 2 * math.floor(min_p/2)  * (math.floor(min_p/2) + 1) - math.floor(min_p/2)
    buf = res


    if math.floor(max_p/2) >= math.ceil(min_p/2):
        res += min_p * (math.floor(max_p/2) - math.floor(min_p/2))
    return res

s1, s2, s3, s4 = process(x2, y2), process(x1, y2), process(x2, y1), process(x1, y1)

print(s1 - s2 - s3 + s4)