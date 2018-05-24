#include <bits/stdc++.h>
using namespace std;
 
#define ll long long
#define llu long long unsigned
#define N 100005
#define MAX 1000006
#define MOD 1000000007

const int size=1000;

int cnt[1003][26];

int main()
{
	ios_base::sync_with_stdio(false);
    cin.tie(NULL);
	   clock_t tStart = clock();
	string s;
	cin>>s;
	int n=s.size();
	//int size=sqrt(n);
	int tot_bkts=(n-1)/size;

	for(int i=0;i<n;i++)
	{
		cnt[i/size][s[i] - 'a']++;
	}
	/*for(int i=0;i<=tot_bkts;i++)
	{
		for(int j=0;j<26;j++)
			cout<<cnt[i][j]<<" ";
		cout<<endl;
	}*/
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
			int c[26]={0};
			int bl=l/size,br=r/size;
			int lim1=min((bl+1)*size-1, r);
			if(bl == br)
				lim1=r;
			for(int i=l;i<=lim1;i++)
				c[s[i] - 'a']++;

			for(int i=bl+1;i<br;i++)
				for(int j=0;j<26;j++)
					c[j]+=cnt[i][j];

			int start=br*size;
			for(int i=start;i<=r && br!=bl;i++)
				c[s[i] - 'a']++;

			int ans=0;
			for(int j=0;j<26;j++)
			ans+=(c[j]*(j+1));
			cout<<ans<<endl;
			
		}
		else if(ty == 2)
		{
			int l,r;
			
			cin>>l>>r;
			--l;--r;
			cnt[l/size][s[l] - 'a']--;
			cnt[l/size][s[r] - 'a']++;
			cnt[r/size][s[r] - 'a']--;
			cnt[r/size][s[l] - 'a']++;
			char tmp=s[l];
			s[l]=s[r];
			s[r]=tmp;
			
		}
	}
clog<<((double)(clock() - tStart)/CLOCKS_PER_SEC)<<endl;
	return 0;
}