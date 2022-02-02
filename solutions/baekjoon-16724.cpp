#include <iostream>
#include <vector>
#include <stack>

typedef long long ll;
using namespace std;



bool draw_line(vector<vector<char>>& g, vector<vector<int>>& v, int si, int sj, int color) {

    stack<pair<int, int>> s;
    int i = si; int j = sj;
    int res = true;

    while(v[i][j] == -1) {
        v[i][j] = 0;
        s.push(pair<int, int>{i, j});

        // next area
        switch(g[i][j]) {
            case 'L': j--; break;
            case 'R': j++; break;
            case 'U': i--; break;
            case 'D': i++; break;
            default: break;
        }
    }

    // 이미 지나간 곳에 만난 경우
    // safe zone 갯수 갱신하지 않음
    if(v[i][j] > 0) {
        res = false;
        color = v[i][j];
    }
    while(!s.empty()) {
        pair<int, int> log = s.top();
        v[log.first][log.second] = color;
        s.pop();
    }
    return res;
}

int main(void) {

    ios_base::sync_with_stdio(false);
    cin.tie(nullptr); cout.tie(nullptr);

    vector<vector<int>> visited;
    vector<vector<char>> graph;

    int n, m;
    int ans = 0;
    cin >> n >> m;

    visited = vector<vector<int>>(n, vector<int>(m, -1));
    graph = vector<vector<char>>(n, vector<char>(m, 0));

    for(int i = 0; i < n; i++) {
        string buf;
        cin >> buf;
        for(int j = 0; j < buf.length(); j++)
            graph[i][j] = buf.at(j);
    }

    for(int i = 0; i < n; i++) {
        for(int j = 0; j < m; j++) {
            if(visited[i][j] == -1)
                if(draw_line(graph, visited, i, j, ans+1))
                    ans++;
        }
    }

    cout << ans << '\n';
    

    return 0;
}