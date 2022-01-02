import sys
import collections
input = sys.stdin.readline

LEFT = -1
CENTRE = 0
RIGHT = 1

N, x, y = map(int, input()[:-1].split())
CASE_P = {'x': x, 'y': y}
del x
del y

P = []
for _ in range(N):
    x, y = map(int, input()[:-1].split())
    P.append({'x':x, 'y':y})

def ccw(p1, p2, p3):
    def __inclination(_p1, _p2):
        return _p2['x'] - _p1['x'], _p2['y'] - _p1['y']
    u, v = __inclination(p1, p2), __inclination(p2, p3)
    
    # 0 초과일 경우 시계 반대 방향
    # 0 일 경우 일직선
    # 0 이하일 경우 시계 방향

    r = v[0] * u[1] - v[1] * u[0]
    if r > 0:
        return LEFT
    elif r == 0:
        return CENTRE
    else:
        return RIGHT

def solution(N, P, CASE_P):

    def __p2k(p):
        # 포인트를 USED 키로 컨버팅
        return f"{p['x']}-{p['y']}"

    PL = len(P) # 좌표 갯수
    # 처리된 좌표 표시를 위한 used 배열 생성
    USED = {__p2k(p): False for p in P}
    wall_cnt = 0 # 겹 수

    def __make_wall():

        def __routine():
            S = collections.deque() # stack

            for p3 in P:
                # 이미 쓴건 재사용 불가
                if USED[__p2k(p3)]:
                    continue

                while len(S) >= 2:
                    # 스택에 2개 이상의 좌표가 들어있는 경우
                    p1, p2 = S[-2], S[-1]
                    _c = ccw(p1, p2, p3)
                    if _c == LEFT or _c == CENTRE:
                        # 반시계 방향을 만나게 되거나 일직선일 경우
                        break
                    # 시계방향의 원인인 p2제거
                    S.pop()
                S.append(p3)

            # S의 좌표로 벽을 만들거기 때문에 USED에 갱신
            for p in S:
                USED[__p2k(p)] = True
            return S
        
        # 윗껍질
        P.sort(key=lambda p: (p['x'], p['y']))
        new_wall = __routine()
        # 마지막 부분 중복을 막기 위해 제거
        fst_p, lst_p = new_wall.popleft(), new_wall.pop()
        USED[__p2k(fst_p)] = USED[__p2k(lst_p)] = False

        P.reverse()
        new_wall += __routine()

        return new_wall
    
    def __is_cave_in_wall(wall):
        
        # 돌아가면서 ccw가 시계 반대 방향이면 안에 있는거다
        WL = len(wall)
        for i in range(WL):
            li = i
            ri = li + 1
            if ri == WL:
                ri = 0
            lp, rp = wall[li], wall[ri]

            if ccw(lp, rp, CASE_P) != LEFT:
                return False
        return True


    # Main Process
    while True:

        # 담벼락 구하기
        new_wall = __make_wall()

        # 감옥이 벽 안에 있는 지 조사한다
        if __is_cave_in_wall(new_wall):
            # 감옥 안에 있는 경우 카운터를 올린다
            wall_cnt += 1
        else:
            # 그렇지 않은 경우 더 이상 진행할 수 없으므로 break 처리한다
            return wall_cnt

        # USED 찾아서 3개 이하만 사용이 되지 않으면 더이상 담을 만들 수 없으므로
        # break 처리한다.
        c = collections.Counter(list(USED.values()))
        if c[False] < 3:
            return wall_cnt

    return wall_cnt


if N < 3:
    print(0)
else:
    print(solution(N,P,CASE_P))