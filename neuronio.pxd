from libcpp.vector cimport vector

cdef extern from "Neuronios.h" namespace "Neuronios":
    cdef cppclass Perceptron:
        int qtdLigacoes;
        vector[int] pesos;
        int saida;

        Perceptron();
        Perceptron(int qtdLigacoes);

        void randomPesos();
