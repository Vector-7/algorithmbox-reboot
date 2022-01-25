#include <iostream>
#include <vector>

#define MAX_CANDY_LEVEL 1000000

typedef long long ll;
using namespace std;

void fenwick_update(vector<ll>& T, int N, int i, ll d) {
    while(i <= N) { T[i] += d; i += (i & -i); }
}
ll fenwick_sum(vector<ll>& T, int i) {
    ll ans = 0;
    while(i > 0) { ans += T[i]; i -= (i & -i); }
    return ans;
}

void add_candy(vector<ll>& T, vector<ll>& A, int i, ll d) {
    A[i] += d;
    fenwick_update(T, MAX_CANDY_LEVEL, i, d);
}
ll out_candy(vector<ll>& T, vector<ll>& A, int i) {
    int l = 1; int r = MAX_CANDY_LEVEL; int m; int ans;
    while(l <= r) {
        m = (l+r)>>1;
        ll d_max = fenwick_sum(T, m);
        ll d_min = d_max - A[m] + 1;

        if(d_max < i) l = m + 1;
        else if(i < d_min) r = m - 1;
        else {
            if(A[m] == 0) r = m - 1;
            else { ans = m; break; }
        }
    }
    add_candy(T, A, ans, -1);
    return ans;
}

typedef long long ll;
using namespace std;

int main(void) {

    ios_base::sync_with_stdio(false);
    cin.tie(NULL);
    cout.tie(NULL);

    vector<ll> A = vector<ll>(MAX_CANDY_LEVEL+1, 0);
    vector<ll> T = vector<ll>(MAX_CANDY_LEVEL+1, 0);
    vector<ll> res;

    int N;
    cin >> N;
    for(int i = 0; i < N; i++) {
        int a, b, c;
        cin >> a;
        if(a == 1) {
            cin >> b;
            res.push_back(out_candy(T, A, b));
        } else {
            cin >> b >> c;
            add_candy(T, A, b, c);
        }
    }

    for(int i = 0; i < res.size(); i++) cout << res[i] << '\n';
    return 0;
}