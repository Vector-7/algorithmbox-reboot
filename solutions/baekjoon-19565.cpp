#include <iostream>
#include <queue>
#define MAX_N 300001

using namespace std;
typedef long long ll;

int arr[MAX_N], depth_cnt[MAX_N];
queue<int> pos[MAX_N];

int process(int d, int v) {
    if(depth_cnt[d+1] > 0) {
        depth_cnt[d+1]--;
        v = process(d+1, v);
    }
    pos[d].push(v++);
    if(depth_cnt[d+1] > 0) {
        depth_cnt[d+1]--;
        v = process(d+1, v);
    }
    return v; 
}

int main()
{
    ios_base::sync_with_stdio(false), cin.tie(nullptr), cout.tie(nullptr);

    int n;
    cin >> n;

    // 0 초기화
    fill_n(depth_cnt, n, 0);
    fill_n(arr, n, 0);
    
    for(int i = 0; i < n-1; i++) cin >> arr[i];
    depth_cnt[0] = 1;

    for(int i = 0; i < n-1; i++) {
        int d = arr[i];
        depth_cnt[d]++;

        if(depth_cnt[d] > depth_cnt[d-1]*2) {
            // 판정
            cout << "-1" << '\n';
            return 0;
        }
    }

    process(0, 1);
    cout << pos[0].front() << ' ';
    for(int i = 0; i < n-1; i++) {
        int d = arr[i];
        cout << pos[d].front() << ' ';
        pos[d].pop();
    }
    cout << '\n';

    return 0;
}