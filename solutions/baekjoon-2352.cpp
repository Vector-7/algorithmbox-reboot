#include <iostream>
#include <vector>

using namespace std;

int binary_search(vector<int>& A, int l, int r, int k) {
    if(l >= r) return l;
    else {
        int m = (l+r)>>1;
        if(A[m] == k) return m;
        else if(A[m] < k) return binary_search(A, m+1, r, k);
        else return binary_search(A, l, m, k);
    }
}

int main(void) {

    ios_base::sync_with_stdio(false);
    cin.tie(nullptr); cout.tie(nullptr);

    int n; vector<int> A; vector<int> R;
    cin >> n;
    A = vector<int>(n, 0);
    R = vector<int>(n, 0);
    for(int i = 0; i < n; i++)
        cin >> A[i];
    
    int j = -1;

    for(int i = 0; i < n; i++) {
        if(j == -1) R[++j] = A[i];
        else {
            if(R[j] < A[i]) R[++j] = A[i];
            else R[binary_search(R, 0, j, A[i])] = A[i]; 
        }
        /*
        for(int k = 0; k <= j; k++) cout << R[k] << ' ';
        cout << endl;
        */
    }
    cout << j+1 << endl;
    return 0;
}