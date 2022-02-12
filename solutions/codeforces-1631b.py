import sys
import math
sys.setrecursionlimit(10**6)
input = sys.stdin.readline
 
def solution(N, A):

    # 보기 편하라고 뒤집어 놓기
    A.reverse()
    if N == 1:
        return 0

    ans = 0
    p, l = A[0], 1

    while l < N:
        
        # p와 값이 다른 인덱스를 찾기 전 까지 이동
        while l < N:
            if p != A[l]:
                l -= 1
                break
            l += 1
        
        if l == N:
            # 끝까지 도달하면 멈춤
            break
        
        # r은 l의 두배
        r = (l<<1) + 1
        if r >= N:
            # r도 끝에 다다르면 N-1
            r = N-1

        for i in range(l+1, r+1):
            # l+1, r구간 중에 하나라도 값이 다르면 연산을 수행해야 한다.
            if A[i] != p:
                ans += 1
                break
        
        # r 맨 끝부분에 p값 삽입
        A[r] = p
        l = r
    return ans
 
R = []
for i in range(int(input())):
    n = int(input())
    a = list(map(int, input()[:-1].split()))
    R.append(solution(n, a))
 
for r in R:
    print(r)