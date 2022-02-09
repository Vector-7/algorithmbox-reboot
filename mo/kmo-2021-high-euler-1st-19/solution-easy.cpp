#include <iostream>
#include <vector>
#include <stack>
#include <tuple>
#include <chrono>

using namespace std;
using namespace chrono;
typedef long long ll;

int main()
{
    ios_base::sync_with_stdio(false);
    cin.tie(nullptr);
    cout.tie(nullptr);

    vector<int> di = vector<int>{-1, 0};
    vector<int> dj = vector<int>{0, 1};
    vector<vector<int>> graph;
    stack<tuple<int, int, int>> stack;

    int R, C, N;
    cin >> R >> C;
    cin >> N;
    R++; C++;

    // 시작, 끝점
    pair<int, int> start = make_pair(R-1, 0);
    pair<int, int> end = make_pair(0, C-1);

    // 그래프 초기화
    graph = vector<vector<int>>(R, vector<int>(C, 0));

    
    for(int i = 0; i < N; i++) {
        int i1, j1, i2, j2;
        cin >> i1 >> j1 >> i2 >> j2;
        graph[i1][j1] = graph[i2][j2] = 1;
    }

    stack.push(make_tuple(start.first, start.second, 0));
    // i, j, 물웅덩이 건넌 횟수
    long long ans = 0;

    while(!stack.empty()) {
        int i, j, cnt;
        i = get<0>(stack.top()); j = get<1>(stack.top()); cnt = get<2>(stack.top());
        stack.pop();
        

        // 끝점에 도달했을 경우
        if(i == end.first && j == end.second) {
            // 한번 구간을 지나쳐야만 인정된다.
            if(cnt == 1) ans++;
        } else {
            // 아닌 경우
            for(int k = 0; k < 2; k++) {
                int ni = i + di[k];
                int nj = j + dj[k];

                if(!(0 <= ni && ni < R && 0 <= nj && nj < C)) continue;

                if(graph[ni][nj] == 1 && graph[i][j] == 1) {
                    if(cnt == 1) continue;
                    else stack.push(make_tuple(ni, nj, 1));
                } else stack.push(make_tuple(ni, nj, cnt));   
            }
        }
    }

    cout << ans << '\n';
    return 0;
}
