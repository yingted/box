/*
* This solution demonstrates many useful features of C++.
* It takes the brute-force approach.
* It also takes about 4× the lines of the original code
*/
#include<iostream>
#include<vector>
#include<algorithm>//need for swap
/*
* C++ library functions come in namespaces so that names are less likely to be
* reused. For example, std::cin can be abbreviated to cin if you are using the
* std namespace.
*/
using namespace std;
/*
* C++ macros are a feature which allows the preprocessor to substitute "tokens"
* before the compiler even sees them. A token can be thought of the basic unit
* of syntax highlighting (i.e. a number, a variable, a bracket, etc.). You can
* define macros anywhere above where you need them in the same file, and you
* can include them. By convention, macros are UPPERCASE.
*/
#define UNREACHEABLE -1
#define REACHEABLE -2
#define UNDEFINED -3//cannot be equal to a valid value
/*
* C++ macros can also take arguments to substitute in. However, order of
* operations is evaluated after, so you usually want brackets around the
* variables.
*/
#define MEMSET(arr,val,num) for(int j=0;j<(num);(arr)[j++]=(val));
/*
* The main function is the entry point for the program.
*/
int main(){
	int v,e,n,t;
#define SET(arr,val) MEMSET((arr),(val),v)
/*
* std::cin is a special value defined in iostream. The right shift operator is
* often used as the stream extraction operator, since it is unlikely that both
* will make sense on the same object.
*/
	cin>>v>>e>>n>>t;
/*
* vector is the dynamic array data structure, which is arguably the second-most
* used data structure, after the string datatypes. This type of allocation is
* a stack allocation. It happens to be good enough (but just barely; 64-bit
* doesn't work), but you should try to use the next type of allocation (see
* below). In case you really don't want to initialize your memory, if you know
* the size, you can use the keyword "static", which can prevent memory problems.
*/
	vector<int>g[v];
/*
* The "new" operator dynamically allocates memory. This is different way than
* the one used for the previous allocation (of g). However, you should always
* initialize the arrays after you allocate them. Also, you (sort of) need to
* free the memory using delete (not done here).
*/
	int*a=new int[v],*b=new int[v];
/*
* You can declare variables in a "for" statement.
*/
	for(int x,y;e--;){
		cin>>x>>y;
/*
* The fast insertion function is called push_back
*/
		g[x].push_back(y);//install two-way streets
		if(x!=y)
/*
* Pointers are dangerous and can cause injury.
* TFAE:
*  g[y].push_back(x);
*  g[y].vector::push_back(x);
*  g[y].std::vector::push_back(x);
*  (g+y)->push_back(x);
*  (&g[y])->push_back(x);
*/
			(y+g)->vector::push_back(x);
	}
/*
* Macros can nest. The semicolon is not needed, since the macro includes one.
*/
	SET(a,UNREACHEABLE)
	for(int x;n--;a[x]=REACHEABLE)
		cin>>x;//copy in the list
/*
* stl::swap swaps two references with each other.
* Also, all parts of a for loop are optional. Some interesting cases are:
* - for(;condition;)…
*   > behaves like while(condition) with the same number of characters and the
*     added bonus that it can be extended without having to change for to while
* - for(int i=0;;++i)…
*   > counts up and repeats the loop
* - for(int i=0;i<n;++i)…
*   > regular for loop
* - for(int i=1;i<1<<n;i<<=1)…
*   > use for bit manipulation
* - page*a;int n;
*   …
*   for(page*b;n--;swap(a,b))…//read from a, write to b
*   > page flip n times, see below
* - for(;;)…
*   > infinite loop, but shorter than while(true)
* - the iterator loop (see below)
*/
	for(b[0]=UNDEFINED;t--;swap(a,b))//get from a to b t times
		for(int i=0;i<v;++i){
			b[i]=UNREACHEABLE;
/*
* The use of the const_iterator guarantees that the vector is traversed in
* asymptotically good time, without modifying the contents.
* Also, the begin value is where the input begins. It is the location of the
* first value. When using this much stl, turn on optimization. You need it.
*/
			vector<int>::const_iterator it=g[i].begin(),
/*
* Long statements can wrap.
* Also, the end value means "right after the last value", and encountering it
* means you have reached the end of the data.
*/
				end=g[i].end();
/*
* Macros can only span one line, but backslashes can be used to wrap lines. The
* single-line comments that start with "//" can only be used on the last line.
*/
			//move from a[*it] to b[i] iff a[*it] didn't come from i
#define FOR_A_TO_B(x)			for(;it!=end;++it)\
				if(a[*it]!=UNREACHEABLE&&a[*it]!=i){\
					b[i]=x;\
					break;\
				}//a comment here is fine
/*
* Each time the macro expands *it++, the value is evaluated again. Also, in the
* special case where it does not expand it at all (or never encounters it), the
* value is not used. The expression is expanded in-place, which is good since
* the iterator is not defined here.
*/
			FOR_A_TO_B(*it++)
			FOR_A_TO_B(REACHEABLE)
		}
/*
* Assignment statements take on an lvalue corresponding to the assigned value.
*/
	for(int i=n=0;i<v;++i)
/*
* C++ has weak typing.
*/
		n+=a[i]!=UNREACHEABLE;//count
/*
* Character types are denoted with single quotes
*/
	cout<<v<<' '<<n;
	for(int i=0;i<v;++i)
		if(a[i]!=UNREACHEABLE)
			cout<<' '<<i;//output
/*
* The special value endl inserts a newline and flushes a stream.
*/
	cout<<endl;
/*
* In C, numbers are used to specify how operations turned out, with 0 meaning
* ok, negative numbers meaning fatal errors, and positive numbers meaning non-
* fatal errors. While C++ does have built-in exceptions, return codes are still
* used by some programs. This last line is optional for contests, though.
*/
	return 0;
}
