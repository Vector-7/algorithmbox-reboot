import sys
input = sys.stdin.readline

n = int(input())
R = []

def process(S):
    x = list(map(int, list(S)))
    decimal_checked = False
    
    for i in range(len(x)-2, -1, -1):
        c = x[i] + x[i + 1]
        if c >= 10:
            x[i + 1] = c - 10
            x[i] = 1
            decimal_checked = True
            break
    if not decimal_checked:
        x[1] += x[0]
        x.pop(0)
    
    return ''.join([chr(c + ord('0')) for c in x])

for _ in range(n):
    s = input()[:-1]
    R.append(process(s))

for r in R:
    print(r)