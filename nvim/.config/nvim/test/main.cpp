#include <iostream>
#include <vector>

using namespace std;

#define xxx 324

void call(int x) { x = 10; }

void func(int) {}

namespace Na {

class T {};
} // namespace Na

class PQ {
public:
  int x = 10;
  void f();
  static int y;
  void f_c() const;
  const int c_x = 100;
  static int s_f();
};

enum EX { a, b, c };

int tmp(int x) {}
int f();

int x();

int main() {
  cout << "hello world" << endl;
  int x = 10;
  int       y = 20;
  const int q = 10;
  cout << "hello wold" << endl;


  const char *ss = "abc";
  tmp(10);
  return 0;
};
