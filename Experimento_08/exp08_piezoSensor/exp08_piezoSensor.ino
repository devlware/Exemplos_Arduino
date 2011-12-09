/************************************************************************************
* IMBRAX - INDUSTRIA MECATRONICA BRASILEIRA
* Nome: exp08_piezoSensor
* Descricao: 
*  
* Escrito por: Diego W. Antunes <diego@imbrax.com.br>
* Data: 01/10/2011
*************************************************************************************/

/************************************************************************************
* Constantes utilizadas no programa
************************************************************************************/
const int piezoPin = 1; // Pino onde esta conectado o sensor piezoeletrico
const int ledPin = 13; // Pino da placa Arduino onde tem um led soldado

/************************************************************************************
* Variaveis
************************************************************************************/
byte val = 0;
int statePin = LOW;
int THRESHOLD = 100;

/************************************************************************************
* Funcao: setup
* Descricao: Faz a configuracao e inicializacao de algumas variaveis importantes
* Notas: 
************************************************************************************/
void setup()
{
  pinMode(piezoPin, INPUT);
  pinMode(ledPin, OUTPUT);
  Serial.begin(9600);       // use the serial port  
}

/************************************************************************************
* Funcao: loop
* Descricao: Loop principal onde o microcontrolador deve passar a maior parte do tempo
* Notas:
************************************************************************************/
void loop()
{
  val = analogRead(piezoPin);
  
  if (val >= THRESHOLD) {
    statePin = !statePin;
    
    digitalWrite(ledPin, statePin);
    Serial.println(val, DEC);    
  }
  delay(100);  // we have to make a delay to avoid overloading the serial port
}
