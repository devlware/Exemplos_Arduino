/************************************************************************************
* IMBRAX - INDUSTRIA MECATRONICA BRASILEIRA
* Nome: exp02_potLevel
* Descricao: Continuacao do experimento 2 porem agora usamos os leds para mensurar o
* valor da resistencia do pot. Quanto mais alto o valor maior o numero de leds
* acessos.
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
  val = analogRead(potPin);
  // Faz a conversao do valor de 0-1024 para 0-255. Essa conversao e necessaria
//  val = map(val, 0, 1024, 0, 100);
  
  if (val > 0)
    digitalWrite(pwmLedPins[0], HIGH);
  else
    digitalWrite(pwmLedPins[0], LOW);
  
    if (val > 170)
    digitalWrite(pwmLedPins[1], HIGH);
  else
    digitalWrite(pwmLedPins[1], LOW);
    
  if (val > 340)
    digitalWrite(pwmLedPins[2], HIGH);
  else
    digitalWrite(pwmLedPins[2], LOW);

  if (val > 510)
    digitalWrite(pwmLedPins[3], HIGH);
  else
    digitalWrite(pwmLedPins[3], LOW);

  if (val > 680)
    digitalWrite(pwmLedPins[4], HIGH);
  else
    digitalWrite(pwmLedPins[4], LOW);

  if (val > 850)
    digitalWrite(pwmLedPins[5], HIGH);
  else
    digitalWrite(pwmLedPins[5], LOW);

  // Aguarda 20ms
  delay(20);    
}
