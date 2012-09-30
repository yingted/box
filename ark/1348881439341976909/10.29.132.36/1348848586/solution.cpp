#include <iostream>
#include <algorithm>
using namespace std;
int s[10000];
int sum[10000][10000];
int d[10000][10000];
int main()
{
    for (int i=0;i<10;i++) {
        fill(s,s+10000,0);
        int n;
        cin >> n;
        for (int i=0;i<n;i++) {
            cin >> s[i];
            d[i][i] = sum[i][i] = s[i];
        }

        for (int i=0;i<n-1;i++) {
            for (int j=i+1;j<n;j++)
                sum[i][j] = sum[i][j-1] + s[j];
        }

        for (int l=2;l<=n;l++) {
            for (int i=0;i<=n-l;i++) {
                int j = i+l-1;
                d[i][j] = min(d[i][j-1], d[i+1][j]) + sum[i][j];
            }
        }

        cout << d[0][n-1] << endl;
    }

    return 0;
}
