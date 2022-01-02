import sys
sys.setrecursionlimit(100_000_000)
input = sys.stdin.readline

N = int(input())
in_order = input()[:-1].split()
post_order = input()[:-1].split()
pre_order = []

# index() big O가 O(n) 이기 때문에 바로 인덱스를 찾을 수 있는 dict 하나 생성
# index_map: 중위 
index_map = { in_order[i]: i for i in range(len(in_order)) }

def __process(left: int, right: int, postorder_mid_idx: int):
    # left, right: in_order의 index
    # right_in_post_order: post_order에서의 right
    if left == right:
        # 하나의 원소를 가리키는 경우
        pre_order.append(in_order[left])
    else:
        # mid_val 값 구하기
        mid_val = post_order[postorder_mid_idx]

        # 값 추가
        pre_order.append(mid_val)

        # inorder에서의 mid_idx 구하기
        mid_idx = index_map[mid_val]

        # left, right 길이 구하기
        left_len = mid_idx - left
        right_len = right - mid_idx

        if left_len > 0:
            __process(left, mid_idx - 1, postorder_mid_idx - 1 - right_len)
        if right_len > 0:
            __process(mid_idx + 1, right, postorder_mid_idx - 1)
__process(0, N - 1, N - 1)

print(*pre_order)