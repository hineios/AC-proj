Instalar primeiro o TCL (dispon�vel noutro arquivo)

Em seguida descomprimir o arquivo  P3_win13-20060320.zip
para uma pasta qualquer. Sugiro que usem uma pasta
de f�cil acesso a partir do que ser� a vossa pasta de
trabalho. Exemplo: Se v�o trabalhar na pasta C:\AC\Lab
ent�o criem a pasta C:\AC\Lab\P3 e descomprimir o
arquivo para l�.



Assembler: P3AS.EXE

Programa que processa os ficheiros .AS e gera os
execut�veis .EXE que ser�o testados no simulador.

Este programa � totalmente aut�nomo e pode ser copiado
para onde se queira e corrido de onde se queira.

Para correr o programa lan�ar uma janela de linha de
comandos do windows (cmd prompt) e evocar

  p3as <file.as>	(ex.: p3as aula1_1.as)

que gera um ficheiro de extens�o .lis e outro de
extens�o .exe
� este �ltimo que dever� depois ser carregado no
simulador para correr e testar o programa.



Simulador: P3SIM.BAT

Programa que permite correr e testar os programas
desenvolvidos para o P3. Necessita que previamente
tenha sido instalado o software TCL.

M�todo garantido de correr com sucesso o simulador:
Ir para a pasta onde foram colocados os ficheiros
e efectuar duplo clique em p3sim.bat

Nota: se ocorrer erro indicando n�o encontrar tcl83.dll
� porque o path n�o inclui C:\TCL\bin (acrescentar
esta directoria ao path)

Para carregar o programa a testar, escolher o menu
Ficheiro e escolher a op��o "Carrega Programa".




Prof. Renato Nunes, 9 Mar.2009
.