#ifndef DEBUG_H
#define DEBUG_H

#include <iostream>
#include <string>
#include <vector>
#include <array>
#include <deque>
#include <set>
#include <map>
#include <unordered_map>
#include <unordered_set>
#include <bitset>
#include <queue>
#include <stack>
#include <list>
#include <forward_list>
#include <tuple>
#include <complex>
#include <utility>
#include <ranges>

// Debug output stream
#define dbg_out std::cerr

// Concepts for type detection
template<typename T>
concept Container = requires(T t) {
    std::begin(t);
    std::end(t);
    t.size();
};

template<typename T>
concept Pair = requires(T t) {
    t.first;
    t.second;
};

template<typename T>
concept Tuple = requires(T t) {
    std::tuple_size<T>::value;
};

// Helper to check if type is a specialization of a template
template<typename T, template<typename...> class Template>
struct is_specialization : std::false_type {};

template<template<typename...> class Template, typename... Args>
struct is_specialization<Template<Args...>, Template> : std::true_type {};

// Base debug print for fundamental types
template<typename T>
requires std::is_fundamental_v<T>
void debug_print(const T& value) {
    dbg_out << value;
}

// Debug print for C-strings
void debug_print(const char* value) {
    dbg_out << (value ? ('\"' + std::string(value) + '\"') : "null");
}

// Debug print for std::string
void debug_print(const std::string& value) {
    dbg_out << '"' << value << '"';
}

// Debug print for std::bitset
template<size_t N>
void debug_print(const std::bitset<N>& value) {
    dbg_out << value.to_string();
}

// Debug print for complex numbers
template<typename T>
void debug_print(const std::complex<T>& value) {
    dbg_out << value.real() << "+" << value.imag() << "i";
}

// Debug print for pairs
template<Pair T>
void debug_print(const T& p) {
    dbg_out << "(";
    debug_print(p.first);
    dbg_out << ", ";
    debug_print(p.second);
    dbg_out << ")";
}

// Debug print for tuples
template<typename... Args>
void debug_print(const std::tuple<Args...>& t) {
    dbg_out << "(";
    std::apply([](const auto&... args) {
        size_t idx = 0;
        ((dbg_out << (idx++ ? ", " : ""), debug_print(args)), ...);
    }, t);
    dbg_out << ")";
}

// Debug print for containers
template<Container T>
void debug_print(const T& container) {
    // Special case for priority queue
    if constexpr (is_specialization<T, std::priority_queue>::value) {
        auto temp = container;
        dbg_out << "{";
        bool first = true;
        while (!temp.empty()) {
            if (!first) dbg_out << ", ";
            debug_print(temp.top());
            temp.pop();
            first = false;
        }
        dbg_out << "}";
        return;
    }

    // Special case for stack
    if constexpr (is_specialization<T, std::stack>::value) {
        auto temp = container;
        std::vector<typename T::value_type> values;
        while (!temp.empty()) {
            values.push_back(temp.top());
            temp.pop();
        }
        std::reverse(values.begin(), values.end());
        debug_print(values);
        return;
    }

    // General container case
    dbg_out << "{";
    bool first = true;
    for (const auto& item : container) {
        if (!first) dbg_out << ", ";
        debug_print(item);
        first = false;
    }
    dbg_out << "}";
}

// Base case for debug print with name
void debug_print_with_name(const char* name) {
    dbg_out << name << " = (empty)" << std::endl;
}

// Single variable case
template<typename T>
void debug_print_with_name(const char* name, const T& value) {
    dbg_out << name << " = ";
    debug_print(value);
    dbg_out << std::endl;
}

// Multiple variables case
template<typename T, typename... Rest>
void debug_print_with_name(const char* names, const T& value, const Rest&... rest) {
    const char* comma = strchr(names, ',');
    std::string name(names, comma ? comma - names : strlen(names));

    // Trim whitespace
    name.erase(0, name.find_first_not_of(" "));
    name.erase(name.find_last_not_of(" ") + 1);

    dbg_out << name << " = ";
    debug_print(value);

    if (comma) {
        dbg_out << ",  ";
        debug_print_with_name(comma + 1, rest...);
    } else {
        dbg_out << std::endl;
    }
}

// Main debug macro
#define dbg(...) do { \
dbg_out << "[" << __FILE__ << ":" << __LINE__ << "] "; \
debug_print_with_name(#__VA_ARGS__, ##__VA_ARGS__); \
} while(0)

#endif // DEBUG_H
