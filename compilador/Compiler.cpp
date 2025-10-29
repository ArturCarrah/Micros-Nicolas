#include <iostream>
#include "model/Compiler.h"
#include <vector>
#include <sstream>
#include <string>
#include <bitset>
#include <fstream>
#include <algorithm>

using namespace std;

template<>
vector<Register> Compiler::extractDataFromFile<Register> (string filePath) {
    ifstream file(filePath);
    vector<Register> regArr;

    if (!file.is_open()) {
        cout << "Não foi possível abrir o arquivo fornecido." << "\n";
        return vector<Register>();
    }

    string line;
    while (getline(file, line)) {
        stringstream ss(line);
        string item;

        int n = 0;
        Register r;
        while (getline(ss, item, ',')) {
            if (n == 0) {
                r.id = stoi(item);
                r.opcode = bitset<8>(r.id);
            } else {
                r.name = item;
            }
            n++;
        }
        regArr.push_back(r);
    }
    return regArr;
}

template<>
vector<Instruction> Compiler::extractDataFromFile<Instruction> (string filePath) {
    ifstream file(filePath);
    vector<Instruction> instrucArr;

    if (!file.is_open()) {
        cout << "Não foi possível abrir o arquivo fornecido." << "\n";
        return vector<Instruction>();
    }

    string line;
    while (getline(file, line)) {
        stringstream ss(line);
        string item;

        int n = 0;
        Instruction r;
        while (getline(ss, item, ',')) {
            if (n == 0) {
                r.id = stoi(item);
                r.opcode = bitset<8>(r.id);
            } else if (n == 1) {
                r.mnemonic = item;
            } else {
                r.nregs = stoi(item);
            }   
            n++;
        }
        instrucArr.push_back(r);
    }
    return instrucArr;
}

vector<vector<string>> Compiler::extractWordSheet (string filePath) {
    ifstream file(filePath);
    vector<vector<string>> stringArr;

    if (!file.is_open()) {
        cout << "Não foi possível abrir o arquivo fornecido." << "\n";
        return vector<vector<string>>();
    }

    string line;
    while (getline(file, line)) {
        while (!line.empty() && (line.back() == '\r' || line.back() == ' '))
            line.pop_back();

        if (line.empty()) continue; 

        stringstream ss(line);
        string item;
        vector<string> subArr;

        while (ss >> item) {
            subArr.push_back(item);
        }

        if(!subArr.empty()) {
            stringArr.push_back(subArr);
        }
    }

    return stringArr;
}

bool Compiler::isHexadecimal(string &s) {
    bool k = false;
    int m = 0;
    int n = s.size();
    vector<char> hex_chars = {
        '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
        'A', 'B', 'C', 'D', 'E', 'F',
        'a', 'b', 'c', 'd', 'e', 'f'
    };

    for (int j = 0; j < s.size(); j++) {
        for (char ch : hex_chars) {
            if (s[j] == ch) {
                m++; 
                break;
            }
        }
    }

    if (m == n) k = true;
    return k;
}

bool Compiler::isDecimal(string &s) {
    bool k = false;
    int m = 0;
    int n = s.size();
    vector<char> dec_chars = {
        '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'
    };

    for (int j = 0; j < s.size(); j++) {
        for (char ch : dec_chars) {
            if (s[j] == ch) {
                m++; 
                break;
            }
        }
    }

    if (m == n) k = true;
    return k;
}

bool Compiler::isBinary(string &s) {
    bool k = false;
    int m = 0;
    int n = s.size();
    vector<char> bin_chars = {
        '0', '1'
    };

    for (int j = 0; j < s.size(); j++) {
        for (char ch : bin_chars) {
            if (s[j] == ch) {
                m++; 
                break;
            }
        }
    }

    if (m == n) k = true;
    return k;
}

bool Compiler::recognizeInstruction(vector<string> &vs) {
    bool b = false;

    string instruction = vs[0];
    transform(instruction.begin(), instruction.end(), instruction.begin(), ::toupper);

    for (const auto& i : instructionset) {
        if (instruction == i.mnemonic) {
            b = true;
            vs[0] = to_string(i.id);
        }
    }

    return b;
}

bool Compiler::countParameters(vector<string> &vs) {
     int n = vs.size() - 1;
     bool b = false;

    if (n == instructionset[stoi(vs[0])].nregs) {
         b = true;
    }

    return b;
}

void Compiler::commentsFilter(vector<string> &vs) {
    int j = -1;

    for (int i = 0; i < vs.size(); i++) {
        if (vs[i] == ";") {
            j = i;
            break;
        }
    }

    if (j != -1) {
        vs.erase(vs.begin() + j, vs.end());
    }
}

void Compiler::trin(vector<string> &s) {
    for (int i = 0; i < s.size();) {
        if (s[i] == "") {
            s.erase(s.begin() + i);
        } else {
            i++;
        }
    }
}

void Compiler::removeComma(vector<string> &vs) {
    for (int i = 1; i < vs.size(); i++) {
        if (vs[i][0] == ',') vs[i].erase(0,1); 
        if (vs[i][vs[i].size()-1] == ',') vs[i].erase(vs[i].size()-1 ,1); 
    }
}

vector<int> Compiler::recognizeRegister(string &s) {
    int k = 0;
    int id = 0;
    transform(s.begin(), s.end(), s.begin(), ::toupper);
    for (const auto& i : regfile) {
        if (s == i.name) {
            k = 1;
            id = i.id;
        }
    }
    return {k, id};
}

vector<int> Compiler::recognizeImmediate(string &s) {
    int k = 0;
    int opc = 0;

    if (s[0] == '#') {
        if (s[1] == '0' and s[2] == 'X') {
            string sub = s.substr(3);
            if (isHexadecimal(sub)) {
                k = 1;
                unsigned long valor = stol(sub, nullptr, 16);
                opc = valor;
            }
        }

        else if (s[1] == '0' and s[2] == 'B') {
            string sub = s.substr(3);
            if (isBinary(sub)) {
                k = 1;
                unsigned long valor = stol(sub, nullptr, 2);
                opc = valor;
            }
        }

        else {
            string sub = s.substr(1);
            if (isDecimal(sub)) {
                k = 1;
                unsigned long valor = stol(sub, nullptr, 10);
                opc = valor;
            }
        }
    }

    return {k, opc};
}

string Compiler::getOpcodes(int id, int type) {
    if (!(type == 0 or type == 1)) {
        cout << "Erro, type precisa ser 0 para instrução ou 1 para registrador";
        return "";
    }

    string op;
    if (type == 0) {
        for (const auto& i : instructionset) {
            if (id == i.id) {
                op = i.opcode.to_string();
                break;
            }
        }
    }
    else {
        for (const auto& r : regfile) {
            if (id == r.id) {
                op = r.opcode.to_string();
                break;
            }
        }
    }

    return op;
}

void Compiler::getOutput(string filePath) {
    ofstream output(filePath, std::ios::out);

    if (!output) {
        cout << "Erro ao criar o arquivo";
        return;
    }

    for (const auto& line : wordsheet) {
        for (const auto& word : line) {
            output << word;
        }
        output << std::endl;
    }


    output << endl;
    output.close();
}

void Compiler::init(string filePath) {
    this->wordsheet = this->extractWordSheet(filePath);

    for (int line = 0; line < wordsheet.size(); line++) {
        vector<string> &currentLine = wordsheet[line]; 

        if (currentLine.empty()) continue;

        if (!this->recognizeInstruction(currentLine)) {
            cout << "Erro, instrução não existe no set de instruções na linha " << line+1 << endl;
            continue; 
        }

        this->commentsFilter(currentLine);
        this->trin(currentLine);
        this->removeComma(currentLine);

        if (!this->countParameters(currentLine)) {
            cout << "Erro, foram passados mais paramêtros do que o necessário na linha " << line+1 << endl;
            continue;
        }

        for (int i = 1; i < currentLine.size(); i++) {
            vector<int> i_info = {0, 0};
            vector<int> r_info = recognizeRegister(currentLine[i]);

            if (r_info[0] == 0) {
                if (i == currentLine.size() - 1) {
                    i_info = recognizeImmediate(currentLine[i]);
                } else {
                    cout << "Erro, você precisa passar um registrador válido! Linha " << line+1 << ", posição " << i << endl;
                }
            } else {
                currentLine[i] = this->getOpcodes(r_info[1], 1);
            }

            if (i_info[0] == 1) {
                currentLine[i] = bitset<8>(i_info[1]).to_string();
            }
        }

        currentLine[0] = this->getOpcodes(stoi(currentLine[0]), 0);
    }

    this->getOutput("io/output.txt");
    // cout << "[";
    // for (size_t i = 0; i < wordsheet.size(); ++i) {
    //     cout << "[";
    //     for (size_t j = 0; j < wordsheet[i].size(); ++j) {
    //         cout << "\"" << wordsheet[i][j] << "\"";
    //         if (j != wordsheet[i].size() - 1) {
    //             cout << ", ";
    //         }
    //     }
    //     cout << "]";
    //     if (i != wordsheet.size() - 1) {
    //         cout << ", ";
    //     }
    // }
    // cout << "]" << endl;
}

Compiler::Compiler() {
    this->regfile = this->extractDataFromFile<Register>("data/regfile.txt");
    this->instructionset = this->extractDataFromFile<Instruction>("data/instructionset.txt");
}