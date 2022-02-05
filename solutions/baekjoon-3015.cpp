#include <iostream>
#include <vector>
#include <stack>
#include <deque>
#include <algorithm>

using namespace std;

typedef long long ll;

ll get_size(vector<int>& A, int N) {

	ll res = 0; stack<pair<int, int>> S;
	S.push(pair<int, int>{A[0], 1});
	
	for(int i = 1; i < N; i++) {
		int e = A[i];
		if(S.top().first == e) {
			
			// 동일한 경우
			res += S.top().second;
			S.push(pair<int, int>{e, S.top().second + 1});
			if((int)S.size() > S.top().second) res++;

		} else if(S.top().first > e) {
			res++;
			S.push(pair<int, int>{e, 1});
		} else {
			while(!S.empty() && S.top().first < e) {
				res++; S.pop();
			}
			if(!S.empty() && S.top().first == e) {
				// 높이가 같은 요소를 만난 경우
				res += S.top().second;
				S.push(pair<int, int>{e, S.top().second + 1});
				if((int)S.size() > S.top().second) res++;
			} else if(!S.empty() && S.top().first > e) {
				// 더 큰 값을 만났을 경우
				res++;
				S.push(pair<int, int>{e, 1});
			} else S.push(pair<int, int>{e, 1});
		}
	}
	return res;
}

int main(void) {
	
    ios_base::sync_with_stdio(false);
    cin.tie(nullptr); cout.tie(nullptr);

	int N; vector<int> A;

	cin >> N;
	A = vector<int>(N, 0);
	for(int i = 0; i < N; i++) cin >> A[i];

	cout << get_size(A, N) << '\n';

	return 0;
}