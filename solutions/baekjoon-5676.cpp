#include <iostream>
#include <vector>
#include <cmath>

typedef long long ll;
using namespace std;

int segtree_getsize(int n) { return 1 << ((int)ceil(log2((double)n)) + 1); }

ll segtree_init(vector<ll>& T, vector<ll>& A, int n, int l, int r) {
    if(r == l) T[n] = A[r];
    else {
        int m =(l+r)>>1;
        T[n] = segtree_init(T, A, (n<<1), l, m) * segtree_init(T, A, (n<<1)+1, m+1, r);
    }
    return T[n];
}
void segtree_update(vector<ll>& T, int n, int l, int r, int i, ll d) {
    if(i < l || i > r) return;
    int m = (l+r)>>1;
    
    if(l == r) {
        T[n] = d;
    }
    else {
        segtree_update(T, (n<<1), l, m, i, d);
        segtree_update(T, (n<<1)+1, m+1, r, i, d);
        T[n] = T[(n<<1)] * T[(n<<1)+1];
    }
}
ll segtree_sum(vector<ll>& T, int n, int l, int r, int i, int j) {
    if(j < l || i > r) return 1;
    else if(i <= l && r <= j) return T[n];
    else {
        int m = (l+r)>>1;
        return segtree_sum(T, (n<<1), l, m, i, j) * segtree_sum(T, (n<<1)+1, m+1, r, i, j);
    }
}

int main(void) {

    
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);
    cout.tie(NULL);

    int N, K;
    while(cin >> N >> K) {
        string res_str = "";

        vector<ll> A = vector<ll>(N+1);
        vector<ll> T = vector<ll>(segtree_getsize(N));
        string res = "";

        for(int i = 1; i <= N; i++) {
            ll v;
            cin >> v;
            if(v != 0) v = (v > 0) ? 1 : -1;
            A[i] = v;
        }

        segtree_init(T, A, 1, 1, N);


        for(int i = 0; i < K; i++) {
            
            string cmd;
            cin >> cmd;
            if(cmd == "C") {
                // 변경
                ll i, v;
                cin >> i >> v;
                if(v != 0) v = (v > 0) ? 1 : -1;
                A[i] = v;
                segtree_update(T, 1, 1, N, i, v);
            } else {
                // 출력
                ll a, b, res;
                cin >> a >> b;
                res = segtree_sum(T, 1, 1, N, a, b);
                if(res == 0) res_str += "0";
                else if(res > 0) res_str += "+";
                else res_str += "-";
            }
        }
        cout << res_str << '\n';

    }

}