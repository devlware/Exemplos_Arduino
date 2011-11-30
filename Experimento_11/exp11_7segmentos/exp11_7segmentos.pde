/************************************************************************************
* IMBRAX - INDUSTRIA MECATRONICA BRASILEIRA
* Nome: exp11_7segmentos
* Descricao: Controla o acionamento de um display de 7 segmentos.
*  
* Escrito por: Diego W. Antunes <diego@imbrax.com.br>
* Data: 01/10/2011
*************************************************************************************/

/************************************************************************************
* Constantes utilizadas no programa
************************************************************************************/
const int pinA = 6; // Pino usado de saida do Arduino que controla o sinal A do cd4511
const int pinB = 7; // Segue sequencia da descricao acima
const int pinC = 8;
const int pinD = 9;

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
  // Configura a velocidade da porta serial
  Serial.begin(9600);

  // Diz ao controlador que os pinos são de saída
  pinMode(pinA, OUTPUT);
  pinMode(pinB, OUTPUT);
  pinMode(pinC, OUTPUT);
  pinMode(pinD, OUTPUT);
}

/************************************************************************************
* Funcao: loop
* Descricao: Loop principal onde o microcontrolador deve passar a maior parte do tempo
* Notas:
************************************************************************************/
void loop()
{
  // Faz um loop de 0 a 9
  for (int i = 0; i < 10; i++) {
    // Imprime o valor desejado
    clean();
    number(i);
    // Aguarda meio segundo
    delay(500);
  }
 
  // Apaga o número
  clean();
  // Aguarda 1 segundo
  delay(1000);
  
  // Faz um loop de 9 a 0 
  for (int i = 9; i >= 0; i--) {
    clean();
    // Imprime o valor desejado
    number(i);
    // Aguarda meio segundo    
    delay(500);
  }
}

/************************************************************************************
* Funcao: loop
* Descricao: Loop principal onde o microcontrolador deve passar a maior parte do tempo
* Notas:
************************************************************************************/
void clean()
{
  digitalWrite(pinA, LOW);
  digitalWrite(pinB, HIGH);
  digitalWrite(pinC, LOW);
  digitalWrite(pinD, HIGH);
  delay(10);
}

/************************************************************************************
* Funcao: number
* Descricao: Recebe um inteiro como parâmetro, com base no número configura os pinos
* de saída conforme da tabela BCD do CI CD4511.
* Notas:
************************************************************************************/
void number(const int num)
{
  switch (num) {
    case 0:
      digitalWrite(pinA, LOW);
      digitalWrite(pinB, LOW);
      digitalWrite(pinC, LOW);
      digitalWrite(pinD, LOW);
      break;
    case 1:
      digitalWrite(pinA, HIGH);
      digitalWrite(pinB, LOW);
      digitalWrite(pinC, LOW);
      digitalWrite(pinD, LOW);
      break;
    case 2:
      digitalWrite(pinA, LOW);
      digitalWrite(pinB, HIGH);
      digitalWrite(pinC, LOW);
      digitalWrite(pinD, LOW);
      break;
    case 3:
      digitalWrite(pinA, HIGH);
      digitalWrite(pinB, HIGH);
      digitalWrite(pinC, LOW);
      digitalWrite(pinD, LOW);
      break;
    case 4:
      digitalWrite(pinA, LOW);
      digitalWrite(pinB, LOW);
      digitalWrite(pinC, HIGH);
      digitalWrite(pinD, LOW);
      break;
    case 5:
      digitalWrite(pinA, HIGH);
      digitalWrite(pinB, LOW);
      digitalWrite(pinC, HIGH);
      digitalWrite(pinD, LOW);
      break;
    case 6:
      digitalWrite(pinA, LOW);
      digitalWrite(pinB, HIGH);
      digitalWrite(pinC, HIGH);
      digitalWrite(pinD, LOW);
      break;
    case 7:
      digitalWrite(pinA, HIGH);
      digitalWrite(pinB, HIGH);
      digitalWrite(pinC, HIGH);
      digitalWrite(pinD, LOW);
      break;
    case 8:
      digitalWrite(pinA, LOW);
      digitalWrite(pinB, LOW);
      digitalWrite(pinC, LOW);
      digitalWrite(pinD, HIGH);
      break;
    case 9:
      digitalWrite(pinA, HIGH);
      digitalWrite(pinB, LOW);
      digitalWrite(pinC, LOW);
      digitalWrite(pinD, HIGH);
      break;
    default:
      digitalWrite(pinA, LOW);
      digitalWrite(pinB, HIGH);
      digitalWrite(pinC, LOW);
      digitalWrite(pinD, HIGH);
  }
}

