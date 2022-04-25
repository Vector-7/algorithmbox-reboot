#include <iostream>
#include <queue>
using namespace std;

int di[4] = {0, 0, -1, 1};
int dj[4] = {1, -1, 0, 0};

int main(void)
{
    ios::sync_with_stdio(false); cin.tie(nullptr); cout.tie(nullptr);

    int N, M, G[100][100], V[100][100], cnt;
    cin >> N >> M;
    for(int i=0; i<N; i++)
    {
        for(int j=0; j<M; j++)
        {
            cin >> G[i][j];
            V[i][j] = 0;
        }
    }

    // 정답
    cnt = 0;

    while(1)
    {
        // BFS를 이용하여 바깥 공기가 접해있는 칸을 조사
        queue<pair<int, int>> q;
        q.push(make_pair(0, 0));
        V[0][0] = cnt+1;
        while(!q.empty())
        {
            pair<int, int> e = q.front();
            q.pop();
            int i = e.first, j = e.second;
            for(int k=0; k<4; k++)
            {
                int ni = i+di[k], nj = j+dj[k];
                // 범위 밖
                if(!((0<=ni&&ni<N)&&(0<=nj&&nj<M))) continue;
                // 벽 여부와 방문 여부
                if(G[ni][nj] || V[ni][nj] == cnt+1) continue;
                V[ni][nj] = cnt+1;
                q.push(make_pair(ni, nj));
            }
        }

        // 바깥공기와 두 면 이상이 접해 있는 치즈 없애기
        int removed = 0;
        for(int i=0; i<N; i++)
        {
            for(int j=0; j<M; j++)
            {
                if(G[i][j])
                {
                    int a = 0;
                    for(int k=0; k<4; k++)
                    {
                        int ni = i+di[k], nj = j+dj[k];
                        if(V[ni][nj] == cnt+1) a++;
                    }
                    if(a>=2)
                    {
                        G[i][j] = 0;
                        removed++;
                    }
                }
            }
        }
        if(removed==0) break;
        cnt++;
    }
    cout << cnt << '\n';
    return 0;
}