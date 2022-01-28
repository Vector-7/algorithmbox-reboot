#include <iostream>
#include <vector>
using namespace std;

typedef long long ll;
#define MODULA 900528

int main() {

    ios_base::sync_with_stdio(false);
    cin.tie(NULL);
    cout.tie(NULL);

    vector<int> hash_map = vector<int>(200);
    
    string t, p;
    ll res, buf;
    cin >> t >> p;
    int tl = t.size();

    for(int i = 0; i < tl; i++) hash_map[int(t[i])] = i+1;

    res = 0; buf = 1;
    for(int i = p.size()-1; i >= 0; i--) {
        res = (res + (buf * hash_map[int(p[i])])) % MODULA;
        buf = (buf * tl) % MODULA;
    }

    cout << res << '\n';

}