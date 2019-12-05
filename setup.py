from distutils.core import setup
from distutils.extension import Extension
from Cython.Build import cythonize

try:
    from config import dirProjeto, Testing
    if dirProjeto and Testing:
        USE_CYTHON = True
    else:
        USE_CYTHON = False
except:
    USE_CYTHON = False

if USE_CYTHON:
    extensions = [
        Extension(
            name='cyrebro',

            sources= [
                '.\\*.pyx',
                dirProjeto + "src\\Util.cpp",            
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
    extensions = cythonize(extensions)
else:
    extensions = [
        Extension(
            "Cyrebro",
            ["cyrebro.cpp"]
        )
    ]

setup(
    name='cyrebro',
    ext_modules=extensions
)