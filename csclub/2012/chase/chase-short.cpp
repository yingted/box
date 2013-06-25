#include<iostream>
#include<vector>
#include<algorithm>
using namespace std;
#define UNREACHEABLE -1
#define REACHEABLE -2
int main(){//42 lines and 42 characters in the comment!
	int v,e,n,t;
#define SET(arr,val) for(int j=0;j<v;(arr)[j++]=(val));
	cin>>v>>e>>n>>t;
	vector<int>g[v];
	int*a=new int[v],*b=new int[v];
	for(int x,y;e--;){
		cin>>x>>y;
		g[x].push_back(y);
		if(x!=y)g[y].push_back(x);
	}
	SET(a,UNREACHEABLE)
	for(int x;n--;a[x]=REACHEABLE)
		cin>>x;
	for(b[0]=-3;t--;swap(a,b))
		for(int i=0;i<v;++i){
			b[i]=UNREACHEABLE;
			vector<int>::const_iterator it=g[i].begin(),
				end=g[i].end();
#define FOR_A_TO_B(x)			for(;it!=end;++it)\
				if(a[*it]!=UNREACHEABLE&&a[*it]!=i){\
					b[i]=x;\
					break;\
				}
			FOR_A_TO_B(*it++)
			FOR_A_TO_B(REACHEABLE)
		}
	for(int i=n=0;i<v;++i)
		n+=a[i]!=UNREACHEABLE;
	cout<<v<<' '<<n;
	for(int i=0;i<v;++i)
		if(a[i]!=UNREACHEABLE)
			cout<<' '<<i;
	cout<<endl;
	return 0;
}
