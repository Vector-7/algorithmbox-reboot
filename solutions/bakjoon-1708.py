import sys
input = sys.stdin.readline

def inclination(p1, p2):
    return p2['x'] - p1['x'], p2['y'] - p1['y']

def ccw(p1, p2, p3):
    v, u = inclination(p1, p2), inclination(p2, p3)
    # 0 초과일 경우 시계 반대 방향이다.
    return True if v[0] * u[1] - v[1] * u[0] > 0 else False

def process(P):
    S = [] # stack
    
    for p3 in P:
        while len(S) >= 2:
            # 시계방향이 되는 시점을 검토해 좌표를 수정한다
            p1, p2 = S[-2], S[-1]
            if ccw(p1, p2, p3):
                # 반시계 방향을 만나게 되면 더이상 수정할 필요 없음
                break
            # 시계방향이면 시계방향의 원인인 중간 지점인 p2 삭제
            S.pop()
        S.append(p3)
    return len(S)

N, answer = int(input()), -2
P = []
for i in range(N):
    x, y = map(int, input()[:-1].split())
    P.append({'x': x, 'y': y})

# 윗부분 블록 껍질 구하기
P.sort(key=lambda p: (p['x'], p['y']))
answer += process(P)

# 아랫쪽 블록 껍질 구하기
P.reverse()
answer += process(P)

print(answer)