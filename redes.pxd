from libcpp.vector cimport vector
from ativacoes cimport *
from neuronio cimport *
from camadas cimport *

cdef extern from "Redes.h" namespace "Redes":
    cdef cppclass Densa:
        int qtdNeuroniosEntrada;
        int qtdCamadas;
        int profundidadeEscondidas;
        int qtdNeuroniosSaida;

        MLP camadaEntrada;
        vector[MLP] camadasEscondidas;
        MLP camadaSaida;

        Densa();
        Densa(int qtdNeuEntrada, int qtdCamadas, int profundidade, int qtdNeuSaida);

        void aplicarEntrada(vector[int] valoresEntrada);
        void calculaSaida();
        vector[int] obterSaida();