/// ExprAST - Base class for all expression nodes.
class ExprAST {
public:
    virtual ~ExprAST() {
    }
};

/// NumberExprAST - Expression class for numeric literals like "1.0".
class NumberExprAST : public ExprAST {
public:
    NumberExprAST(double val) {
    }
};

/// VariableExprAST - Expression class for referencing a variable, like "a".
class VariableExprAST : public ExprAST {
    std::string Name;
public:
    VariableExprAST(const std::string &name) : Name(name) {
    }
};

/// BinaryExprAST - Expression class for a binary operator.
class BinaryExprAST : public ExprAST {
public:
    BinaryExprAST(char op, ExprAST *lhs, ExprAST *rhs) {
    }
};

/// CallExprAST - Expression class for function calls.
class CallExprAST : public ExprAST {
    std::string Callee;
    std::vector<ExprAST *> Args;
public:
    CallExprAST(const std::string &callee, std::vector<ExprAST *> &args)
            : Callee(callee), Args(args) {
    }
};

/// PrototypeAST - This class represents the "prototype" for a function,
/// which captures its name, and its argument names (thus implicitly the number
/// of arguments the function takes).
class PrototypeAST {
    std::string Name;
    std::vector <std::string> Args;
public:
    PrototypeAST(const std::string &name, const std::vector <std::string> &args)
            : Name(name), Args(args) {
    }

};

/// FunctionAST - This class represents a function definition itself.
class FunctionAST {
public:
    FunctionAST(PrototypeAST *proto, ExprAST *body) {
    }
};
