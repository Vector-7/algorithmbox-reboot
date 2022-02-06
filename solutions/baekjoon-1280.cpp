#include <iostream>
#include <vector>
#include <cmath>

#define MODULA 1000000007
#define MAX_SIZE 200000

using namespace std;
typedef long long ll;

void fenwick_update(vector<pair<int, ll>>& T, vector<pair<int, ll>>& A, int N, int i) {
    A[i].first++;
    A[i].second += i;
    int buf_i = i;
    while(i <= N) {
        T[i].first++;
        T[i].second += buf_i;
        i += (i & -i);
    }
}
pair<int, ll> fenwick_sum(vector<pair<int, ll>>& T, int i) {
    pair<int, ll> ans = pair<int, ll>(0, 0);
    while(i > 0) {
        ans.first += T[i].first;
        ans.second += T[i].second;
        i -= (i & -i);
    }
    return ans;
}

int main()
{
    ios_base::sync_with_stdio(false);
    cin.tie(nullptr);
    cout.tie(nullptr);

    int N; ll ans = 1;
    vector<pair<int, ll>> A, T;

    pair<int, ll> MAX_T = pair<int, ll>{0, 0};
    ll zeros = 0;

    cin >> N;
    A = vector<pair<int, ll>>(MAX_SIZE+1, pair<int, ll>{0, 0});
    T = vector<pair<int, ll>>(MAX_SIZE+1, pair<int, ll>{0, 0});

    for(int i = 0; i < N; i++) {
        int k; cin >> k;
        ll res = 0;

        if(i == 0) {
            //아무것도 없는 경우
            if(k == 0) zeros++;
            else {
                fenwick_update(T, A, MAX_SIZE, k);
                MAX_T.first++; MAX_T.second += k;
            }
            continue;
        }

        // 우측 범위 구하기
        pair<int, ll> left = fenwick_sum(T, k);
        
        // 좌측 범위 구하기
        pair<int, ll> right = MAX_T;
        right.first -= left.first; right.second -= left.second;

        // zeros 추가
        left.first += zeros;

        res += ((k * (ll)left.first) - left.second);
        res += (right.second - (k * (ll)right.first));

        ans = (ans * (res % MODULA)) % MODULA;

        if(k == 0) zeros++;
        else {
            fenwick_update(T, A, MAX_SIZE, k);
            MAX_T.first++; MAX_T.second += k;
        }
    }
    
    cout << ans << '\n';
    return 0;
}
