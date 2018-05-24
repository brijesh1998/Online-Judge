#include<bits/stdc++.h>

using namespace std;
#define ll long long unsigned

//const ll K=0x000000FFFFFF;
const ll s1[4][16]={{14,4,13,1,2,15,11,8,3,10,6,12,5,9,0,7},
                    {0,15,7,4,14,2,13,1,10,6,12,11,9,5,3,8},
                    {4,1,14,8,13,6,2,11,15,12,9,7,3,10,5,0},
                    {15,12,8,2,4,9,1,7,5,11,3,14,10,0,6,13}};
const ll pkey[32]={31,30,29,28,27,26,25,24,23,22,21,20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0};
        
ll expand(ll n)
{
	ll split[8];
	for(int i=0;i<8;i++)
	{
		split[i]=(n&15);
		n=(n >> 4);
	}
	ll ans=0;
	for(int i=7;i>=0;i--)
	{
		ll data=(((split[i] | ((split[(i+7)%8]&1)<<4))<<1) | (split[(i+1)%8]>>3)&1);
		ans=(ans<<6) | data;
	}
	cout<<"Expanded R : "<<ans<<endl;
	return ans;
}

ll sbox(ll n)
{
	ll split[8];
	for(int i=0;i<8;i++)
	{
		split[i]=(n&63);
		n=(n >> 6);
		//cout<<split[i]<<" ";
	}
	ll ans=0;
	for(int i=7;i>=0;i--)
	{
		ll row=(((split[i]>>5)&1)<<1) | (split[i]&1);
		ll col=(split[i]&31)>>1;
		ans=((ans<<4) | s1[row][col]);
	}
	cout<<"After S-Box : "<<ans<<endl;
	
	return ans;
}
ll perm(ll n)
{
	int bin[32];
	for(int i=0;i<32;i++)
	{
		bin[pkey[i]]=n&1;
		n=n>>1;
	}
	ll ans=0;
	for(int i=31;i>=0;i--)
	ans=((ans<<1) | bin[i]);
	
	cout<<"After permutation : "<<ans<<endl;cout<<endl;
	return ans;
}
ll encry(ll data, ll K)
{
	for(int i=0;i<16;i++)
	{
		ll L=(data >> 32);
		ll R=(data & 4294967295);
		ll newR=expand(R);
		ll sb=sbox(newR ^ K);
		ll pr=perm(sb);
		ll nR=((L ^ pr)&0xFFFFFFFF);
		L=R;
		data= (((L << 32)&(0xFFFFFFFF00000000)) | nR);		
	}
	return data;
}
ll decry(ll data, ll K)
{
	for(int i=15;i>=0;i--)
	{
		ll L=(data >> 32);
		ll R=(data & 4294967295);
		ll newL=expand(L);
		ll sb=sbox(newL ^ K);
		ll pr=perm(sb);
		ll nL=((R ^ pr)&0xFFFFFFFF);
		R=L;
		data=(((nL << 32)&(0xFFFFFFFF00000000)) | R);		
	}
	return data;
}
int main()
{
	cout<<"encryption : \n";
	ll en=encry(1234,3103);
	cout<<"decryption : \n";
	ll de=decry(en,3103);
	cout<<"After encryption : "<<en<<endl;
	cout<<"After decryption : "<<de<<endl;
	return 0;
}
