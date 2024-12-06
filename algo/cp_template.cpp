#include <bits/stdc++.h>
#ifdef LOCAL
#include "debug.h"
#endif
using namespace std;

const int       MOD  = 1e9 + 7;
const int       INF  = 2e9;
const long long LINF = 1e18;
const int       MAXN = 2e5 + 5;
const double    EPS  = 1e-9;

#define all(x) (x).begin(), (x).end()
#define rall(x) (x).rbegin(), (x).rend()
#define sz(x) (int)(x).size()
#define to(i, a, b) for (int i = (a); i <= (b); i++)
#define rto(i, a, b) for (int i = (a); i >= (b); i--)
#define til(i, a, b) for (int i = (a); i < (b); i++)
#define rtil(i, a, b) for (int i = (a); i > (b); i--)
#define cdiv(a, b) ((a) + (b) - 1) / (b)
#define vtin(T, n, arr) \
    int n;              \
    cin >> n;           \
    vector<T> arr(n);   \
    for (auto &x : arr) cin >> x;

void fast_io() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    cout.tie(nullptr);
}

void file_io() {
    freopen("IN", "r", stdin);
    freopen("OUT", "w", stdout);
    freopen("ERR", "w", stderr);
}

void solve() {
    // Your solution here
}

int main() {
    fast_io();
    int tc = 1;

#ifdef LOCAL
    file_io();
    tc = 1;
#endif

    while (tc--) { solve(); }
    return 0;
}
