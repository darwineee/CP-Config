-- Basic Settings
vim.opt.syntax = 'on'
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.mouse = 'a'
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.showcmd = true
vim.opt.showmatch = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.clipboard = 'unnamed'
vim.opt.ruler = false
vim.opt.wildmenu = true
vim.opt.laststatus = 2
vim.opt.belloff = 'all'
--vim.opt.colorcolumn = '80'
vim.opt.cursorline = true

-- Theme setting
vim.cmd('colorscheme slate')

-- Performance settings
vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 0
vim.opt.ttyfast = true
vim.opt.lazyredraw = true

-- Create keymap function for better readability
local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

-- Compilation and Running (using C++20)
-- F7: Just build to check syntax
map('n', '<F7>', ':w<CR>:!g++ -std=c++20 -Wall -Wextra % -o %:r<CR>')

-- F8: Build with LOCAL flag and run
map('n', '<F8>', ':w<CR>:!g++ -std=c++20 -O2 -Wall -DLOCAL % -o %:r && ./%:r<CR>')

-- Custom mappings for competitive programming
vim.keymap.set('i', '{{', '{<CR>}<Esc>ko')
vim.keymap.set('i', ',<', 'cout << ')
vim.keymap.set('i', ',>', 'cin >> ')

-- Common snippets
vim.keymap.set('i', ',pb', 'push_back()<Esc>i')
vim.keymap.set('i', ',ppb', 'pop_back()<Esc>i')
vim.keymap.set('i', ',pf', 'push_front()<Esc>i')
vim.keymap.set('i', ',ppf', 'pop_front()<Esc>i')
vim.keymap.set('i', ',fr', 'for(int i = 0; i < n; i++) {<CR>}<Esc>O')
vim.keymap.set('i', ',ll', 'long long')
vim.keymap.set('i', ',v', 'vector<><Esc>i')
vim.keymap.set('i', ',s', 'set<><Esc>i')
vim.keymap.set('i', ',st', 'stack<><Esc>i')
vim.keymap.set('i', ',q', 'queue<><Esc>i')
vim.keymap.set('i', ',dq', 'deque<><Esc>i')
vim.keymap.set('i', ',m', 'map<><Esc>i')
vim.keymap.set('i', ',hm', 'unordered_map<><Esc>i')
vim.keymap.set('i', ',hs', 'unordered_set<><Esc>i')

-- Auto-pairs
vim.keymap.set('i', '(', '()<Esc>i')
vim.keymap.set('i', '[', '[]<Esc>i')
vim.keymap.set('i', '{', '{}<Esc>i')
vim.keymap.set('i', '"', '""<Esc>i')
vim.keymap.set('i', "'", "''<Esc>i")

-- Status line configuration
-- Timer initialization
vim.g.start_time = os.time()

-- Function to format elapsed time
function _G.get_elapsed_time()
    local elapsed = os.time() - vim.g.start_time
    local hours = math.floor(elapsed / 3600)
    local minutes = math.floor((elapsed % 3600) / 60)
    local seconds = elapsed % 60
    return string.format("%02d:%02d:%02d", hours, minutes, seconds)
end

-- Status line with timer
vim.opt.statusline = table.concat({
    ' %f',                     -- File name
    '%m',                      -- Modified flag
    '%r',                      -- Readonly flag
    '%h',                      -- Help flag
    '%w',                      -- Preview flag
    ' [%{&ff}]',              -- File format
    ' [%Y]',                  -- File type
    ' [%4l,%3v]',             -- Line and column
    ' [%p%%]',                -- Percentage through file
    ' [%{luaeval("get_elapsed_time()")}]', -- Timer
    ' '
}, '')

local timer = vim.loop.new_timer()
timer:start(0, 1000, vim.schedule_wrap(function()
    vim.cmd('redrawstatus')
end))

vim.api.nvim_create_user_command('ResetTimer', function()
    vim.g.start_time = os.time()
end, {})

-- Template system
local template_dir = vim.fn.stdpath('config') .. '/templates'
local cp_template_path = vim.fn.stdpath('config') .. '/templates/cp_template.cpp'
local lc_template_path = vim.fn.stdpath('config') .. '/templates/leetcode_template.cpp'

-- Create template directory if it doesn't exist
if vim.fn.isdirectory(template_dir) == 0 then
    vim.fn.mkdir(template_dir, 'p')
end

-- Create CP template file if it doesn't exist
if vim.fn.filereadable(cp_template_path) == 0 then
    local cp_template = {
        '#include <bits/stdc++.h>',
        'using namespace std;',
        '',
        '// Debug macros - not for submission',
        '#ifdef LOCAL',
        '    #define debug(x) cerr << #x << " = "; _print(x); cerr << endl;',
        '    #define debugar(arr,i,n) cerr<<#arr<<" = [ "; for(int j=i;j<n;j++) cerr<<arr[j]<<" "; cerr<<"]"<<endl;',
        '    void _print(int x) {cerr << x;}',
        '    void _print(long long x) {cerr << x;}',
        '    void _print(double x) {cerr << x;}',
        '    void _print(char x) {cerr << \'\\\'\' << x << \'\\\'\';}',
        '    void _print(string x) {cerr << \'\"\' << x << \'\"\';}',
        '    void _print(bool x) {cerr << (x ? "true" : "false");}',
        '    template<class T> void _print(vector<T> v) {',
        '        cerr << "[ "; for(T i : v) {_print(i); cerr << " ";} cerr << "]";',
        '    }',
        '    template<class T> void _print(set<T> v) {',
        '        cerr << "{ "; for(T i : v) {_print(i); cerr << " ";} cerr << "}";',
        '    }',
        '    template<class T> void _print(multiset<T> v) {',
        '        cerr << "{ "; for(T i : v) {_print(i); cerr << " ";} cerr << "}";',
        '    }',
        '    template<class T, class V> void _print(pair<T, V> p) {',
        '        cerr << "{"; _print(p.first); cerr << ","; _print(p.second); cerr << "}";',
        '    }',
        '    template<class T, class V> void _print(map<T, V> v) {',
        '        cerr << "[ "; for(auto i : v) {_print(i); cerr << " ";} cerr << "]";',
        '    }',
        '    template<class T, class V> void _print(unordered_map<T, V> v) {',
        '        cerr << "[ "; for(auto i : v) {_print(i); cerr << " ";} cerr << "]";',
        '    }',
        '#else',
        '    #define debug(x)',
        '    #define debugar(arr,i,n)',
        '#endif',
        '',
        '// Fast I/O',
        'void fastIO() {',
        '    ios::sync_with_stdio(0);',
        '    cin.tie(0);',
        '    cout.tie(0);',
        '    #ifdef LOCAL',
        '        freopen("input.txt", "r", stdin);',
        '    #endif',
        '}',
        '',
        '// ---------------- Start of Solution (Copy from here) ----------------',
        '// Constants',
        'const int MOD = 1e9 + 7;',
        'const int INF = 2e9;',
        'const long long LINF = 1e18;',
        'const int MAXN = 2e5 + 5;',
        '',
        '// Useful defines - needed for submission',
        '#define all(x) (x).begin(), (x).end()',
        '#define rall(x) (x).rbegin(), (x).rend()',
        '#define rep(i,a,b) for(int i=(a);i<=(b);++i)',
        '#define per(i,a,b) for(int i=(a);i>=(b);--i)',
        '',
        'class Solution {',
        'public:',
        '    void solve() {',
        '        ',
        '        ',
        '        ',
        '    }',
        '};',
        '// ---------------- End of Solution (Copy to here) ----------------',
        '',
        '#ifdef LOCAL',
        'void runTests() {',
        '    ifstream in("input.txt");',
        '    string line;',
        '    vector<pair<string, string>> tests;',
        '    ',
        '    while (getline(in, line)) {',
        '        if (line.empty()) continue;',
        '        string input = line;',
        '        if (!getline(in, line)) break;',
        '        tests.push_back({input, line});',
        '    }',
        '    ',
        '    cout << "Running " << tests.size() << " tests...\\n\\n";',
        '    ',
        '    int passed = 0;',
        '    for (int t = 0; t < tests.size(); t++) {',
        '        cout << "Test #" << t + 1 << ":\\n";',
        '        ',
        '        stringstream test_input(tests[t].first);',
        '        stringstream actual_output;',
        '        auto cin_buff = cin.rdbuf(test_input.rdbuf());',
        '        auto cout_buff = cout.rdbuf(actual_output.rdbuf());',
        '        ',
        '        Solution().solve();',
        '        ',
        '        cin.rdbuf(cin_buff);',
        '        cout.rdbuf(cout_buff);',
        '        ',
        '        string output = actual_output.str();',
        '        ',
        '        while (!output.empty() && (output.back() == \'\\n\' || output.back() == \' \')) ',
        '            output.pop_back();',
        '        string expected = tests[t].second;',
        '        while (!expected.empty() && (expected.back() == \'\\n\' || expected.back() == \' \')) ',
        '            expected.pop_back();',
        '        ',
        '        cout << "Input: " << tests[t].first << \'\\n\';',
        '        cout << "Your output: " << output << \'\\n\';',
        '        cout << "Expected: " << expected << \'\\n\';',
        '        if (output == expected) {',
        '            cout << "Passed!\\n";',
        '            passed++;',
        '        } else {',
        '            cout << "Failed!\\n";',
        '        }',
        '        cout << "\\n";',
        '    }',
        '    ',
        '    cout << "Results: " << passed << "/" << tests.size() << " tests passed!\\n";',
        '}',
        '#endif',
        '',
        'int main() {',
        '    fastIO();',
        '    ',
        '    #ifdef LOCAL',
        '        runTests();',
        '    #else',
        '        int t = 1;',
        '        // cin >> t;',
        '        while(t--) {',
        '            Solution().solve();',
        '        }',
        '    #endif',
        '    ',
        '    return 0;',
        '}',
    }
    local file = io.open(cp_template_path, 'w')
    if file then
        file:write(table.concat(cp_template, '\n'))
        file:close()
    end
end

-- Create LeetCode template if it doesn't exist
if vim.fn.filereadable(lc_template_path) == 0 then
    local lc_template = {
        '#include <bits/stdc++.h>',
        'using namespace std;',
        '',
        '// Debug macros',
        '#define debug(x) cerr << #x << " = "; _print(x); cerr << endl;',
        'void _print(int x) {cerr << x;}',
        'void _print(long long x) {cerr << x;}',
        'void _print(double x) {cerr << x;}',
        'void _print(char x) {cerr << \'\\\'\' << x << \'\\\'\';}',
        'void _print(string x) {cerr << \'\"\' << x << \'\"\';}',
        'void _print(bool x) {cerr << (x ? "true" : "false");}',
        'template<class T> void _print(vector<T> v) {',
        '    cerr << "[ "; for(T i : v) {_print(i); cerr << " ";} cerr << "]";',
        '}',
        'template<class T> void _print(set<T> v) {',
        '    cerr << "{ "; for(T i : v) {_print(i); cerr << " ";} cerr << "}";',
        '}',
        'template<class T, class V> void _print(map<T, V> v) {',
        '    cerr << "[ "; for(auto i : v) {_print(i); cerr << " ";} cerr << "]";',
        '}',
        '',
        '// Add your solution class here',
        'class Solution {',
        'public:',
        '    ',
        '    ',
        '    ',
        '};',
        '',
        '// Add test cases',
        'void runTests() {',
        '    Solution sol;',
        '    ',
        '    //vector<int> nums1 = {1, 2, 3};',
        '    //assert(sol.example(nums1) == 6 && "Test case 1 failed");',
        '    ',
        '    cout << "All test cases passed!" << endl;',
        '}',
        '',
        'int main() {',
        '    runTests();',
        '    return 0;',
        '}',
    }
    local file = io.open(lc_template_path, 'w')
    if file then
        file:write(table.concat(lc_template, '\n'))
        file:close()
    end
end

-- Auto-load appropriate template based on filename
vim.api.nvim_create_autocmd('BufNewFile', {
    pattern = {'*.cpp'},
    callback = function(args)
        local filename = vim.fn.fnamemodify(args.file, ':t')
        if filename:match('cp.cpp') then
            vim.cmd('0r ' .. cp_template_path)
        elseif filename:match('lc.cpp') then
            vim.cmd('0r ' .. lc_template_path)
        end
    end
})
