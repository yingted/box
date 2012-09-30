#include<iostream>
#include<fstream>
#include<string>
#include<algorithm>
using namespace std;
const inline bool bp(char x,char y){
	return(x==' '||x=='\t')&&
		(y==' '||y=='\t');
}
const static string es("");
const string&clean(string&s){
	ssize_t st=s.find_first_not_of(" \t");
	if(st==string::npos)
		return es;
	s=s.substr(st,s.find_last_not_of(" \t")-st);
	s.resize(unique(s.begin(),s.end(),bp)-s.begin());
	return s;
}
int main(int argc,char*argv[]){
	if(argc!=3)
		return-1;
	ifstream ans(argv[1]),sol(argv[2]);
	int tot=0,eq=0,like=0;
	for(string yes,maybe;getline(ans,yes);++tot)
		if(sol.good()&&getline(sol,maybe)){
			if(yes==maybe)
				++eq;
			else if(clean(yes)==clean(maybe))
				++like;
		}	
	cout<<tot<<' '<<eq<<' '<<like<<' '<<(sol.peek()==EOF)<<endl;
	return 0;
}
