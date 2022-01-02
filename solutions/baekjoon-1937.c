#include <stdio.h>
#include <string.h>

unsigned int cnt_arr[500][500] = {0};
unsigned int graph[500][500] = {0};

int di[4] = {0, 0, 1, -1};
int dj[4] = {1, -1, 0, 0};

unsigned int dfs(const unsigned int _N, unsigned int _i, unsigned int _j);

int main(void)
{
    unsigned int n = 0;
    register unsigned int i, j;
    unsigned int max_cnt = 0;

    scanf("%d", &n);
    memset(graph, 0, sizeof(unsigned int*) * n);

    for(i=0; i<n; i++)
        for(j=0; j<n; j++)
            scanf("%d", &graph[i][j]);

    for(i=0; i<n; i++)
        for(j=0; j<n; j++)
            if(!cnt_arr[i][j])
            {
                unsigned int res_cnt = dfs(n, i, j);
                if(res_cnt > max_cnt)
                    max_cnt = res_cnt;
            }
    
    printf("%d\n", max_cnt);
    return 0;
}

unsigned int
dfs(const unsigned int _N, unsigned int _i, unsigned int _j)
{
    unsigned int ni, nj;    // 다음 위치
    register unsigned int i;
    unsigned int result_cnt = 0;
    for(i=0; i<4; i++)
    {
        ni = _i + di[i]; nj = _j + dj[i];
        if((0 <= ni && ni < _N) && (0 <= nj && nj < _N)) // 범위 안
        {
            unsigned int returned_cnt = 0;
            if(graph[_i][_j] < graph[ni][nj])
            {
                if(!cnt_arr[ni][nj])
                    returned_cnt = dfs(_N, ni, nj);
                else
                    returned_cnt = cnt_arr[ni][nj];
                if(returned_cnt > result_cnt)
                    result_cnt = returned_cnt;
            }
        }
    }
    result_cnt++;
    cnt_arr[_i][_j] = result_cnt;
    
    return result_cnt;
}