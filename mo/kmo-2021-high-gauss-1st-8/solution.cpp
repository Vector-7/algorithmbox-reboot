#include <iostream>
#include <vector>

using namespace std;
typedef long long ll;

int solution(int n, ll a) {

    ll x, s;
    s = 0;
    for(int i = 1; i <= n; i++) s += i;
    x = s - a;

    if(x == 0) return 0;
    
    ll low_sum = 0; ll high_sum = 0;
    int k_size = 0;

    for(int i = 1; i <= n; i+=2) {
        low_sum += i;
        high_sum += (n - i);

        if(low_sum % 2 != x % 2) continue;

        if(x < low_sum) return k_size;
        else if(x >= low_sum && x <= high_sum) { 
            k_size++;
        }
    }
    return k_size;
}

int main()
{
    ios_base::sync_with_stdio(false);
    cin.tie(nullptr);
    cout.tie(nullptr);
    
    int t = 0;
    vector<int> res;
    cin >> t;
    for(int i = 0; i < t; i++) {
        int n; ll a;
        cin >> n >> a;
        res.push_back(solution(n, a));
    }
    for(int i = 0; i < (int)res.size(); i++)
        cout << res[i] << '\n';

    return 0;
}
