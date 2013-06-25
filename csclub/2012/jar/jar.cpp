#include<iostream>
#include<bitset>
using namespace std;
static int a[1000][999],al[1000],b;
static bitset<1<<20>pkg;
static bitset<20>mask[1000];
void dfs(int cur){
	if(mask[cur][b])return;
	mask[cur][b]=true;
	pkg[mask[cur].to_ulong()]=true;
	for(int i=0,l=al[cur],*acur=a[cur];i<l;++i)
		dfs(acur[i]);
}
int main(){
	int n;
	cin>>n;
	int p[20],pl=0;
	bitset<1000>mask;
	for(int i=0;i<n;++i){
		char ch;
		cin>>ch>>al[i];
		for(int j=0;j<al[i];--a[i][j++])
			cin>>a[i][j];
		if(ch=='p')
			p[pl++]=i;
	}
	for(int i=0;i<pl;dfs(p[b]))
		b=i++;
	cout<<pkg.count()-pkg[0]<<endl;
	return 0;
}
