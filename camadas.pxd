from libcpp.vector cimport vector
from neuronio cimport *
from ativacoes cimport *

cdef extern from "Camadas.h" namespace "Camadas":
    cdef cppclass MLP:
        int qtdPerceptrons;
        vector[Perceptron] perceptrons;

        MLP();
        MLP(int qtdPerceptrons);

        void conectarProxCamada(MLP* proxCamada);
        void calculaSaida(MLP* camadaAnterior);
        vector[int] obterSaida();
        void aplicarEntrada(vector[int] valoresEntrada);