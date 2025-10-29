#include <string>
#include <vector>
#include <bitset>

using namespace std;

struct Register {
    int id;
    string name;
    bitset<8> opcode;
};

struct Instruction {
    int id;
    string mnemonic;
    bitset<8> opcode;
    int nregs;
};

class Compiler {
    private:
        vector<Register> regfile;
        vector<Instruction> instructionset;
        vector<vector<string>> wordsheet;

        template <typename T>
        vector<T> extractDataFromFile (string filePath);

        vector<vector<string>> extractWordSheet (string filePath);

        bool isHexadecimal(string &s);
        bool isDecimal(string &s);
        bool isBinary(string &s);

        bool recognizeInstruction(vector<string> &vs);
        void trin(vector<string> &s); // remover espaços extras
        void commentsFilter(vector<string> &vs); //verifica se existe comentários e os remove se sim;
        void removeComma(vector<string> &vs); // remove virgula dos parametros "R0," -> "R0"
        bool countParameters(vector<string> &vs); // verifica se a quantidade de parametros passados corresponde com a quantidade esperada.
        vector<int> recognizeRegister(string &s); 
        vector<int> recognizeImmediate(string &s);
        string getOpcodes(int id, int type); // passa gerando os opcodes válidos 0-instrucao e 1-registrador;
        void getOutput(string filePath);

    public:
        Compiler();
        void init(string filePath); // executa pipeline inteira.
};