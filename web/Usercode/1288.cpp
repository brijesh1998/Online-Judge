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
    int t;
    cin>>t;
    
    while(t--)
    {
        string s;
        long long ans=0;
        cin>>s;
        int c[26];
        memset(c,-1,sizeof c);
        int dp[100005];
        dp[0]=0;
         c[s[0] - 'a']=0;
        for(int i=1;i<s.size();i++)
        {
            if(c[s[i] - 'a'] == -1)
            {dp[i]=dp[i-1] + abs(s[i-1]-s[i]);
            
                c[s[i] - 'a'] = dp[i];
            }
            else
            {
                dp[i]=min(dp[i-1] + abs(s[i-1]-s[i]) , c[s[i] - 'a']);
                c[s[i]-'a']=dp[i];
            }
           // cout<<dp[i]<<" ";
        }
        //cout<<endl;
        cout<<dp[s.size() - 1]<<endl;
    }
    clog<<((double)(clock() - tStart)/CLOCKS_PER_SEC)<<endl;
    return 0;
}  