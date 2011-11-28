/************************************************************************************
* IMBRAX - INDUSTRIA MECATRONICA BRASILEIRA
* Nome: exp03_termistor
* Descricao: Faz a leitura do sensor de temperatura - termistor e exibe o resultado
* pela porta Serial.
*  
* Escrito por: Diego W. Antunes <diego@imbrax.com.br>
* Data: 01/10/2011
*************************************************************************************/

/************************************************************************************
* Constantes utilizadas no programa
************************************************************************************/
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
 
  // Exibe a temperatura em C e F  
  Serial.print("Temp: ");
  Serial.print(steinhart, 3);
  Serial.print(" *C - ");
  steinhart = (steinhart * (9/5)) + 32;
  Serial.print(steinhart, 3);
  Serial.println(" *F");
   
  delay(1000);
}
