#include <iostream>
#include <string>
#include <vector>

enum Token {
    tok_eof = -1,
    tok_number = -2,
    tok_op = -3,
};

static char Op;
static int NumVal;              // Filled in if tok_number
static std::vector<int> Args;

/// gettok - Return the next token from standard input.
static int gettok() {
    static int LastChar = ' ';

    // Skip any whitespace.
    while (isspace(LastChar)) {
        LastChar = getchar();
    }

    if (isdigit(LastChar)) {   // Number: [0-9]+
        std::string NumStr;
        do {
            NumStr += LastChar;
            LastChar = getchar();
        } while (isdigit(LastChar));

        NumVal = strtod(NumStr.c_str(), 0);
        Args.push_back(NumVal);

        return tok_number;
    }

    if (LastChar == '+' || LastChar == '-' || LastChar == '*' || LastChar == '/') {
        Op = LastChar;
        Args.push_back(Op);
        return tok_op;
    }

    // Check for end of file.  Don't eat the EOF.
    if (LastChar == EOF || LastChar == '\r' || LastChar == '\n')
        return tok_eof;

    // Otherwise, just return the character as its ascii value.
    int ThisChar = LastChar;
    return ThisChar;
}

static int CurTok;

static int getNextToken() {
    return CurTok = gettok();
}

static void Print(std::vector<int> &v) {
    //vector<int> v;
    for (int i = 0; i < v.size(); i++) {
        std::cout << v[i] << std::endl;
    }
}

int main() {
    while (1) {
        getNextToken();
        if (CurTok == tok_op) {
            printf("<tok_op> %c\n", Op);
        } else if (CurTok == tok_number) {
            printf("<tok_number> %d\n", NumVal);
        } else if (CurTok == tok_eof) {
            printf("<tok_eof>\n");
            break;
        } else {
            printf("<Unknown> %d\n", CurTok);
        }
    }
}
