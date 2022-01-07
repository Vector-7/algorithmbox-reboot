
import sys
input = sys.stdin.readline


def __gcd(a, b):
    if b > a:
        a, b = b, a
    while b != 0:
        a %= b
        a, b = b, a
    return a

t = int(input())

R = []
for _ in range(t):
    
    n = int(input())
    g = [0] * (2)
    arr = list(map(int, input()[:-1].split()))
    
    for i in range(n):
        g[i % 2] = __gcd(g[i % 2], arr[i])
    
    good = [True] * 2
    
    for i in range(n):
        good[i % 2] = good[i % 2] and (arr[i] % g[(i % 2) ^ 1] > 0)

    ans = 0
    for i in range(2):
        if good[i]:
            ans = max(ans, g[i^1])

    R.append(str(ans))

print('\n'.join(R))
    