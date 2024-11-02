#include <bits/stdc++.h>
using namespace std;

// Debug macros - not for submission
#ifdef LOCAL
    #define debug(x) cerr << #x << " = "; _print(x); cerr << endl;
    #define debugar(arr,i,n) cerr<<#arr<<" = [ "; for(int j=i;j<n;j++) cerr<<arr[j]<<" "; cerr<<"]"<<endl;
    void _print(int x) {cerr << x;}
    void _print(long long x) {cerr << x;}
    void _print(double x) {cerr << x;}
    void _print(char x) {cerr << '\'' << x << '\'';}
    void _print(string x) {cerr << '"' << x << '"';}
    void _print(bool x) {cerr << (x ? "true" : "false");}
    template<class T> void _print(vector<T> v) {
        cerr << "[ "; for(T i : v) {_print(i); cerr << " ";} cerr << "]";
    }
    template<class T> void _print(set<T> v) {
        cerr << "{ "; for(T i : v) {_print(i); cerr << " ";} cerr << "}";
    }
    template<class T> void _print(multiset<T> v) {
        cerr << "{ "; for(T i : v) {_print(i); cerr << " ";} cerr << "}";
    }
    template<class T, class V> void _print(pair<T, V> p) {
        cerr << "{"; _print(p.first); cerr << ","; _print(p.second); cerr << "}";
    }
    template<class T, class V> void _print(map<T, V> v) {
        cerr << "[ "; for(auto i : v) {_print(i); cerr << " ";} cerr << "]";
    }
    template<class T, class V> void _print(unordered_map<T, V> v) {
        cerr << "[ "; for(auto i : v) {_print(i); cerr << " ";} cerr << "]";
    }
#else
    #define debug(x)
    #define debugar(arr,i,n)
#endif

// Fast I/O
void fastIO() {
    ios::sync_with_stdio(0);
    cin.tie(0);
    cout.tie(0);
    #ifdef LOCAL
        freopen("input.txt", "r", stdin);
    #endif
}

// ---------------- Start of Solution (Copy from here) ----------------
// Constants
const int MOD = 1e9 + 7;
const int INF = 2e9;
const long long LINF = 1e18;
const int MAXN = 2e5 + 5;

// Useful defines - needed for submission
#define all(x) (x).begin(), (x).end()
#define rall(x) (x).rbegin(), (x).rend()
#define rep(i,a,b) for(int i=(a);i<=(b);++i)
#define per(i,a,b) for(int i=(a);i>=(b);--i)

class Solution {
public:
    void solve() {
        
        
        
    }
};
// ---------------- End of Solution (Copy to here) ----------------

#ifdef LOCAL
void runTests() {
    ifstream in("input.txt");
    string line;
    vector<pair<string, string>> tests;
    
    while (getline(in, line)) {
        if (line.empty()) continue;
        string input = line;
        if (!getline(in, line)) break;
        tests.push_back({input, line});
    }
    
    cout << "Running " << tests.size() << " tests...\n\n";
    
    int passed = 0;
    for (int t = 0; t < tests.size(); t++) {
        cout << "Test #" << t + 1 << ":\n";
        
        stringstream test_input(tests[t].first);
        stringstream actual_output;
        auto cin_buff = cin.rdbuf(test_input.rdbuf());
        auto cout_buff = cout.rdbuf(actual_output.rdbuf());
        
        Solution().solve();
        
        cin.rdbuf(cin_buff);
        cout.rdbuf(cout_buff);
        
        string output = actual_output.str();
        
        while (!output.empty() && (output.back() == '\n' || output.back() == ' ')) 
            output.pop_back();
        string expected = tests[t].second;
        while (!expected.empty() && (expected.back() == '\n' || expected.back() == ' ')) 
            expected.pop_back();
        
        cout << "Input: " << tests[t].first << '\n';
        cout << "Your output: " << output << '\n';
        cout << "Expected: " << expected << '\n';
        if (output == expected) {
            cout << "Passed!\n";
            passed++;
        } else {
            cout << "Failed!\n";
        }
        cout << "\n";
    }
    
    cout << "Results: " << passed << "/" << tests.size() << " tests passed!\n";
}
#endif

int main() {
    fastIO();
    
    #ifdef LOCAL
        runTests();
    #else
        int t = 1;
        // cin >> t;
        while(t--) {
            Solution().solve();
        }
    #endif
    
    return 0;
}