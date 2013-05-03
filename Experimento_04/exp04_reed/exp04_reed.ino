/************************************************************************************
* IMBRAX - INDUSTRIA MECATRONICA BRASILEIRA
* Nome: exp04_reed
* Descricao: 
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
const int alarmPin = 2; // Pino onde esta conectado o alarme


/************************************************************************************
* Variaveis
************************************************************************************/
int val = 10;
boolean alarmFlag = false;  // flag que indica que o alarme foi acionado

/************************************************************************************
* Funcao: setup
* Descricao: Faz a configuracao e inicializacao de algumas variaveis importantes
* Notas: 
************************************************************************************/
void setup()
{
  pinMode(alarmPin, INPUT);

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
  // Verifica se o alarme esta acionado ou circuito aberto
  if (digitalRead(alarmPin) == false) {
    alarmFlag = true;
  } else {
    for (int i = 0; i < numLeds; i++) {
      digitalWrite(pwmLedPins[i], LOW);
    }
  }
  
  blinkLeds();
}

/************************************************************************************
* Funcao: blinkLeds
* Descricao: 
* Notas:
************************************************************************************/
void blinkLeds()
{
  for (int i = 0; i < numLeds; i++) {
    digitalWrite(pwmLedPins[i], HIGH);
  }
  delay(30);
}
  
