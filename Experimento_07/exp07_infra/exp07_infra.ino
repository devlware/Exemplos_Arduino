/************************************************************************************
* IMBRAX - INDUSTRIA MECATRONICA BRASILEIRA
* Nome: exp07_infra
* Descricao: Faz a leitura do sensor infra-vermelho (foto transistor) e se o sinal for
* interrompido desliga os leds.
*  
* Escrito por: Diego W. Antunes <diego@imbrax.com.br>
* Data: 01/10/2011
*************************************************************************************/

/************************************************************************************
* Constantes utilizadas no programa
************************************************************************************/
const int infraRedPin = 2;
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
  Serial.begin(9600);
  pinMode(infraRedPin, INPUT);
  
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
  boolean sensor = false;
  
  sensor = digitalRead(infraRedPin);
  
  if (sensor == true) {
      // Loop para acender os LEDs usando o efeito de Fade
    for (int i = 0; i < numLeds; i++) {
      digitalWrite(pwmLedPins[i], LOW);
    }
  } else {
    for (int i = 0; i < numLeds; i++) {
      digitalWrite(pwmLedPins[i], HIGH);
    }
  }
  
  delay(100);  // Aguarda 200ms antes da proxima leitura
}

