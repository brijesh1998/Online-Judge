#include <bits/stdc++.h>
using namespace std;
 
#define ll long long
#define llu long long unsigned
#define N 100005
#define MAX 1000006
#define MOD 1000000007

int main()
{
	ios_base::sync_with_stdio(false);
    cin.tie(NULL);
	   clock_t tStart = clock();
	string s;
	cin>>s;

	int q;
	cin>>q;

	while(q--)
	{
		int ty;
		cin>>ty;
		if(ty == 1)
		{
			int l,r;
			cin>>l>>r;
			--l;--r;
			int  c[26]={0};
			for(int i=l;i<=r;i++)
				c[s[i] - 'a']++;
			int ans=0;
			for(int i=0;i<26;i++)
				ans+=(c[i]*(i+1));

			cout<<ans<<endl;
		}
		else
		{
			int l,r;
			
			cin>>l>>r;
			--l;--r;
			swap(s[l],s[r]);
			//cout<<s<<endl;
		}
	}
	 clog<<((double)(clock() - tStart)/CLOCKS_PER_SEC)<<endl;
	 return 0;
}