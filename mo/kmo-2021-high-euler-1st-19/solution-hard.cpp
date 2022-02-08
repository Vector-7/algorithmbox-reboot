#include <iostream>
#include <vector>
#define MODULA 1000000007

using namespace std;
typedef long long ll;

ll ans = 0;
int R, C, N;
vector<ll> facts;
vector<tuple<int, int, int, int>> pools;

int main()
{
    ios_base::sync_with_stdio(false);
    cin.tie(nullptr);
    cout.tie(nullptr);
    
    cin >> R >> C;
    cin >> N;

    facts = (R > C) ? vector<ll>(R) : vector<ll>(C);
    facts[0] = 1;
    
    // 팩토리얼
    for(int i = 1; i < (int)facts.size(); i++)
        facts[i]  = (facts[i] * facts[i-1]) % MODULA;
    
    for(int i = 0; i < N; i++) {
        int y1, x1, y2, x2;
        cin >> y1 >> x1 >> y2 >> x2;
        pools.push_back(make_tuple(y1, x1, y2, x2));
    }

    return 0;
}
