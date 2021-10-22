#include <stdio.h>

int binary_search(int* test_case, int len, int e);

int
main()
{
    int test_case[6] = {1,3,4,6,7,8};
    int len = 6;
    int e = 3;
    printf("%d\n", binary_search(test_case, len, e));
    return 0;
}

int
__binary_search(int* arr, int len, int e, int left, int right)
{
    int mid = (left + right) / 2;
    if(left > right) return -1;
    else if(arr[mid] == e) return mid;
    else if(arr[mid] > e) return __binary_search(arr, len, e, left, mid - 1);
    else if(arr[mid] < 3) return __binary_search(arr, len, e, mid + 1, right);
    else return -1;
}

int
binary_search(int* test_case, int len, int e)
{ return __binary_search(test_case, len, e, 0, len - 1); }
