#include <iostream>
#define MAX 15
#define E_MAX 32768

using namespace std;

void search(int (&tree)[E_MAX+1][2], int n) {
    cout << n << ' ';
    if(tree[n][0] != -1) search(tree, tree[n][0]);
    if(tree[n][1] != -1) search(tree, tree[n][1]);
}

int main(void) {
    ios::sync_with_stdio(false); cin.tie(nullptr); cout.tie(nullptr);
    // 거듭제곱 전처리
    int pows[MAX+1] = {1, }; int tree[E_MAX+1][2];
    int n = 0; cin >> n;
    // init
    for(int i = 1; i <= MAX; i++) pows[i] = pows[i-1] * 2;
    for(int i = 0; i <= E_MAX; i++) tree[i][0] = tree[i][1] = -1;
    
    for(int i = 1; i < n-1; i++) {
        int start = pows[i-1], end = pows[i] - 1;
        while(start <= end) {
            tree[start][0] = pows[i] + start - pows[i-1];
            tree[start][1] = tree[start][0] + pows[i-1];
            start++;
        }
    }

    // final
    int start = pows[n-2], end = pows[n-1] - 1;
    while(start <= end) {
        tree[start][0] = (pows[n]-1) - (start - pows[n-2]);
        tree[start][1] = tree[start][0] - pows[n-2];
        start++;
    }

    search(tree, 1);

    return 0;
}