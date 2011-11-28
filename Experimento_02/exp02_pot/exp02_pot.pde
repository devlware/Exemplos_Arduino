/************************************************************************************
* IMBRAX - INDUSTRIA MECATRONICA BRASILEIRA
* Nome: exp02_pot
* Descricao: Evolucao do experimento 01, controla o acionamento de alguns leds usando
* o efeito de Fade mas agora com o potenciometro cuidando do tempo que o fade e
* executado.
*  
* Escrito por: Diego W. Antunes <diego@imbrax.com.br>
* Data: 01/10/2011
*************************************************************************************/

/************************************************************************************
* Constantes utilizadas no programa
************************************************************************************/
const int numLeds = 6; // Numero de leds conectados ao Arduino
const int potPin = 0; // Numero do pino da porta analogica onde esta o potenciometro

/* Array com o numero dos pinos onde estao conectados os leds no Arduino, cada numero
* representa uma porta digital com suporte a PWM
*/
const int pwmLedPins[numLeds] = {3, 5, 6, 9, 10, 11}; 

/************************************************************************************
* Variaveis
************************************************************************************/
int val = 10;

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
  // Aguarda 500ms ou meio segundo
  delay(500);
  
  // Loop para acender os LEDs usando o efeito de Fade
  for (int i = 0; i < numLeds; i++) {
    // Faz a leitura do valor da resistencia do potenciomentro
    val = analogRead(potPin);
    // Faz a conversao do valor de 0-1024 para 0-255. Essa conversao e necessaria
    val = map(val, 0, 1024, 0, 255);

    // Faz o fade em cada led com incremento de 5 pontos
    for(int fadeVal = 0; fadeVal <= 255; fadeVal += 5) {
      // Aplica o valor do fade no LED
      analogWrite(pwmLedPins[i], fadeVal);      
      // Aguarda um intervalo de tempo definido pela resistencia do potenciometro
      delay(val);
    }
  }
  
  // Aguarda 500ms ou meio segundo
  delay(500);
  
  // Agora executa o loop para desligar os LEDs com o efeito de Fade
  for (int i = numLeds - 1; i >= 0; i--) {
    val = analogRead(potPin);
    val = map(val, 0, 1024, 0, 255);
    
    for(int fadeVal = 255 ; fadeVal >= 0; fadeVal -=5) { 
      analogWrite(pwmLedPins[i], fadeVal);       
      delay(val);
    }
  }
}
