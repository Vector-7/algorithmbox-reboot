#include <stdio.h>
#include <math.h>

int solution(int n, int m, int k)
{
	int i;
	if(m+k-1>n) return -1;
	if(ceil(n/(double)k)>m) return -1;
	
	for(i=k;i>=1;i--) printf("%d ", i);
	if(m>1)
	{
		int i = k;
		int j = (m-1);
		while(j>0)
		{
			int a;
			int p = (int)(n-i)/j;
			i += p;
			for(a=i;a>i-p;a--) printf("%d ", a);
			j--;
		}
	}
	return 0;
}

int main(void)
{
	int n,m,k;
	scanf("%d %d %d", &n, &m, &k);
	int res = solution(n,m,k);
	if(res == -1)	printf("-1\n");
	return 0;
}