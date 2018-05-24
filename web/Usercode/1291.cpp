#include <cmath>
#include <cstdio>
#include <vector>
#include <iostream>
#include <algorithm>
using namespace std;


int main() {
    /* Enter your code here. Read input from STDIN. Print output to STDOUT */   
    int i,j,t,n;
    cin>>t;
    while(t--)
    {
        int sum=0;
        cin>>n;
        int a[n],b[n],original[n];
        for(i=0;i<n;i++)
        {
            cin>>a[i];
            sum+=a[i];
        }
        for(i=0;i<n;i++)
        {
            cin>>b[i];
            sum+=b[i];
        }
        cout<<sum/(n+1)<<endl;
    }
    return 0;
}