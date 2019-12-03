from libcpp.vector cimport vector

cdef extern from "Neuronios.h" namespace "Neuronios":
    cdef cppclass Perceptron:
        int qtdLigacoes, saida;
        vector[int] pesos;
        Perceptron();
        Perceptron(int qtdLigacoes);
        void randomPesos();