Instalar primeiro o TCL (disponível noutro arquivo)

Em seguida descomprimir o arquivo  P3_win13-20060320.zip
para uma pasta qualquer. Sugiro que usem uma pasta
de fácil acesso a partir do que será a vossa pasta de
trabalho. Exemplo: Se vão trabalhar na pasta C:\AC\Lab
então criem a pasta C:\AC\Lab\P3 e descomprimir o
arquivo para lá.



Assembler: P3AS.EXE

Programa que processa os ficheiros .AS e gera os
executáveis .EXE que serão testados no simulador.

Este programa é totalmente autónomo e pode ser copiado
para onde se queira e corrido de onde se queira.

Para correr o programa lançar uma janela de linha de
comandos do windows (cmd prompt) e evocar

  p3as <file.as>	(ex.: p3as aula1_1.as)

que gera um ficheiro de extensão .lis e outro de
extensão .exe
É este último que deverá depois ser carregado no
simulador para correr e testar o programa.



Simulador: P3SIM.BAT

Programa que permite correr e testar os programas
desenvolvidos para o P3. Necessita que previamente
tenha sido instalado o software TCL.

Método garantido de correr com sucesso o simulador:
Ir para a pasta onde foram colocados os ficheiros
e efectuar duplo clique em p3sim.bat

Nota: se ocorrer erro indicando não encontrar tcl83.dll
é porque o path não inclui C:\TCL\bin (acrescentar
esta directoria ao path)

Para carregar o programa a testar, escolher o menu
Ficheiro e escolher a opção "Carrega Programa".




Prof. Renato Nunes, 9 Mar.2009
.