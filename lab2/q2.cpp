#include <array>
#include <iostream>

// Converts integer or decimal from fahrenheit to celsius.
template <class T>
double fahrenheit_to_celsius(T f) {
  return ((f - 32) * 5) / 9.0;
}

int main() {
  // Static temperature datapoints.
  std::array<int, 7> weekly_temp = {77, 80, 69, 77, 80, 75, 69};
  for (int& f : weekly_temp) {
    std::cout << f << " fahrenheit is " << fahrenheit_to_celsius(f)
              << " celsius.\n";
  }
}