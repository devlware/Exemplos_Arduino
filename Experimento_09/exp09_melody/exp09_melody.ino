/************************************************************************************
* IMBRAX - INDUSTRIA MECATRONICA BRASILEIRA
* Nome: exp09_melodia
* Descricao: Toca uma melodia
*  
* Escrito originalmente por: Tom Igoe - http://arduino.cc/en/Tutorial/Tone
* Data: 21/01/2010, atualizado em 14/10/2010
* Modificado por Diego W. Antunes <diego@imbrax.com.br> em 01/10/2011
*************************************************************************************/

#include "pitches.h"

/************************************************************************************
* Constantes utilizadas no programa
************************************************************************************/
const int piezoPin = 8;

// notass na melodia:
const int melodia[] = { //250, 250, 280, 250, 335, 318};
NOTE_G2, NOTE_G2, NOTE_B0, NOTE_G2, NOTE_B3, NOTE_B2,
NOTE_G2, NOTE_G2, NOTE_B0, NOTE_G2, NOTE_E1, NOTE_B3, NOTE_B2, 
NOTE_E2, NOTE_E2, NOTE_E5, NOTE_E2, NOTE_B3, NOTE_B2, NOTE_B0, 
NOTE_E3, NOTE_E3, NOTE_E2, NOTE_B3, NOTE_E1, NOTE_B3, NOTE_B3};

// Duracao das notas: 4 = quarto de nota, 8 = oitavo de nota, etc.:
const int duracaoNotas[] = { 4, 8, 4, 8, 4, 8, 4, 8, 4, 8, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4 };

/************************************************************************************
* Funcao: setup
* Descricao: Faz a configuracao e inicializacao de algumas variaveis importantes
* Notas: 
************************************************************************************/
void setup()
{
  pinMode(piezoPin, OUTPUT);
}

/************************************************************************************
* Funcao: loop
* Descricao: Loop principal onde o microcontrolador deve passar a maior parte do tempo
* Notas:
************************************************************************************/
void loop() {
  
  // Varre as notas da melodia
  for (int estaNota = 0; estaNota < 20; estaNota++) {

    // Para calcular o duracao de uma nota, pegue um segundo e divida pelo tipo da nota
    // ex. quarta da nota = 1000 / 4, oitava da nota = 1000/8, etc.
    int duracaoNota = 1000 / duracaoNotas[estaNota];

// Syntaxe da funcao tone
// tone(pin, frequency) 
// tone(pin, frequency, duration)
    tone(piezoPin, melodia[estaNota], duracaoNota);

    // Para distinguir as notas configure um tempo minimo entre elas
    // A duracao da nota + 30% parece funcionar bem
    int pausaEntreNotas = duracaoNota * 1.30;
    delay(pausaEntreNotas);

    // Para de tocar a nota
    noTone(piezoPin);
  }

  delay(1000);
}
