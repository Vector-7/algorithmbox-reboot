#include <iostream>
#include <vector>
#include <algorithm>

typedef long long ll;
using namespace std;

int main(void) {

    ios_base::sync_with_stdio(false);
    cin.tie(nullptr); cout.tie(nullptr);

    int n = 0;
    cin >> n;

    vector<int> arr = vector<int>(n);
    vector<int> log;
    vector<pair<int, int>> idx_log;
    for(int i = 0; i < n; i++) cin >> arr[i];

    for(int i = 0; i < n; i++) {
        if(log.empty() || log[log.size()-1] < arr[i]) {
            log.push_back(arr[i]);
            idx_log.push_back(pair<int, int>{log.size()-1, arr[i]});
        }
        else {
            int nidx = lower_bound(log.begin(), log.end(), arr[i]) - log.begin();
            log[nidx] = arr[i];
            idx_log.push_back(pair<int, int>{nidx, arr[i]});
        }
    }

    vector<int> res;
    int k = log.size()-1;
    for(int i = idx_log.size()-1; i >= 0; i--) {
        if(k == -1) break;
        if(k == idx_log[i].first) {
            res.push_back(idx_log[i].second);
            k--;
        }
    }
    cout << res.size() << '\n';
    for(int i = res.size()-1; i >= 0; i--) cout << res[i] << ' ';
    cout << '\n';
    

    return 0;
}