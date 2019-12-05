from libcpp.vector cimport vector
from ativacoes cimport *
from neuronio cimport *
from camadas cimport *

cdef extern from "Redes.h" namespace "Redes":
    cdef cppclass Densa:
        int qtdNeuroniosEntrada, qtdCamadas, profundidadeEscondidas, qtdNeuroniosSaida;
        int tamanhoDNA, qtdGenesCamadaSaida, qtdGenesCamadasEscondidas;
        float qtdMutacoes;

        MLP camadaEntrada;
        vector[MLP] camadasEscondidas;
        MLP camadaSaida;

        Densa();
        Densa(int qtdNeuEntrada, int qtdCamadas, int profundidade, int qtdNeuSaida);

        void aplicarEntrada(vector[int] valoresEntrada);
        void calculaSaida();
        vector[int] obterSaida();

        int mudarValor(int valor);
        vector[int] copiarDNA();
        void colarDNA(vector[int] dna);
        vector[int] alterarDNA(vector[int] dna);
        void sofrerMutacao();

        void copiarRede(Densa *inspiracao);