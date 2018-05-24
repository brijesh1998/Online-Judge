#include "cstdio"
#include "string"
#include "algorithm"
#include "iostream"

using namespace std;

#define MAX 100005

long long BIT[MAX];

void update(int x, int val) {
	while(x < MAX) {
		BIT[x] += val;
		x += x &-x;
	}
}

long long query(int x) {
	long long ans = 0;
	while(x > 0) {
		ans += BIT[x];
		x -= x &-x;
	}
	return ans;
}

int main() {
	string s;
	cin >> s;
	for(int i = 0 ; i < s.size() ; i++) {
		update(i + 1, s[i] - 'a' + 1);
	}	
	int Q;
	scanf("%d", &Q);
	while(Q--) {
		int type, l, r;
		scanf("%d", &type);
		scanf("%d%d", &l, &r);
		if(type == 2) {
			update(l, s[r - 1] - s[l - 1])
			update(r, s[l - 1] - s[r - 1]);
			swap(s[l - 1], s[r-1]);
		}
		else {
			printf("%lld\n", query(r) - query(l - 1));
		}
	}
	return 0;
}
