#include <iostream>
#include <algorithm>
using namespace std;
int sum[1000][1000];
int d[1000][1000];
int main()//
{
    for (int c=0;c<10;c++) {
        int n;
        cin >> n;
        for (int i=0;i<n;i++) {
            cin >> sum[i][i];
            d[i][i] = sum[i][i];
        }

        for (int i=0;i<n-1;i++) {
            for (int j=i+1;j<n;j++)
                sum[i][j] = sum[i][j-1] + d[j][j];
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
