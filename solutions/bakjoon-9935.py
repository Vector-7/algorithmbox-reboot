import sys
input = sys.stdin.readline

STR = input()[:-1]
C4 = list(input()[:-1])
LC4 = len(C4)

S = []
LS = 0 # 문자열 길이
for char in STR:
    S.append(char)
    LS += 1

    if LS >= LC4:
        # 비교
        if S[-LC4:] == C4:
            # 문자열 같으면 제거
            LS -= LC4
            del S[-LC4:]

if not S:
    print("FRULA")
else:
    print(''.join(S))