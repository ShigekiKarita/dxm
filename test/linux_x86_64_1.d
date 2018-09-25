@nogc:
extern (C):


import core.stdc.stdio;

void print_i(int i) {
    printf("%d\n", i);
}

void main() {
    print_i(1);
}
