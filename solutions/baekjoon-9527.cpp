#include <iostream>
#include <vector>
#include <cmath>

typedef long long ll;
using namespace std;

vector<ll> f = vector<ll>(55);
vector<ll> DP = vector<ll>(55);

/*
재귀쓰면 메모리 초과발생
ll process(ll n) {
    if(n == 0) return 0;
    else if(n == 1) return 1;
    ll k = floor(log2(n));
    return DP[k-1] + process(n - (ll)(1<<k)) + (n - ((ll)(1<<k) - 1));
}
*/

ll process(ll n) {
    ll ans = 0;
    while(n > 1) {
        ll k = floor(log2(n));
        ans += DP[k-1] + (n - ((ll)pow(2, k) - 1));
        n = (n - (ll)pow(2, k));
    }
    if(n == 1) ans++;
    return ans;
}

int main(void) {

    ios_base::sync_with_stdio(false);
    cin.tie(nullptr); cout.tie(nullptr);

    ll a, b;
    cin >> a >> b;

    f[0] = 1;
    
    for(int i = 1; i <= 54; i++) {
        for(int j = 0; j < i; j++) f[i] += f[j];
        f[i] += (ll)pow(2, i);
    }
    DP[0] = 1;
    for(int i = 1; i <= 54; i++) DP[i] = DP[i-1] + f[i];

    cout << process(b) - process(a-1) << '\n';

    return 0;
}