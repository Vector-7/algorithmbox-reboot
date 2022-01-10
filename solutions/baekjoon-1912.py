import sys

input = sys.stdin.readline

n = int(input())

dp = [[0] * n, [0] * n]
arr = list(map(int, input()[:-1].split()))

dp[0][0] = dp[1][0] = arr[0]

for i in range(1, n):
    dp[1][i] = max(dp[1][i-1] + arr[i], arr[i])
    dp[0][i] = max(dp[0][i-1], dp[1][i])

print(dp[0][n-1])