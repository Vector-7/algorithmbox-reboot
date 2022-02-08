import sys
input = sys.stdin.readline
MODULA = 1_000_000_000 + 7

def process(N, K):
    r = 1       # 제곱수 (N**0, N**1 ... N**i)
    ans = 0
    i = 0       # while문 돌 때마다 1씩 증가
    while K > 0:
        if i > 0:
            # i가 1이상일 때만 제곱한다
            r = (r * N) % MODULA
        if K & 1 == 1:
            # K에 0x01이 있는 경우만 ans를 합한다.
            ans = (ans+r) % MODULA
        i += 1
        # K를 앞으로 땡기기
        K = K>>1
    return ans


R = []
for _ in range(int(input())):
    n, k = map(int, input()[:-1].split())
    R.append(process(n, k))


for r in R:
    print(r)
