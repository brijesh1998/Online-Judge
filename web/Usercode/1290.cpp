#include <bits/stdc++.h>
using namespace std;
 
#define ll long long
#define llu long long unsigned
#define N 100005
#define MAX 1000006
#define MOD 1000000007



int main()
{

	//ios_base::sync_with_stdio(false);
    //cin.tie(NULL);
     
    clock_t tStart = clock();
    
    int t;
    scanf("%d",&t);
    while(t--)
    {
		int n;
		scanf("%d",&n);

		int suff[1003],pref[1003];

		for(int i=0;i<n;i++) cin>>pref[i];
		for(int i=0;i<n;i++) cin>>suff[i];
		if(n == 1)
		{
			printf("%d\n",pref[0]);
			continue;
		}
		if(n == 2)
		{
			if((pref[0] == suff[1]) && (pref[1] == suff[0]))
				printf("%d\n",max(pref[0],suff[0]));
			else if((pref[0] == suff[1]) && (pref[1] != suff[0]))
				printf("%d\n", pref[0]);
			else
				printf("%d\n",suff[0]);

			continue;
		}
		int i=0;
		int a=pref[i] + suff[(i+1)%n];
		i=(i+1)%n;
		int b=pref[i] + suff[(i+1)%n];
		i=(i+1)%n;
		int c=pref[i] + suff[(i+1)%n];
		int ans;
		if(a == b)
			ans=a;
		else if(b  == c)
			ans=b;
		else if(a == c)
			ans=a;
		printf("%d\n",ans);

	}

 	clog<<((double)(clock() - tStart)/CLOCKS_PER_SEC)<<endl;
	return 0;
}	