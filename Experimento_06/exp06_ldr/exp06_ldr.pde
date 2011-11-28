/************************************************************************************
* IMBRAX - INDUSTRIA MECATRONICA BRASILEIRA
* Nome: exp06_ldr
* Descricao: Faz a leitura do sensor de luminosidade LDR e controla o acionamento do
* LED vermelho no LED RGB. Quanto mais escuro mais claro o LED vermelho ficara.
*  
* Escrito por: Diego W. Antunes <diego@imbrax.com.br>
* Data: 01/10/2011
*************************************************************************************/

/************************************************************************************
* Constantes utilizadas no programa
************************************************************************************/
const int ldrPin = 0;     // O sensor LDR e o resistor estao ligados no pino A0

/************************************************************************************
* Variaveis
************************************************************************************/
int ldrValue;         // Leitura do divisor de tensao
int ledPin = 6;       // LED vermelho do RGB (pino PWM)
int ledBrilho;        // Brilho do LED

/************************************************************************************
* Funcao: setup
* Descricao: Faz a configuracao e inicializacao de algumas variaveis importantes
* Notas: 
************************************************************************************/
void setup()
{
  Serial.begin(9600);
}

/************************************************************************************
* Funcao: loop
* Descricao: Loop principal onde o microcontrolador deve passar a maior parte do tempo
* Notas:
************************************************************************************/
void loop()
{
  // Faz a leitura do pino analogico onde esta ligado o sensor de luz, A0
  ldrValue = analogRead(ldrPin);  
 
  Serial.print("Leitura analogica = ");
  Serial.println(ldrValue);     // the raw analog reading
 
  // Quanto mais escuro estiver o ambiente mais claro ficara o LED
  ldrValue = 1023 - ldrValue;
  
  // Faz a conversao de escala de 0-1024 para 0-255 que e aceito pelo analogWrite
  ledBrilho = map(ldrValue, 0, 1023, 0, 255);
  
  // Configura o valor do LED
  analogWrite(ledPin, ledBrilho);
  
  // Aguarda antes da proxima leitura
  delay(100);
}

