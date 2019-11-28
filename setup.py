from distutils.core import setup
from distutils.extension import Extension
from Cython.Build import cythonize

dirProjeto = "D:\\Projetos\\C++\\Projetos\\Cyrebro\\"

extensions = [
    Extension(
        name='cyrebro',

        sources= [
            '.\\*.pyx',
            dirProjeto + "src\\Ativacoes.cpp",            
            dirProjeto + "src\\Neuronios.cpp",           
            dirProjeto + "src\\Camadas.cpp",           
            dirProjeto + "src\\Redes.cpp",
        ],
        include_dirs=[
            dirProjeto+"include",
        ]
    ),
]

setup(
    name='cyrebro',
    ext_modules=cythonize(extensions)
)