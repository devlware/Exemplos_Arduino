/************************************************************************************
* IMBRAX - INDUSTRIA MECATRONICA BRASILEIRA
* Nome: exp01_leds
* Descricao: Controla o acionamento de alguns leds usando o efeito de Fade.
* 
* Escrito por: Diego W. Antunes <diego@imbrax.com.br>
* Data: 01/10/2011
*************************************************************************************/

/************************************************************************************
* Constantes utilizadas no programa
************************************************************************************/
const int numLeds = 6; // Numero de leds conectados ao Arduino

/* Array com o numero dos pinos onde estao conectados os leds no Arduino, cada numero
* representa uma porta digital com suporte a PWM
*/
const int pwmLedPins[numLeds] = {3, 5, 6, 9, 10, 11}; 

/************************************************************************************
* Variaveis
************************************************************************************/


/************************************************************************************
* Funcao: setup
* Descricao: Faz a configuracao e inicializacao de algumas variaveis importantes
* Notas: 
************************************************************************************/
void setup()
{
  // Configura os pinos onde estao os LEDs como saida
  for (int i = 0; i < numLeds; i++)
    pinMode(pwmLedPins[i], OUTPUT);
}

/************************************************************************************
* Funcao: loop
* Descricao: Loop principal onde o microcontrolador deve passar a maior parte do tempo
* Notas:
************************************************************************************/
void loop()
{
  int i = 0;
  int fadeVal = 0;
  
  // Loop para acender os LEDs usando o efeito de Fade
  for (i = 0; i < numLeds; i++) {
    // Faz o fade em cada led com incremento de 5 pontos
    for(fadeVal = 0; fadeVal <= 255; fadeVal += 5) {
      // Aplica o valor do fade no LED
      analogWrite(pwmLedPins[i], fadeVal);
      // Aguarda um intervalo de tempo de 30 milisegundos
      delay(30);
    }
  }
  
  // Aguarda 500ms ou meio segundo
  delay(500);
  
  // Agora executa o loop para desligar os LEDs com o efeito de Fade
  for (i = numLeds - 1; i >= 0; i--) {
    for(fadeVal = 255; fadeVal >= 0; fadeVal -= 5) { 
      analogWrite(pwmLedPins[i], fadeVal);         
      delay(30);
    }
  }
}
