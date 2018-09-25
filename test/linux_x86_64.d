@nogc:
extern (C):


import core.stdc.stdio;

int sum(int a1, int a2, int a3, int a4, int a5,
        int a6, int a7, int a8, int a9)
{
  int s = -9999;

  s = a1 + a2 + a3 + a4 + a5 + a6 + a7 + a8 + a9;

  return s;
}

void func()
{
  int ret = -1;

  ret = sum(11, 22, 33, 44, 55, 66, 77, 88, 99);

  printf("sum: %d\n", ret);
}


int main() {
    func();
    return 0;
}
