/************************************************************************************
* IMBRAX - INDUSTRIA MECATRONICA BRASILEIRA
* Nome: exp03_termistorLeds2
* Descricao: Faz a leitura do sensor de temperatura - termistor e com base no valor
* da resistencia do termistor aciona alguns leds para indicar a temperatura.
*  
* Escrito por: Diego W. Antunes <diego@imbrax.com.br> usando como base o codigo da
* http://www.ladyada.net/learn/sensors/thermistor.html da Ladyada.
* Data: 30/04/2013
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

/************************************************************************************
* Funcao: void setup(void)
* Descricao: Faz a configuracao e inicializacao de algumas variaveis importantes
* Notas: 
************************************************************************************/
void setup(void)
{
    Serial.begin(9600);
    for (uint8_t i = 0; i < numLeds; i++) {
        pinMode(pwmLedPins[i], OUTPUT);
        Serial.println(pwmLedPins[i]);
    }
    pinMode(THERMISTORPIN, INPUT);
}

/************************************************************************************
* Funcao: void loop(void)
* Descricao: Faz a configuracao e inicializacao de algumas variaveis importantes
* Notas: 
************************************************************************************/
void loop(void)
{   
    float t = readSensor();
    showTempInLeds(t);
    delay(500);
}

/************************************************************************************
* Funcao: float readSensor(void)
* Descricao: Funcao para fazer a aquisicao do sensor de temperatura e converter.
* Notas: 
************************************************************************************/
float readSensor(void)
{
    uint8_t i;
    float average;
    int samples[NUMAMOSTRAS];

    // take N samples in a row, with a slight delay
    for (i = 0; i< NUMAMOSTRAS; i++) {
        samples[i] = analogRead(THERMISTORPIN);
        delay(10);
    }

    // average all the samples out
    average = 0;
    for (i = 0; i < NUMAMOSTRAS; i++) {
       average += samples[i];
    }
    average /= NUMAMOSTRAS;

    // convert the value to resistance
    average = 1023 / average - 1;
    average = SERIESRESISTOR / average;

    float steinhart;
    steinhart = average / THERMISTORNOMINAL;     // (R/Ro)
    steinhart = log(steinhart);                  // ln(R/Ro)
    steinhart /= BCOEFFICIENT;                   // 1/B * ln(R/Ro)
    steinhart += 1.0 / (TEMPERATURENOMINAL + 273.15); // + (1/To)
    steinhart = 1.0 / steinhart;                 // Invert
    steinhart -= 273.15;                         // convert to C

    return steinhart;
}

/************************************************************************************
* Funcao: void showTempInLeds(const float temp)
* Descricao: Recebe a temperatura atual, salva um setpoint na primeira leitura e nas
*            proximas iteracoes acende um led para cada variacao da temperatura que
*            foi definida em variation.
* Notas: 
************************************************************************************/
void showTempInLeds(const float temp)
{
    static bool isFirstTime = true;
    static float setPoint = 0.0;
    const float variation = 0.5;
    uint8_t numLeds = 0;

    Serial.print("Setpoint: ");
    Serial.println(setPoint);
    Serial.print("Actual Temp: ");
    Serial.println(temp);
    
    if (isFirstTime) {
        setPoint = temp;
        isFirstTime = false;
        return;
    }

    for (uint8_t i = 0; i < 6; i++) {
        digitalWrite(pwmLedPins[i], LOW);
    }
        
    if (temp > setPoint + variation) {
        numLeds = (uint8_t) (temp - setPoint) / variation;
        numLeds = constrain(numLeds, 1, 6);
        Serial.print("num leds: ");
        Serial.println(numLeds);

        for (uint8_t i = 0; i < numLeds; i++) {
            digitalWrite(pwmLedPins[i], HIGH);
        }
    }
}

