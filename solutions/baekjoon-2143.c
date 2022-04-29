#include <stdio.h>
#include <stdlib.h>
#define MAX 1000
#define CASE_MAX 1000000

int compare(const void* o1, const void* o2)
{
    int n1 = *(int*)o1;
    int n2 = *(int*)o2;
    
    if(n1 > n2) return 1;
    else if(n1 < n2) return -1;
    else return 0;
}

int main(void)
{
	int t, n, m, v, l, r;
	register int i,j,k,ak,bk;
	int a[MAX], b[MAX];
	int sa[CASE_MAX], sb[CASE_MAX];
	long long ans = 0;

	scanf("%d", &t);
	scanf("%d", &n);
	for(i=0;i<n;i++) 
	{ 
		scanf("%d", &v); 
		a[i] = (i==0 ? v : a[i-1] + v);
	}
	
	scanf("%d", &m);
	for(i=0;i<m;i++) 
	{ 
		scanf("%d", &v); 
		b[i] = (i==0 ? v : b[i-1] + v); 
	}

	for(i=0;i<CASE_MAX;i++) sa[i] = sb[i] = 1e9+7;

	k=0;
	for(i=0;i<n;i++)
		for(j=i;j<n;j++)
			sa[k++] = a[j] - (i==0 ? 0 : a[i-1]);
	ak=k;
	k=0;
	for(i=0;i<m;i++)
		for(j=i;j<m;j++)
			sb[k++] = b[j] - (i==0 ? 0 : b[i-1]);
	bk=k;

	// sort sb
	qsort(sb, bk, sizeof(int), compare);
	for(k=0;k<ak;k++)
	{
		int v = t - sa[k];	// 찾아야 할 값
		l = 0, r = bk;
		long long lc, rc;

		// lower bound
		while(l<r)
		{
			int m = (l+r)>>1;
			if(sb[m] < v) l = m+1;
			else r = m;
		}
		lc = r;

		// upper bound
		l = 0; r = bk;
		while(l<r)
		{
			int m = (l+r)>>1;
			if(sb[m] <= v) l = m+1;
			else r = m;
		}
		rc = r;
		ans += (rc - lc);
	}
	printf("%lld\n", ans);
	return 0;
}