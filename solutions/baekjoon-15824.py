import sys
input = sys.stdin.readline

MODULA = 1_000_000_007

n = int(input())
arr = [-1] + list(map(int, input()[:-1].split()))

udp = [0] * (n+2)   # 1부터 n까지 올라감
ddp = [0] * (n+2)   # n부터 1까지 내려감
pow_dp = [1] * (n+1)    # 2제곱

# 제곱 처리
for i in range(1, n+1):
    pow_dp[i] = (pow_dp[i-1] * 2) % MODULA

# sorting
arr.sort()

ans = 0
for i in range(1, n):
    udp[i] = (udp[i-1] + arr[i]) % MODULA
    ddp[n+1-i] = (ddp[n+2-i] + arr[n+1-i]) % MODULA
    ans += ((ddp[n+1-i] - udp[i]) * pow_dp[n-1-i]) % MODULA
    ans %= MODULA
print(ans)