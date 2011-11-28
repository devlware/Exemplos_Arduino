/************************************************************************************
* IMBRAX - INDUSTRIA MECATRONICA BRASILEIRA
* Nome: exp05_ledrgb01
* Descricao: Oscila o LED RGB com o efeito de fade, primeiro acende com a cor vermelha
* depois verde e depois azul.
*  
* Escrito por: Diego W. Antunes <diego@imbrax.com.br>
* Data: 01/10/2011
*************************************************************************************/

/************************************************************************************
* Constantes utilizadas no programa
************************************************************************************/
const int redPin = 6;    // RED pin of the LED to PWM pin 4 
const int greenPin = 5;  // GREEN pin of the LED to PWM pin 5
const int bluePin = 3;   // BLUE pin of the LED to PWM pin 6

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
  pinMode(redPin, OUTPUT); 
  pinMode(greenPin, OUTPUT); 
  pinMode(bluePin, OUTPUT); 
  Serial.begin(9600);
}

/************************************************************************************
* Funcao: loop
* Descricao: Loop principal onde o microcontrolador deve passar a maior parte do tempo
* Notas:
************************************************************************************/
void loop()
{
  int myDelay = 10;
  
  analogWrite(greenPin, 0);
  analogWrite(redPin, 0);
  analogWrite(bluePin, 0);

  for (int i = 0; i < 255; i++) {
    analogWrite(redPin, i);
    // Aguarda 20 ms para a proxima iteracao
    delay(myDelay);
  }
  for (int i = 255; i > 0; i--) {
    analogWrite(redPin, i);
    // Aguarda 20 ms para a proxima iteracao
    delay(myDelay);
  }
  for (int i = 0; i < 255; i++) {
    analogWrite(greenPin, i);
    // Aguarda 20 ms para a proxima iteracao
    delay(myDelay);
  }
  for (int i = 255; i > 0; i--) {
    analogWrite(greenPin, i);
    // Aguarda 20 ms para a proxima iteracao
    delay(myDelay);
  }  
  for (int i = 0; i < 255; i++) {
    analogWrite(bluePin, i);
    // Aguarda 20 ms para a proxima iteracao
    delay(myDelay);
  }
  for (int i = 255; i > 0; i--) {
    analogWrite(bluePin, i);
    // Aguarda 20 ms para a proxima iteracao
    delay(myDelay);
  }

  delay(500);
}

