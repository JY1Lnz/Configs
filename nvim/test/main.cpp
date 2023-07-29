#include <iostream>
#include <vector>

using namespace std;

void call() {}

void func(int) { call(); }

int main() {
  cout << "hello world" << endl;
  int x = 10;
  int y = 20;
  cout << "hello world" << endl;

  return 0;
}
