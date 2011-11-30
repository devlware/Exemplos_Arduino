/************************************************************************************
* IMBRAX - INDUSTRIA MECATRONICA BRASILEIRA
* Nome: exp03_termistor
* Descricao: Faz a leitura do sensor de temperatura - termistor e com base no valor
* da resistencia do termistor aciona alguns leds para indicar a temperatura.
*  
* Escrito por: Diego W. Antunes <diego@imbrax.com.br> usando como base o codigo da
* http://www.ladyada.net/learn/sensors/thermistor.html da Ladyada.
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

#define THERMISTORPIN A2          // Pino do uC ligado no sensor
#define THERMISTORNOMINAL 10000   // Resistencia do  termistor a 25 graus
#define TEMPERATURENOMINAL 25     // Temp. nominal
#define NUMAMOSTRAS 5              // Numero de amostras
#define BCOEFFICIENT 3950         // Coeficiente beta
#define SERIESRESISTOR 10000      // Resistor em serie com o termistor

/************************************************************************************
* Variaveis
************************************************************************************/
int val = 10;
int amostras[NUMAMOSTRAS];

/************************************************************************************
* Funcao: setup
* Descricao: Faz a configuracao e inicializacao de algumas variaveis importantes
* Notas: 
************************************************************************************/
void setup()
{
  // Configura a porta serial
  Serial.begin(9600);

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
  float media;
 
  // Faz a leitura de X amostras para posterior calculo
  for (int i = 0; i < NUMAMOSTRAS; i++) {
    amostras[i] = analogRead(THERMISTORPIN);
    delay(10);
  }
 
  // Calcula a media
  media = 0;
  for (int i = 0; i < NUMAMOSTRAS; i++) {
    media += amostras[i];
  }
  media /= NUMAMOSTRAS;
 
  Serial.print("Media da leitura: "); 
  Serial.println(media);
 
  // convert the value to resistance
  media = 1023 / media - 1;
  media = SERIESRESISTOR / media;
 
  float steinhart;
  steinhart = media / THERMISTORNOMINAL;     // (R/Ro)
  steinhart = log(steinhart);                  // ln(R/Ro)
  steinhart /= BCOEFFICIENT;                   // 1/B * ln(R/Ro)
  steinhart += 1.0 / (TEMPERATURENOMINAL + 273.15); // + (1/To)
  steinhart = 1.0 / steinhart;                 // Invert
  steinhart -= 273.15;                         // convert to C
 
  /***********************************************************/
  /* Converte o valor da temperatura entre 20-26 para 0-1021 */
  /* Aqui posso mudar os intervalor de conversao             */
  /***********************************************************/
  val = map(steinhart, 20, 30, 0, 1021);
 
  // Exibe a temperatura em C e F  
  Serial.print("Temp: ");
  Serial.print(steinhart, 3);
  Serial.print(" *C - ");
  steinhart = (steinhart * (9/5)) + 32;
  Serial.print(steinhart, 3);
  Serial.println(" *F");
  
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
 
  // Aguardo 100ms pois normalmente a temperatura nao varia tao rapido
  delay(100);
}
