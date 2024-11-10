#include <bits/stdc++.h>
using namespace std;

// Debug macros
#define debug(x) cerr << #x << " = "; _print(x); cerr << endl;
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
template<class T, class V> void _print(map<T, V> v) {
    cerr << "[ "; for(auto i : v) {_print(i); cerr << " ";} cerr << "]";
}

// Add your solution class here
#define all(x) (x).begin(), (x).end()
#define to(i, a, b) for(int i = (a); i <= (b); i++)
#define til(i, a, b) for(int i = (a); i < (b); i++)
#define cdiv(a,b) ((a)+(b)-1)/(b)

class Solution {
public:
    
    
    
};

// Add test cases
void runTests() {
    Solution sol;
    
    //vector<int> nums1 = {1, 2, 3};
    //assert(sol.example(nums1) == 6 && "Test case 1 failed");
    
    cout << "All test cases passed!" << endl;
}

int main() {
    runTests();
    return 0;
}
