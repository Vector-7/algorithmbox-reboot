#include <iostream>
#include <vector>
#define MODULA 1000000007

using namespace std;
typedef long long ll;

ll ans = 0;
int R, C, N;
vector<ll> facts;

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

    return 0;
}
