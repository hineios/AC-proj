;*****************************************
;*****************************************
;**      Projecto "Line Breaker"	**
;**					**
;**     Grupo 72   Turno: 3ª 14h	**
;**					**
;**    Alunos:		  Números:	**
;** Ricardo Leitão	   69632	**
;** Diogo Andrade	   70031	**
;*  Fábio Almeida	   70227	**
;*****************************************
;*****************************************


;***************************
;* Definição de Constantes *
;***************************
IO_READ		EQU	FFFFh
IO_WRITE	EQU	FFFEh
IO_STATUS	EQU	FFFDh
IO_CONTROL	EQU	FFFCh
CTRL_TEMP	EQU	FFF7h
CONT_TEMP	EQU	FFF6h
LEDS		EQU	FFF8h
INTERRUPTORES	EQU	FFF9h
SP_INICIAL	EQU	FDFFh
INT_MASK_ADDR	EQU	FFFAh
INT_MASK	EQU	1000000000000011b
RND_MASK	EQU	1000000000010110b

ESPACO		EQU	20h
FIM_TEXTO	EQU	'$'
DIVISOR		EQU	4000h
INC_LINHA	EQU	0100h
INC_COLUNA	EQU	0001h
VAIVEM_CURSOR	EQU	0105h
VAIVEM_CONTADOR	EQU	17
VAIVEM_ESTADO	EQU	1
VALOR_DIFI	EQU	5
TEMPORIZADOR	EQU	10
TESTE_9		EQU	9
TESTE_10	EQU	10


POS_NOME	EQU	050Fh
POS_PONT	EQU	080Fh
POS_PRIMA	EQU	0F0Fh
POS_TAB		EQU	0101h
POS_OVER	EQU	0D15h
POS_PONTUACAO	EQU	091Ah

TAMANHO_LINHA	EQU	10
TAMANHO_TAB	EQU	200

JOGO_DIM	EQU	180

SEG_1		EQU	FFF0h			
SEG_2		EQU	FFF1h			
SEG_3		EQU	FFF2h			
SEG_4		EQU	FFF3h


;**********************************************************
;**********************************************************
;***   Definição da Tabela de Vectores de Interrupção	***
;**********************************************************
;**********************************************************
		ORIG	FE00h
INT0		WORD	Interrup0
INT1		WORD	Interrup1
		
		ORIG	FE0Fh
INT15		WORD	Temporizador


;**********************************************************
;**********************************************************
;***   		Definição de Variáveis			***
;**********************************************************
;**********************************************************

		ORIG 	8000h
JOGO		TAB	JOGO_DIM

PECAS		STR 	'#O:-'

VALOR_TEMP	WORD	10		;Valor de contagem do relógio do P3


;Strings com mensagens para escrita no ecran, relativas a mensagens
;de jogo e limites de tabuleiro de Jogo
StrBranco	STR	'                     ', FIM_TEXTO
StrLimite	STR	'|         |', FIM_TEXTO		
StrFundo	STR	'+---------+', FIM_TEXTO		
StrNomeJogo	STR	'Jogo Line Breaker', FIM_TEXTO		
StrPont		STR	'Pontuacao maxima:', FIM_TEXTO		
StrPrimaTecla1	STR	'Premir uma tecla para', FIM_TEXTO
StrPrimaTecla2	STR	'jogar.', FIM_TEXTO
StrGameOver	STR	'GAME OVER', FIM_TEXTO
StrNovaTecla1	STR	'Premir uma tecla para', FIM_TEXTO
StrNovaTecla2	STR	'iniciar um jogo novo.', FIM_TEXTO

INI_0_JOGO	STR	'         ', FIM_TEXTO		;Tabuleiros disponíveis 
INI_0_L02	STR	'         ', FIM_TEXTO		;para iniciar o jogo.
INI_0_L03	STR	'         ', FIM_TEXTO
INI_0_L04	STR	'         ', FIM_TEXTO
INI_0_L05	STR	'         ', FIM_TEXTO
INI_0_L06	STR	'         ', FIM_TEXTO
INI_0_L07	STR	'         ', FIM_TEXTO
INI_0_L08	STR	'         ', FIM_TEXTO
INI_0_L09	STR	'         ', FIM_TEXTO
INI_0_L10	STR	'         ', FIM_TEXTO
INI_0_L11	STR	'         ', FIM_TEXTO
INI_0_L12	STR	'         ', FIM_TEXTO
INI_0_L13	STR	'         ', FIM_TEXTO
INI_0_L14	STR	'         ', FIM_TEXTO
INI_0_L15	STR	'         ', FIM_TEXTO
INI_0_L16	STR	'         ', FIM_TEXTO
INI_0_L17	STR	'         ', FIM_TEXTO
INI_0_L18	STR	'         ', FIM_TEXTO
INI_0_L19	STR	'         ', FIM_TEXTO
INI_0_L20	STR	'         ', FIM_TEXTO

INI_1_JOGO	STR	'         ', FIM_TEXTO
INI_1_L02	STR	'         ', FIM_TEXTO
INI_1_L03	STR	'         ', FIM_TEXTO
INI_1_L04	STR	'         ', FIM_TEXTO
INI_1_L05	STR	'         ', FIM_TEXTO
INI_1_L06	STR	'         ', FIM_TEXTO
INI_1_L07	STR	'         ', FIM_TEXTO
INI_1_L08	STR	'         ', FIM_TEXTO
INI_1_L09	STR	'         ', FIM_TEXTO
INI_1_L10	STR	'   O :   ', FIM_TEXTO
INI_1_L11	STR	'   - -   ', FIM_TEXTO
INI_1_L12	STR	'   # :   ', FIM_TEXTO
INI_1_L13	STR	'   # O   ', FIM_TEXTO
INI_1_L14	STR	'   : -   ', FIM_TEXTO
INI_1_L15	STR	'   - :   ', FIM_TEXTO
INI_1_L16	STR	'   # O   ', FIM_TEXTO
INI_1_L17	STR	'   O #   ', FIM_TEXTO
INI_1_L18	STR	'  O# -## ', FIM_TEXTO
INI_1_L19	STR	' ##- :--#', FIM_TEXTO
INI_1_L20	STR	'#--O O::-', FIM_TEXTO

INI_2_JOGO	STR	'         ', FIM_TEXTO
INI_2_L02	STR	'         ', FIM_TEXTO
INI_2_L03	STR	'    O    ', FIM_TEXTO
INI_2_L04	STR	'    O    ', FIM_TEXTO
INI_2_L05	STR	'    -    ', FIM_TEXTO
INI_2_L06	STR	'    :    ', FIM_TEXTO
INI_2_L07	STR	'    #    ', FIM_TEXTO
INI_2_L08	STR	'    :    ', FIM_TEXTO
INI_2_L09	STR	'    #    ', FIM_TEXTO
INI_2_L10	STR	'    O    ', FIM_TEXTO
INI_2_L11	STR	'    O    ', FIM_TEXTO
INI_2_L12	STR	'    :    ', FIM_TEXTO
INI_2_L13	STR	'    :    ', FIM_TEXTO
INI_2_L14	STR	'    -    ', FIM_TEXTO
INI_2_L15	STR	'    -    ', FIM_TEXTO
INI_2_L16	STR	'    #    ', FIM_TEXTO
INI_2_L17	STR	'    #    ', FIM_TEXTO
INI_2_L18	STR	'    :    ', FIM_TEXTO
INI_2_L19	STR	'    #    ', FIM_TEXTO
INI_2_L20	STR	'    O    ', FIM_TEXTO

INI_3_JOGO	STR	'         ', FIM_TEXTO
INI_3_L02	STR	'         ', FIM_TEXTO
IN3_3_L03	STR	'         ', FIM_TEXTO
INI_3_L04	STR	'         ', FIM_TEXTO
INI_3_L05	STR	'         ', FIM_TEXTO
INI_3_L06	STR	'         ', FIM_TEXTO
INI_3_L07	STR	'         ', FIM_TEXTO
INI_3_L08	STR	'         ', FIM_TEXTO
INI_3_L09	STR	'         ', FIM_TEXTO
INI_3_L10	STR	'         ', FIM_TEXTO
INI_3_L11	STR	'         ', FIM_TEXTO
INI_3_L12	STR	'         ', FIM_TEXTO
INI_3_L13	STR	'         ', FIM_TEXTO
INI_3_L14	STR	'         ', FIM_TEXTO
INI_3_L15	STR	'    :    ', FIM_TEXTO
INI_3_L16	STR	'    #    ', FIM_TEXTO
INI_3_L17	STR	' :  O    ', FIM_TEXTO
INI_3_L18	STR	' :  -  # ', FIM_TEXTO
INI_3_L19	STR	' #  : O: ', FIM_TEXTO
INI_3_L20	STR	' OO # -O ', FIM_TEXTO

VaiVemEstado	WORD	1		;Variáveis usadas pela rotina VaiVem
VaiVemCursor	WORD	0005h
VaiVemPeca	WORD	0
VaiVemContador	WORD	17


Unidades	WORD	0		;Variáveis utilizadas na escrita
Dezenas		WORD	0		;da pontuação no displayt de 7 
Centenas	WORD	0		;segmentos
Milhares	WORD	0

Pontuacao	WORD	0		;Variáveis diversas (Pontuação,
Pont_Max	WORD	0		; dificuldade e tabuleiro
Difi		WORD	0
Tabuleiro	WORD	0					

VarRandom	TAB	1		;Variáveis utilizadas na geração de 
Random		TAB	1		;numeros aleatórios

GameOverCont	WORD	0		;Variáveis de Controlo de diferentes
Int0		WORD	0		;rotinas
Int1		WORD	0
Int15		WORD	0

Leds		WORD	1		;Variável com o valor da dificuldade
					;a colocar nos LEDS



;******************************************************************************

		ORIG	0000h
		JMP	Inicio

;********************************************************
;* Rotina de atendimento à interrupção 0		*
;********************************************************
Interrup0:		PUSH	R7
		MOV	R7, M[VALOR_TEMP]
		MOV	M[CONT_TEMP], R7
		MOV	R7, 1
		MOV	M[Int0], R7
		POP	R7
		RTI

;********************************************************
;* Rotina de atendimento à interrupção 1		*
;********************************************************
Interrup1:		PUSH	R7
		MOV	R7, M[VALOR_TEMP]
		MOV	M[CONT_TEMP], R7
		MOV	R7, 1
		MOV	M[Int1], R7
		POP	R7
		RTI

;********************************************************
;* Rotina de atendimento à interrupção 15		*
;********************************************************
Temporizador:	PUSH	R7
		MOV	R7, M[VALOR_TEMP]
		MOV	M[CONT_TEMP], R7
		MOV	R7, 1
		MOV	M[CTRL_TEMP], R7
		MOV	M[Int15], R7
		POP	R7
		RTI

;****************************************************************
;* Rotina que actualiza o valor de M[Random] com um valor 	*
;* aleatorio entre 0 e 3 tendo como base o número fornecido pela*
;* rotina NumAleat. Sucintamente, esta rotina converte um número*
;* do intervalo [0h;FFFFh] para o intervalo[0;3]		*
;****************************************************************
Aleatorio:	PUSH	R1
		PUSH	R2
		CALL	NumAleat
		MOV	R1, M[VarRandom]
		MOV	R2, DIVISOR
		DIV	R1, R2
		MOV	M[Random], R1
		POP	R2
		POP	R1
		RET

;*******************************************************
;* Rotina que calcula um número 'aleatório' como       *
;* descrito no enunciado			       *
;*******************************************************
NumAleat:	PUSH	R1
		MOV	R1, M[VarRandom]
		RORC	R1, 1
		MOV	R1, M[VarRandom]
		BR.NC	SeNao
		ROR	R1, 1
		MOV	M[VarRandom], R1
		BR	FimNumAleat
SeNao:		XOR	R1, RND_MASK
		ROR	R1, 1
		MOV	M[VarRandom], R1
FimNumAleat:	POP	R1
		RET

;*********************************************************
;*********************************************************
;**Rotina que efectua a escrita de um caracter na janela**
;** de texto. Recebe o caracter e o cursor pela pilha	**
;*********************************************************
;*********************************************************
EscCar:		PUSH	R1
		PUSH	R2
		MOV	R1, M[SP+5]		;Utiliza os valores passados 
		MOV	R2, M[SP+4]		;pilha para escrever um caracter 
		MOV	M[IO_CONTROL], R2	;(SP+5) na posição (SP+4)
                MOV     M[IO_WRITE], R1		;indicada
		POP	R2
		POP	R1
                RETN	2

;*********************************************************
;*********************************************************
;** Rotina que efectua a conversão e a escrita de um 	**
;** número na janela de texto. Recebe o caracter e o 	**
;** cursor pela pilha					**
;*********************************************************
;*********************************************************
EscNum:		PUSH	R1			;Número a escrever
		PUSH	R2			;Cursor
		MOV	R1, M[SP+5]
		MOV	R2, M[SP+4]
		ADD	R1, '0'
		PUSH	R1
		PUSH	R2
		CALL	EscCar
		POP	R2
		POP	R1
		RETN	2
;*****************************************************************
;*****************************************************************
;** Rotina que efectua a escrita de uma string na janela de 	**
;** texto, a string tem que terminar no caracter '$'. Recebe a	**
;** posição de memória onde se encontra o primeiro caracter a	**
;** escrever pelo R1 e o cursor onde começar a escrever em R2	**
;*****************************************************************
;*****************************************************************
EscString:     	PUSH	R1			;recebe string em R1
		PUSH	R2			;recebe cursor em R2
		PUSH	R3
		MOV	R1, M[SP+6]
		MOV	R2, M[SP+5]
Ciclo:          MOV     R3, M[R1]
                CMP     R3, FIM_TEXTO		
                BR.Z    FimEsc
		PUSH	R3
		PUSH	R2
                CALL    EscCar
                ADD	R2, INC_COLUNA
		INC	R1
                BR      Ciclo
FimEsc:		POP	R3
		POP	R2
		POP	R1
		RETN	2	


;*********************************************************
;*********************************************************
;**  Rotina que efectua a escrita dos limites do jogo	**
;**   e das mensagens iniciais na fanela de texto 	**
;*********************************************************
;*********************************************************
EscTabInicio:	PUSH	R1
		PUSH	R2
		PUSH	R3		;Registo que guardará o Cursor
		PUSH	R4
		MOV	R1, 0100h	;Valor da linha onde escrever
		MOV	R2, 0h		;Valor da Coluna onde escrever
		MOV 	R4, 20		;Contador que conta a linhas a escrever
Ciclo1:		CMP	R4, R0
		BR.Z	EscFundo
		MVBH	R3, R1
		MVBL	R3, R2
		PUSH	StrLimite
		PUSH	R3
		CALL	EscString
		ADD	R1, INC_LINHA	
		DEC	R4
		BR	Ciclo1
EscFundo:	MVBH	R3, R1
		PUSH	StrFundo
		PUSH	R3
		CALL	EscString
		PUSH	StrNomeJogo
		PUSH	POS_NOME
		CALL	EscString
		PUSH	StrPont
		PUSH	POS_PONT
		CALL	EscString
		CALL	EscPontuacao
		MOV	R3, POS_PRIMA
		PUSH	StrPrimaTecla1
		PUSH	R3	
		CALL	EscString
		ADD	R3, INC_LINHA
		PUSH	StrPrimaTecla2
		PUSH	R3
		CALL	EscString
		POP	R4
		POP	R3
		POP	R2
		POP	R1
		RET

;*********************************************************
;*********************************************************
;** Rotina que efectua a escrita das peças iniciais no	**
;** tabuleiro de jogo tendo em conta o jogo inicial	**
;** seleccionado pelo jogador		 		**
;*********************************************************
;*********************************************************
EscTabuleiro:	PUSH	R1
		PUSH	R2
		PUSH	R3
		MOV	R1, M[INTERRUPTORES]
		MOV	M[Tabuleiro], R1
		MOV	R1, TAMANHO_TAB
		MUL	M[Tabuleiro], R1
		ADD	R1, INI_0_JOGO
		MOV	R2, 20
		MOV	R3, POS_TAB
		PUSH	R1
		CALL	CopiaTab
EscTab:		PUSH	R1
		PUSH	R3
		CALL	EscString
		DEC	R2
		ADD	R1, TAMANHO_LINHA
		ADD	R3, INC_LINHA
		CMP	R2, R0
		BR.NZ	EscTab
		POP	R3
		POP	R2
		POP	R1
		RET



;*********************************************************
;*********************************************************
;**    Rotina que efectua a cópia do "tabuleiro" 	**
;**    escolhido para a posição de memória que irá	** 
;**    guardar o jogo que decorre		 	**
;*********************************************************
;*********************************************************
CopiaTab:	PUSH	R1		;Início do tabuleiro escolhido
		PUSH	R2		;Ínicio vector JOGO
		PUSH	R3		;Auxiliar
		PUSH	R4		;Contador do Tabuleiro
		PUSH	R5		;Contador da linha
		MOV	R4, JOGO_DIM
		MOV	R5, TAMANHO_LINHA 
		MOV	R1, M[SP+7]
		MOV	R2, JOGO
CopiaTab1:	DEC	R5
		CMP	R5, R0
		BR.Z	CopiaTab2
		MOV	R3, M[R1]
		MOV	M[R2], R3
		INC	R1
		INC	R2
		DEC	R4
		CMP	R4, R0
		BR.Z	ParaCopiaTab
		BR	CopiaTab1
CopiaTab2:	INC	R1
		MOV	R5, TAMANHO_LINHA
		BR	CopiaTab1
ParaCopiaTab:	POP	R5
		POP	R4
		POP	R3
		POP	R2
		POP	R1		
		RETN	1


;*********************************************************
;*********************************************************
;**    Rotina que apaga as linhas correspondentes	**
;**    às mensagens iniciais, que indicam como iniciar 	** 
;**    o jogo					 	**
;*********************************************************
;*********************************************************
ApagaInicial:	PUSH	R1
		MOV	R1, POS_PRIMA
		PUSH	StrBranco
		PUSH	R1
		CALL	EscString
		ADD	R1, INC_LINHA
		PUSH	StrBranco
		PUSH	R1
		CALL	EscString
		MOV	R1, POS_OVER
		PUSH	StrBranco
		PUSH	R1
		CALL	EscString
		ADD	R1, INC_LINHA
		PUSH	StrBranco
		PUSH	R1
		CALL	EscString
		POP	R1
		RET

;*************************************************
;*************************************************
;**   Rotina que efectua o movimento da peça	**
;**        ao longo  da primeira linha		**
;*************************************************
;*************************************************
IniciaVaiVem:	MOV	R7, VAIVEM_CONTADOR
		MOV	M[VaiVemContador], R7
		MOV	R1, M[Random]
		ADD	R1, PECAS
		MOV	R2, M[R1]
		MOV	M[VaiVemPeca], R2
		MOV	R1, 1
		MOV	M[VaiVemEstado], R1
		MOV	R1, VAIVEM_CURSOR
		MOV	M[VaiVemCursor], R1
		PUSH	M[VaiVemPeca]
		PUSH	M[VaiVemCursor]
		CALL	EscCar
		DEC	M[VaiVemContador]
		JMP	ParaVaiVem
VaiVem:		PUSH	R1
		PUSH	R2
		MOV	M[Int15], R0
		MOV	R1, VAIVEM_CONTADOR
		CMP	M[VaiVemContador], R1
		JMP.Z	IniciaVaiVem		
		CMP	M[VaiVemContador], R0	
		JMP.Z	TerminaVaiVem	
		CMP	M[VaiVemEstado], R0
		JMP.NZ	Incrementando
Decrementando:	PUSH	ESPACO
		PUSH	M[VaiVemCursor]
		CALL	EscCar
		DEC	M[VaiVemCursor]
		PUSH	M[VaiVemPeca]
		PUSH	M[VaiVemCursor]
		CALL	EscCar
		DEC	M[VaiVemContador]
		MOV	R1, M[VaiVemContador]
		CMP	R1, 4
		BR.NZ	ParaVaiVem
		INC	M[VaiVemEstado]
ParaVaiVem:	POP	R2
		POP	R1
		RET
Incrementando:	PUSH	ESPACO
		PUSH	M[VaiVemCursor]
		CALL	EscCar
		INC	M[VaiVemCursor]
		PUSH	M[VaiVemPeca]	
		PUSH	M[VaiVemCursor]	
		CALL	EscCar
		DEC	M[VaiVemContador]
		MOV	R1, M[VaiVemContador]
		CMP	R1, 12
		BR.NZ	ParaVaiVem
		DEC	M[VaiVemEstado]
		JMP	ParaVaiVem
TerminaVaiVem:	MOV	R1, VAIVEM_CONTADOR
		MOV	M[VaiVemContador], R1
		MOV	M[Int15], R0
		MOV	M[Int0], R1
		POP	R2
		POP	R1		
		RET
		
;*********************************************************
;*********************************************************
;**    Rotina que efectua a cópia do "tabuleiro" 	**
;**    escolhido para a posição de memória que irá	** 
;**    guardar o jogo que decorre		 	**
;*********************************************************
;*********************************************************
EscPontuacao:	PUSH	R1
		PUSH	R2
		PUSH	R3
		MOV	R1, M[Pontuacao]
		MOV	M[Pont_Max], R1
		MOV	R3, POS_PONTUACAO
		SUB	R3, 5
		PUSH	StrBranco
		PUSH	R3
		CALL	EscString
		MOV	R3, POS_PONTUACAO
EscPont1:	CMP	R1, R0
		BR.Z	ParaEscPont
		MOV	R2, 10
		DIV	R1, R2
		PUSH	R2
		PUSH	R3
		CALL	EscNum
		DEC	R3
		BR	EscPont1		
ParaEscPont:	CMP	R3, POS_PONTUACAO
		BR.NZ	TerminaEscPont
		PUSH	R0
		PUSH	R3
		CALL	EscNum
TerminaEscPont:	POP	R3
		POP	R2
		POP	R1
		RET
		
;*********************************************************
;*********************************************************
;** Rotina que efectua a queda da peça que se movimenta	**
;**       ao longo da primeira linha do jogo, e		**
;**   posteriormente verifica se existem pelo menos 3	**
;** peças iguais contíguas nas linhas do jogo. É ainda	**
;**  a rotina responsável pela queda da bomba, caso a 	**
;** peça presente na primeira linha do tabuleiro seja	**
;** '@'. Neste caso ele apaga a peça que ficar debaixo	**
;**      da bomba sem recorrer a rotinas auxiliares	**
;*********************************************************
;*********************************************************	
Cai:		PUSH	R7
		PUSH	R1
		PUSH	R2
		PUSH 	R3
		PUSH	R4
		PUSH	R5
		MOV	R7, VAIVEM_CONTADOR
		MOV	M[VaiVemContador], R7
		MOV	R7, 19
		MOV	R3, M[VaiVemCursor]
		MVBL	R1, M[VaiVemCursor]
		DEC	R1
		ADD	R1, JOGO
		MOV	R2, M[VaiVemPeca]
		MOV	M[R1], R2
Cai1:		CMP	R7, R0
		BR.Z	NaoCai
		MOV	R4, M[R1+9]
		CMP	R4, ESPACO
		BR.NZ	NaoCai
		MOV	R4, ESPACO
		MOV	M[R1], R4
		PUSH	ESPACO
		PUSH	R3
		CALL	EscCar
		ADD	R3, INC_LINHA
		PUSH	R2
		PUSH	R3
		CALL	EscCar
		ADD	R1, 9
		MOV	M[R1], R2
		DEC	R7
		BR	Cai1
NaoCai:		CMP	R7, 19
		JMP.Z	VeFim
		CMP	R2, '@'
		JMP.Z	Explode
		MVBL	R2, R3
		DEC	R2	
		SUB	R1, R2
		MOV	R2, R1
Ve:		I1OP	R1
		BR.Z	Para
		PUSH	R2
		CALL	Apaga
		POP	R2
		MOV	R1, R2
		BR	Ve
Para:		CMP	R7, 19
		BR.Z	VeFim1
		SUB	R2, 9
		MOV	R1, R2
		INC	R7
		BR	Ve
VeFim:		MOV	R7, 1
		MOV	M[GameOverCont], R7
VeFim1:		MOV	M[Int0], R0
		MOV	R7, 1
		MOV	M[CTRL_TEMP], R7
		POP	R5		
		POP	R4
		POP	R3
		POP	R2
		POP	R1
		POP	R7
		RET
Explode:	PUSH	R7
		CMP	M[SP+1], R0
		BR.NZ	ExplodeMeio
		PUSH	ESPACO
		PUSH	R3
		CALL	EscCar
		MOV	R7, ESPACO
		MOV	M[R1], R7
		BR	ExplodeFim
ExplodeMeio:	MOV	R7, ESPACO
		MOV	M[R1], R7
		MOV	M[R1+9], R7
		PUSH	ESPACO
		PUSH	R3
		CALL	EscCar
		ADD	R3, INC_LINHA
		PUSH	ESPACO
		PUSH	R3
		CALL 	EscCar
ExplodeFim:	POP	R7
		JMP	VeFim1
;*************************************************
;*************************************************
;** Rotina que efectua a inicialização de todas **
;**   as variáveis utilizadas durante o jogo	**
;*************************************************
;*************************************************
InitVar:	MOV	R1, VAIVEM_ESTADO
		MOV	M[VaiVemEstado], R1
		MOV	R1, VAIVEM_CURSOR
		MOV	M[VaiVemCursor], R1
		MOV	M[VaiVemPeca], R0
		MOV	R1, VAIVEM_CONTADOR
		MOV	M[VaiVemContador], R1
		MOV	M[GameOverCont], R0
		MOV	M[Pontuacao], R0
		MOV	M[Tabuleiro], R0
		MOV	M[Int0], R0
		MOV	M[Int1], R0
		MOV	M[Int15], R0
		MOV	R1, TEMPORIZADOR
		MOV	M[VALOR_TEMP], R1
		MOV	M[Difi], R0
		MOV	M[Unidades], R0
		MOV	M[Dezenas], R0
		MOV	M[Centenas], R0
		MOV	M[Milhares], R0
		MOV	R1, 1
		MOV	M[Leds], R1
		MOV	M[LEDS], R1
		MOV	R1, R0
		MOV	R2, R0
		MOV	R3, R0
		MOV	R4, R0
		MOV	R5, R0
		MOV	R6, R0
		MOV	R7, R0
		RET		
		
;*********************************************************
;*********************************************************
;**   Rotina que apaga as três peças consecutivas numa 	**
;**     linha, actualiza a pontuação (na memória e no 	** 
;**      display de 7 segmentos) e altera o valor da 	**
;**                  dificuldade do jogo		**
;*********************************************************
;*********************************************************
Apaga:		PUSH	R2
		PUSH	R4
		PUSH	R5
		PUSH	R7
		PUSH	R3		
		PUSH	R1
		MOV	R2, M[SP+8]
		MOV	R7, 20
		SUB	R7, M[SP+3]
		SHL	R7, 8
		MVBH	R3, R7
		SUB	R1, M[SP+8]
		MVBL	R3, R1
		INC	R3
		POP	R1
		PUSH	R3
		PUSH	R1
		MOV	R7, ESPACO
		MOV	R5, R0
		MOV	R4, M[R1]
		ADD	R2, 9
Apaga1:		CMP	R1, R2
		BR.Z	ApagaFim
		CMP	M[R1], R4
		BR.NZ	ApagaFim
		MOV	M[R1], R7
		INC	R1
		PUSH	R7
		PUSH	R3
		CALL	EscCar
		INC	R3
		INC	R5
		BR	Apaga1
ApagaFim:	PUSH	R5
		ADD	M[Pontuacao], R5
		PUSH	R5
		CALL	Act_Pont
		CALL	Poe_seg
		ADD	M[Difi], R5
difi:		MOV	R7, 3
		CMP	M[VALOR_TEMP], R7
		BR.Z	puxa
		MOV	R7, 5
		CMP	M[Difi], R7
		BR.N	puxa
		DEC	M[VALOR_TEMP]
		SUB	M[Difi], R7
		STC
		ROLC	M[Leds], 1
		MOV	R7, M[Leds]
		MOV	M[LEDS], R7
		BR	difi
puxa:		CALL 	puxapabaixo
		MOV	M[Int0], R0
		POP	R3
		POP	R7
		POP	R5
		POP	R4
		POP	R2
		RET		

;*********************************************************
;*********************************************************
;**    Rotina que desloca as peças do tabuleiro para	**
;**   baixo, tanto na memória como na janela de texto	** 
;*********************************************************
;*********************************************************
puxapabaixo:	PUSH	R1
		PUSH	R2
		PUSH	R3
		PUSH	R4
		PUSH	R7
		MOV	R1, M[SP+8]
		MOV	R2, M[SP+9]
		MOV	R4, M[SP+9]
PuxaMeio:	MOV	R5, M[SP+7]
		SUB	R1, 9
		MOV	R3, R1
		CMP	R1, JOGO
		JMP.N	PuxaFim
PuxaMeio1:	CMP	R5, R0
		BR.Z	PuxaInc
		MOV	R7, M[R1]
		MOV	M[R1+9], R7
		MOV	R7, ESPACO
		MOV	M[R1], R7
		SUB	R2, INC_LINHA
		PUSH	ESPACO
		PUSH	R2
		CALL 	EscCar
		ADD	R2, INC_LINHA
		PUSH	M[R1+9]
		PUSH	R2
		CALL	EscCar
		INC	R1
		INC	R2
		DEC	R5
		BR	PuxaMeio1
PuxaInc:	MOV	R1, R3
		SUB	R4, INC_LINHA
		MOV	R2, R4
		JMP	PuxaMeio
PuxaFim:	POP	R7
		POP	R4
		POP	R3
		POP	R2
		POP	R1
		RETN	3	

;*********************************************************
;*********************************************************
;** Rotina que é chamada quando se provoca a interrupção**
;**  1. Verifica se o jogador tem mais de 10 pontos e	** 
;** caso tenha retira dez pontos ao jogador actualizando**
;** a pontuação, se nao tiver é activada a variável de	**
;** controlo do Game Over. Caso seja possível usar uma	**
;**  bomba a rotina troca a peca presente na primeira	**
;**   linha do Tabuleiro de jogo (a que está por cair)	**
;**       pelo caracter '@' e chama a rotina Cai	**
;*********************************************************
;*********************************************************
Bomba:		PUSH	R7
		MOV	M[Int1], R0
		MOV	R7, 10
		DEC	M[Dezenas]
		CALL	Poe_seg
		SUB	M[Pontuacao], R7
		CMP	M[Pontuacao], R0
		BR.N	BombaOver
		MOV	R7, '@'
		MOV	M[VaiVemPeca], R7
		CALL	Cai
		MOV	R7, 1
		MOV	M[CTRL_TEMP], R7
		POP	R7
		RET
BombaOver:	MOV	M[Pontuacao], R0
		MOV	R7, 1
		MOV	M[GameOverCont], R7
		MOV	M[Unidades], R0
		MOV	M[Dezenas], R0
		MOV	M[Centenas], R0
		MOV	M[Milhares], R0
		CALL	Poe_seg
		POP	R7
		RET
		
;*********************************************************
;*********************************************************
;** Rotina que actualiza as variáveis utilizadas pelo	**
;**           display de sete segmentos.		** 
;*********************************************************
;*********************************************************
Act_Pont:	PUSH	R1
		PUSH	R2
		PUSH	R3
		MOV	R1, M[SP+5]
		MOV	R2, TESTE_9
		MOV	R3, TESTE_10
		ADD	M[Unidades], R1
		CMP	M[Unidades], R2	
		BR.P	Act1		
		BR	FimAct		
Act1:		SUB	M[Unidades], R3
		INC	M[Dezenas]
		CMP	M[Dezenas], R3
		BR.Z	Act2		
		BR	FimAct
Act2:		MOV	M[Dezenas], R0
		INC	M[Centenas]
		CMP	M[Centenas], R5
		BR.Z	Act3
		BR	FimAct
Act3:		MOV	M[Centenas], R0
		INC	M[Milhares]
		CMP	M[Milhares], R5
		BR.Z	Act4
		BR	FimAct
Act4:		MOV	M[Milhares], R0
FimAct:		POP	R3
		POP	R2
		POP	R1
		RETN	1
		

;*********************************************************
;*********************************************************
;**  Rotina que actualiza o display de sete segmentos.	** 
;*********************************************************
;*********************************************************
Poe_seg:	PUSH	R1
		PUSH	R2
		PUSH	R3
		PUSH	R4
		MOV	R1, M[Unidades]
		MOV	R2, M[Dezenas]
		MOV	R3, M[Centenas]
		MOV	R4, M[Milhares]
		MOV	M[SEG_1], R1
		MOV	M[SEG_2], R2
		MOV	M[SEG_3], R3
		MOV	M[SEG_4], R4
		POP	R4
		POP	R3
		POP	R2
		POP	R1
		RET		


Inicio:		MOV	R7, SP_INICIAL
		MOV	SP, R7
		MOV	R7, FFFFh
		MOV	M[IO_CONTROL], R7
		MOV	R7, INT_MASK
		MOV	M[INT_MASK_ADDR], R7		
		CALL	EscTabInicio
Inic_Jogo:	CALL	Aleatorio		
		CMP	M[IO_STATUS], R0
		BR.NZ	Meio1
		BR	Inic_Jogo
Meio1:		MOV	R7, M[IO_READ]
		MOV	R7, R0
		CALL	InitVar
		CALL	Poe_seg
		CALL	ApagaInicial
		CALL	EscTabuleiro
		MOV	R7, M[VALOR_TEMP]
		MOV	M[CONT_TEMP], R7
		MOV	R7, 1
		MOV	M[CTRL_TEMP], R7
		ENI
Meio:		CMP	M[GameOverCont], R0
		BR.NZ	GameOver
		CALL	Aleatorio
		CMP	M[Int15], R0
		CALL.NZ	VaiVem
		CMP	M[Int0], R0
		CALL.NZ	Cai		
		CMP	M[Int1], R0
		CALL.NZ	Bomba
		BR	Meio

GameOver:	MOV	M[GameOverCont], R0
		MOV	R1, StrGameOver
		PUSH	R1
		PUSH	POS_OVER
		CALL	EscString
		MOV	R1, StrNovaTecla1
		MOV	R3, POS_PRIMA
		PUSH	R1
		PUSH	R3
		CALL	EscString
		ADD	R3, INC_LINHA
		MOV	R1, StrNovaTecla2
		PUSH	R1
		PUSH	R3
		CALL	EscString
		MOV	R1, M[Pont_Max]
		CMP	M[Pontuacao], R1
		BR.N	GameOverFim
		CALL	EscPontuacao
GameOverFim:	JMP	Inic_Jogo
