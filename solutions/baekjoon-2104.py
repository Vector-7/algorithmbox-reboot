import sys
input = sys.stdin.readline

def solution(N, A):
    max_val = A[0] ** 2
    stack = [0]
    S = [0] * N
    S[0] = A[0]
    
    # 누적합 계산
    for i in range(1, N):
        S[i] = S[i-1] + A[i]
    
    for i in range(1, N):
        if A[i] > A[stack[-1]]:
            # 앞의 값이 더 큰 경우
            cur_val = S[i] * A[stack[-1]] if len(stack) == 1 else (S[i] - S[stack[-2]]) * A[stack[-1]]
            max_val = max(max_val, A[i]**2, cur_val)
        else:
            while stack and A[stack[-1]] >= A[i]:
                j = stack.pop()
                max_val = max(max_val, (S[i-1] - S[stack[-1]]) * A[j]) if stack \
                    else max(max_val, S[i-1]*A[j])
            max_val = max(max_val, (S[i] - S[stack[-1]]) * A[i]) if stack \
                else max(max_val, S[i] * A[i])
        stack.append(i)

    while stack:
        j = stack.pop()
        max_val = max(max_val, (S[N-1]-S[stack[-1]])*A[j]) if stack \
            else max(max_val, S[N-1]*A[j])
    return max_val

n = int(input())
a = list(map(int, input()[:-1].split()))
print(solution(n,a))