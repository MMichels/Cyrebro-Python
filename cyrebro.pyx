# distutils: language = c++
from libcpp.vector cimport vector
from typing import List
from ativacoes cimport *
from neuronio cimport *
from camadas cimport *
from redes cimport *

# Neuronios
cdef class PyPerceptron:
    cdef Perceptron* c_neuro

    def __cinit__(self, int qtdLigacoes):
        self.c_neuro = new Perceptron(qtdLigacoes)
        

    def __dealloc(self):
        del self.c_neuro


    @property
    def qtdLigacoes(self):
        return self.c_neuro.qtdLigacoes
    @qtdLigacoes.setter
    def qtdLigacoes(self, int value):
        self.c_neuro.qtdLigacoes = value

    @property
    def saida(self):
        return self.c_neuro.saida
    @saida.setter
    def saida(self, int value):
        self.c_neuro.saida = value
    

    @property
    def pesos(self):
        return self.c_neuro.pesos
    @pesos.setter
    def pesos(self, vector[int] pesos):
        assert pesos.size() == self.c_neuro.qtdLigacoes, "O tamanho do vetor de pesos deve ser igual a \
        quantidade de ligacoes do neuronio, o neuronio possui " + str(self.qtdLigacoes) + " ligacoes"
        self.c_neuro.pesos = pesos


# Camadas
cdef class PyCamada:
    cdef MLP c_camada

    def __cinit__(self, int qtdNeuronios):
        self.c_camada = MLP(qtdNeuronios)

    
    def conectarProxCamada(self, PyCamada proxCamada):
        self.c_camada.conectarProxCamada(&proxCamada.c_camada)

    def calculaSaida(self, PyCamada camadaAnterior):
        self.c_camada.calculaSaida(&camadaAnterior.c_camada)
        #return self.saida

    def aplicarEntrada(self, vector[int] valores):
        assert len(valores) == self.qtdNeuronios, "A quantidade de valores e a quantidade de neuronios devem ser iguais, \
        existem " + str(self.qtdNeuronios) + " neuronios nesta camada"
        
        self.c_camada.aplicarEntrada(valores)


    @property
    def saida(self):
        saida = []
        for n in self.c_camada.perceptrons:
            saida.append(n.saida)
        return saida

    @property
    def qtdNeuronios(self):
        return self.c_camada.qtdPerceptrons
    @qtdNeuronios.setter
    def qtdNeuronios(self, value):
        self.c_camada.qtdPerceptrons = value

    @property
    def neuronios(self):
        pNeuronios = []
        for i in range(self.c_camada.perceptrons.size()):
            pNeuronio = PyPerceptron(self.c_camada.perceptrons[i].qtdLigacoes)
            pNeuronio.c_neuro = &self.c_camada.perceptrons[i]
            pNeuronios.append(pNeuronio)
        return pNeuronios

    
    @neuronios.setter
    def neuronios(self, pNeuronios):
        assert len(pNeuronios) == self.qtdNeuronios, "Esta camada tem " + str(self.qtdNeuronios) + " neuronios"
        pesos = [pN.pesos for pN in pNeuronios]
        saidas = [pN.saida for pN in pNeuronios]
        qtdLigacoes = [pN.qtdLigacoes for pN in pNeuronios]
            
        for i in range(len(pNeuronios)):
            self.c_camada.perceptrons[i].qtdLigacoes = qtdLigacoes[i]
            self.c_camada.perceptrons[i].pesos = pesos[i]
            self.c_camada.perceptrons[i].saida = saidas[i]

# REDES
cdef class PyDensa:
    cdef Densa c_densa

    def __cinit__(self, int qtdNeuroniosEntrada, int qtdCamadas, int profundidadeCamadas, int qtdNeuroniosSaida):
        self.c_densa = Densa(qtdNeuroniosEntrada, qtdCamadas, profundidadeCamadas, qtdNeuroniosSaida)

    def aplicarEntrada(self, vector[int] valores):
        assert valores.size() == self.qtdNeuroniosEntrada, "Quantidade de valores de entrada e quantidade de neuronios não conferem"
        self.c_densa.aplicarEntrada(valores)

    def calculaSaida(self):
        self.c_densa.calculaSaida()

    def obterSaida(self):
        saida = self.c_densa.obterSaida()
        return saida
    
    @property
    def qtdNeuroniosEntrada(self):
        return self.c_densa.qtdNeuroniosEntrada

    @property
    def qtdNeuroniosSaida(self):
        return self.c_densa.qtdNeuroniosSaida

    @property
    def qtdCamadas(self):
        return self.c_densa.qtdCamadas

    @property
    def profundidadeEscondidas(self):
        return self.c_densa.profundidadeEscondidas