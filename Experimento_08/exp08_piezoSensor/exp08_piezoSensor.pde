/************************************************************************************
* IMBRAX - INDUSTRIA MECATRONICA BRASILEIRA
* Nome: exp08_piezoSensor
* Descricao: 
*  
* Escrito por: DojoDave <http://www.0j0.org>
* Data: 01/10/2011
*************************************************************************************/

/************************************************************************************
* Constantes utilizadas no programa
************************************************************************************/
const int ledPin = 3;    // RED pin of the LED to PWM pin 4 

/************************************************************************************
* Variaveis
************************************************************************************/
int knockSensor = 0;  // sensor de golpes ligado ao pino analógico 0
byte val = 0;         // varaiavel que armazena o valor lido no pino do sensor
int statePin = LOW;   // variável usada para armazenar o ultimo status do led para fazer a alteracao
int THRESHOLD = 100;  // limite utilizado para decidir se o som detectado é um golpe ou não

/************************************************************************************
* Funcao: setup
* Descricao: Faz a configuracao e inicializacao de algumas variaveis importantes
* Notas: 
************************************************************************************/
void setup()
{
  pinMode(ledPin, OUTPUT); // declera o ledPin como uma saida
  Serial.begin(9600);
}

/************************************************************************************
* Funcao: loop
* Descricao: Loop principal onde o microcontrolador deve passar a maior parte do tempo
* Notas:
************************************************************************************/
void loop()
{
  val = analogRead(knockSensor);    // le o sensor e armazena o valor na variavel "val"
  
  if (val >= THRESHOLD) {
    statePin = !statePin;           // altera o estado do ledPin (este truque nao utiliza ciclos de tempo)
    digitalWrite(ledPin, statePin); // acende ou apaga o LED
    Serial.println("Knock!");       // envia a string "Knock!" de volta para o computador
    delay(10);                      // espera curta para previnir sobrecarga na porta serialcv
  }
}

/* Sensor de golpes
 * por 
 *
 * Programa que utiliza um elemento piezoelétrico como um sensor de golpes.
 *
 * Nos temos basicamente que ler um pino analógico e detectar
 * se o sinal ultrapassa um certo limite. Se isso ocorrer escrevemos
 * "knock" na porta serial e alteramos o valor do led no pino 13.
 *
 * http://www.multilogica-shop.com/Aprendendo/Exemplos/Golpe
 */



}
