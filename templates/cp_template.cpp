#include <bits/stdc++.h>
using namespace std;

// Constants
const int MOD = 1e9 + 7;
const int INF = 2e9;
const long long LINF = 1e18;
const int MAXN = 2e5 + 5;
const double EPS = 1e-9;

// Useful defines
#define all(x) (x).begin(), (x).end()
#define rall(x) (x).rbegin(), (x).rend()
#define sz(x) (int)(x).size()
#define to(i, a, b) for(int i = (a); i <= (b); i++)
#define til(i, a, b) for(int i = (a); i < (b); i++)
#define cdiv(a,b) ((a)+(b)-1)/(b)
#define vtin(T, n, arr) int n; cin >> n; vector<T> arr(n); for(auto& x : arr) cin >> x;

// Debug macro (only works in LOCAL)
#ifdef LOCAL
#define debug(...) _debug(#__VA_ARGS__, __VA_ARGS__)
template <typename T> void _debug(const char *name, T &&arg) {
  cerr << name << " = " << arg << endl;
}
template <typename T, typename... Args>
void _debug(const char *names, T &&arg, Args &&...args) {
  const char *comma = strchr(names + 1, ',');
  cerr.write(names, comma - names) << " = " << arg << " | ";
  _debug(comma + 1, args...);
}
// Pretty print for containers
template <typename T> void debug_container(const T &container) {
  cerr << "[ ";
  for (const auto &x : container)
    cerr << x << " ";
  cerr << "]\n";
}
#else
#define debug(...) 42
#define debug_container(...) 42
#endif

// Fast I/O setup
void fast_io() {
  ios::sync_with_stdio(false);
  cin.tie(nullptr);
  cout.tie(nullptr);
}

// File I/O setup (LOCAL only)
void file_io() {
#ifdef LOCAL
  freopen("input.txt", "r", stdin);
  freopen("output.txt", "w", stdout);
#endif
}

void solve() {
    
}

int main() {
  fast_io();
  file_io();
  int tc;  

#ifdef LOCAL
  tc = 1;
#else
  tc = 1;
#endif

  while (tc--) {
    solve();
  }
  return 0;
}
