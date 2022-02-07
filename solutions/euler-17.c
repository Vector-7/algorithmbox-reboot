#include <stdio.h>
#include <math.h>

int factorials[10];

void run(int n, int* visited, int depth, char* res) {

    register int i = 0;
    
    if(depth == 1) {
        // 마지막 숫자 하나를 남겨놓은 경우
        for(i=0;i<10;i++) {
            if(!visited[i]) {
                // 아직 사용하지 않은 숫자
                res[10-depth] = i + '0';
                break;
            }
        }
    } else {
        int cnt = floor(n/factorials[depth-1]);

        for(i=0;i<10;i++) {
            if(!visited[i]) {
                // 사용하지 않은 숫자
                cnt--;
                if(cnt == -1) {
                    // 도달
                    visited[i] = 1;
                    res[10-depth] = i + '0';
                    break;
                }
            }
        }
        run(n%factorials[depth-1], visited, depth-1, res);
    }
}


int main(void)
{
    int n = 1000000;
    register int i = 0;
    int visited[10] = {0};
    char res[10] = {0};

    // init factorial
    factorials[1] = 1;
    for(i=2;i<10;i++) factorials[i] = factorials[i-1] * i;

    // init visited
    for(i=0;i<10;i++) visited[i] = 0;

    // task
    run(n-1, visited, 10, res);

    // print
    for(i=0;i<10;i++) printf("%c", res[i]);
    printf("\n");


    return 0;
}