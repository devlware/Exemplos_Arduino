/************************************************************************************
* IMBRAX - INDUSTRIA MECATRONICA BRASILEIRA
* Nome: exp05_ledrgb02
* Descricao: Gera um numero aleatorio entre 0 e 2, dependendo do numero uma cor do led
* fica apagada por completo. As outras duas cores variam de 0 ate um valor maximo
* igual ao segundo numero aleatorio gerado.
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
  // Inicializa o gerador de numeros aleatorios com o retorno da entrada A0
  randomSeed(analogRead(0));
}

/************************************************************************************
* Funcao: loop
* Descricao: Loop principal onde o microcontrolador deve passar a maior parte do tempo
* Notas:
************************************************************************************/
void loop()
{
  int randNumber = 0;
  int ledFixo = 0;
  
  analogWrite(greenPin, 0);
  analogWrite(redPin, 0);
  analogWrite(bluePin, 0);
  
  delay(100);
  
  ledFixo = random(3);
  randNumber = random(255);
  
  for (int i = 0; i < randNumber; i++) {
    if (ledFixo == 0)
      analogWrite(redPin, 0);
    else
      analogWrite(redPin, i);
    
    if (ledFixo == 1)
      analogWrite(greenPin, 0);
    else
      analogWrite(greenPin, i);
    
    if (ledFixo == 2)
      analogWrite(bluePin, 0);
    else
      analogWrite(bluePin, i);
        
    // Aguarda 20ms
    delay(20);
  }


  delay(500);
}
  

