#include <bits/stdc++.h>
#define ll long long int
#define si(x) scanf("%d",&x)
using namespace std;

int q,n; 
char s[100010];
int seg[262145],a[100010],st;

int makeseg(int l,int r,int pos){

    if(l==r){
        return (seg[pos]=a[l]);
    }
    
    int mid=(l+r)/2;
        
    return (seg[pos]=(makeseg(l,mid,2*pos+1)+makeseg(mid+1,r,2*pos+2)));
}

int ans(int l,int r,int s,int e,int pos){

    if(l<=s&&r>=e)
        return seg[pos];

    if(s>r||e<l) return 0;

    int mid=(s+e)/2;

    return (ans(l,r,s,mid,2*pos+1)+ans(l,r,mid+1,e,2*pos+2));

}

void update(int which,int s,int e,int val,int pos){
    
    seg[pos]+=val;  

    if(s==e) return;

    int mid=(s+e)/2;

    if(mid<which)
        update(which,mid+1,e,val,2*pos+2);
    else
        update(which,s,mid,val,2*pos+1);

}

int main(){

    scanf(" %s",s);
    n=strlen(s);
    
    for(int i=0;i<n;i++)
        a[i]=s[i]-'a'+1;

    makeseg(0,n-1,0);
    
    int l,r,which;

    si(q);


    while(q--){
        
        si(which),si(l),si(r);
        l--;
        r--;
	while(1){}
        if(which-1){
            int up=a[l]-a[r];
            update(r,0,n-1,up,0);
            update(l,0,n-1,-up,0);
            swap(a[l],a[r]);
        }else{
            printf("%d\n",ans(l,r,0,n-1,0));
        }
    }

    return 0;
}
