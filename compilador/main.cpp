#include "model/Compiler.h"

int main() {

    Compiler* compiler = new Compiler();
    compiler->init("io/inputfile.txt");
    
    return 1;
}