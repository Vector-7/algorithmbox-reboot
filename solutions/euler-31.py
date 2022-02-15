import math
import collections

def f(a, b):
    res = []

    # 제곱인 아닌 최초의 수 구하기
    nums = [1] * (a+1)
    dp_set = {}
    for i in range(2, a+1):
        if nums[i] == 1:
            j = i*i
            while j <= a:
                nums[j] = i
                j *= i
    
    # table 생성
    for i in range(a, 1, -1):
        if nums[i] == 1 and i not in dp_set:
            dp_set[i] = [True] * (b+1)
            dp_set[i][0] = dp_set[i][1] = False
        elif nums[i] > 1 and nums[i] not in dp_set:
            if nums[i] not in dp_set:
                k = int(math.log(i,nums[i]))
                dp_set[nums[i]] = [False] * (k*b+1)
                for j in range(2, b+1):
                    dp_set[nums[i]][j] = True
    
    for i in range(2, a+1):
        if i not in dp_set:
            k = nums[i]
            p = int(math.log(i,k))
            for j in range(p, b*p+1, p):
                dp_set[k][j] = True
    

    ans = 0
    for k in dp_set.keys():
        ans += collections.Counter(dp_set[k])[True]
    return ans
print(f(100, 100))