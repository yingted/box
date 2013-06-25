#include<iostream>
#include<string>
#include<utility>
#include<queue>
#include<list>
#include<map>
#include<algorithm>
using namespace std;
typedef unsigned long long ull;
typedef pair<ull,pair<int,pair<string,pair<int,queue<ull>*> > > >entry;
#define ts first
#define lm second.ts
#define text second.lm
#define del second.text
#define ctry second.second.second.second
int main(){
	map<string,queue<ull> >s_delay;
	list<queue<ull>*>s_ctry;
	priority_queue<entry,vector<entry>,greater<entry> >clients;
	for(ull t,i=0;cin>>t;++i){
#define proc(cond)		while(!clients.empty()&&(cond)){\
			const entry cl=clients.top();\
			clients.pop();\
			cout<<cl.ts<<' '<<cl.text<<endl;\
			if(cl.del!=-1){\
				s_ctry.push_back(cl.ctry);\
				cl.ctry->push(cl.del);\
			}\
		}
		proc(clients.top().ts<t);
		string req,country;
		cin>>req>>country;
		queue<ull>&lst=s_delay[country];
		cout<<t<<' '<<req<<' '<<country<<' ';
		ull delay(0);
#define accept(del,text,country)	{delay=del;clients.push(make_pair(t+delay,make_pair(i,make_pair(text,make_pair(delay,country)))));}
		if(req=="up"){
			cin>>delay;
			cout<<delay;
			lst.push(delay);
			s_ctry.push_back(&lst);
		}else{
			string path;
			cin>>path;
			cout<<path;
			if(!lst.empty()){
				s_ctry.erase(find(s_ctry.begin(),s_ctry.end(),&lst));
				accept(lst.front(),"200 "+country+" "+path,&lst);
				lst.pop();
			}else if(!s_ctry.empty()){
				queue<ull>*lst=s_ctry.front();
				accept(lst->front(),"200 "+country+" "+path,lst);
				s_ctry.pop_front();
				lst->pop();
			}else if(!clients.empty())
				accept(0,"503 "+country+" "+path,&lst);
		}
		cout<<endl;
	}
	proc(true);
	return 0;
}
