/************************************************************************************
* IMBRAX - INDUSTRIA MECATRONICA BRASILEIRA
* Nome: exp10_keys
* Descricao: 
*  
* Escrito por: Diego W. Antunes <diego@imbrax.com.br>
* Data: 01/10/2011
*************************************************************************************/

/************************************************************************************
* Constantes utilizadas no programa
************************************************************************************/
const int numLeds = 6;  // Constante com o numero total de leds acionados
const int potPin = 2;   // Pino onde o Pot esta ligado
const int pwmLedPins[numLeds] = {3, 5, 6, 9, 10, 11}; // Declara os pinos dos leds
const int buttonPin1 = 7;    // pushbutton pin
const int buttonPin2 = 8;    // pushbutton pin
const int buttonPin3 = 12;   // pushbutton pin
const int buttonPin4 = 13;   // pushbutton pin

/************************************************************************************
* Variaveis
************************************************************************************/
int val = 10;
int bt[4] = {0, 0, 0, 0};        // Controle de estado dos botoes
int btState[4] = {0, 0, 0, 0};   // Estado atual dos botoes
int lastBt[4] = {0, 0, 0, 0};    // Estado anterior dos botoes

unsigned long lastBlockTime = 0;        // inicializado quando um canal e bloqueado, reiniciado sempre que ha sinal em um canal
unsigned long debounceDelay = 50;       // the debounce time; increase if the output flickers
unsigned long lastDebounceTimeBt[4] = {0, 0, 0, 0};  // the last time the output pin was toggled

/************************************************************************************
* Funcao: setup
* Descricao: Faz a configuracao e inicializacao de algumas variaveis importantes
* Notas: 
************************************************************************************/
void setup()
{
  // Configura cada um dos pinos dos botoes como entrada
  pinMode(buttonPin1, INPUT);
  pinMode(buttonPin2, INPUT);
  pinMode(buttonPin3, INPUT);
  pinMode(buttonPin4, INPUT);
    
  // Configura os leds como saida
  for (int i = 0; i < numLeds; i++)
    pinMode(pwmLedPins[i], OUTPUT);

  // Inicializa a porta serial
  Serial.begin(9600);
}

/************************************************************************************
* Funcao: loop
* Descricao: Loop principal onde o microcontrolador deve passar a maior parte do tempo
* Notas:
************************************************************************************/
void loop()
{
  // Faz a leitura do estado dos botoes e se encarrega do tratamento  
  readButtonPins();
}

/************************************************************************************
* Funcao: readButtonPins
* Descricao: Verifica qual botao teve mudanca de estado e chama a ahndleButton.
* Notas:
************************************************************************************/
int readButtonPins()
{
  unsigned long actualTime = millis(); 
  
  bt[0] = digitalRead(buttonPin1);
  bt[1] = digitalRead(buttonPin2);
  bt[2] = digitalRead(buttonPin3);
  bt[3] = digitalRead(buttonPin4);
  
  // compara o estado atual com o estado anterior
  if (bt[0] != lastBt[0]) {
    lastDebounceTimeBt[0] = actualTime;
    handleButton(0);
  } else if (bt[1] != lastBt[1]) {
    lastDebounceTimeBt[1] = actualTime;
    handleButton(1);
  } else if (bt[2] != lastBt[2]) {
    lastDebounceTimeBt[2] = actualTime;
    handleButton(2);
  } else if (bt[3] != lastBt[3]) {
    lastDebounceTimeBt[3] = actualTime;
    handleButton(3);
  }
}

/************************************************************************************
* Funcao: handleButton
* Descricao: Trata o debounce dos botoes e chama a funcao para cada botao pressionado.
* Notas:
************************************************************************************/
void handleButton(const int button)
{
  if ((millis() - lastDebounceTimeBt[button]) > debounceDelay) {
    // executa uma nova leitura pois o tempo atual e maior que o debounceDelay
    btState[button] = bt[button];
  }
  
  switch (button) {
    case 0: {
      if (bt[button] == HIGH)
        turnBlinkTimes(4);      
    }
      break;
    case 1: {
      if (bt[button] == HIGH)
        turnOnLeds();
    }
      break;
    case 2: {
      if (bt[button] == HIGH)
        turnOffLeds();
    }
      break;   
    case 3: {
      if (bt[button] == HIGH)
        fadeInOutLeds();
    }
      break;
    default:
      break;
  }

  // atualiza o ultimo estado do botao
  lastBt[button] = bt[button];
}

/************************************************************************************
* Funcao: turnOnLeds
* Descricao: Liga todos os leds de uma vez.
* Notas:
************************************************************************************/

void turnOnLeds()
{
  Serial.println("turnOnLeds");
  
  for (int i = 0; i < numLeds; i++) {
    digitalWrite(pwmLedPins[i], HIGH);
  }
}

/************************************************************************************
* Funcao: turnOffLeds
* Descricao: Desliga os leds de uma so vez.
* Notas:
************************************************************************************/
void turnOffLeds()
{
  Serial.println("turnOffLeds");
   
  for (int i = 0; i < numLeds; i++) {
    digitalWrite(pwmLedPins[i], LOW);
  }
}

/************************************************************************************
* Funcao: turnBlinkTimes
* Descricao: Faz com que os leds pisquem numBlinks vezes.
* Notas:
************************************************************************************/
void turnBlinkTimes(const int numBlinks)
{
  Serial.println("turnBlinkTimes");
  
  for(int k = 0; k < numBlinks; k++) {
    for (int i = 0; i < numLeds; i++) {
      digitalWrite(pwmLedPins[i], HIGH);
    }
    
    delay(100);
    for (int i = 0; i < numLeds; i++) {
      digitalWrite(pwmLedPins[i], LOW);
    }
    
    delay(100);
  }
}

/************************************************************************************
* Funcao: fadeInOutLeds
* Descricao: Aplica o efeito de FadeIn-FadeOut nos leds.
* Notas:
************************************************************************************/
void fadeInOutLeds()
{
  Serial.println("fadeInOutLeds");
  
  for (int i = 0; i < numLeds; i++) {
    for (int fadeValue = 0; fadeValue < 255; fadeValue += 5) {
      analogWrite(pwmLedPins[i], fadeValue);
      val = analogRead(potPin);
      val = map(val, 0, 1024, 0, 100);
      delay(val);
    }
    
    for (int fadeValue = 255; fadeValue >= 0; fadeValue -= 5) {
      analogWrite(pwmLedPins[i], fadeValue);
      delay(val);
     }
  }
}

