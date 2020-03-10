#include <Adafruit_NeoPixel.h>

#define PIN 8
#define NUM_LEDS 60

int r;
int g;
int b;
Adafruit_NeoPixel strip = Adafruit_NeoPixel(NUM_LEDS, PIN, NEO_GRBW + NEO_KHZ800);

void setup() {
  // start the strip and blank it out
  strip.begin();
  strip.show();
  randomSeed(analogRead(0));
  Serial.begin(9600);
}

void loop() {
//  for(int i=0; i<NUM_LEDS; i++){
//    r = random(255);
//    g = random(255);
//    b = random(255);
//    strip.setPixelColor(i, r, g, b, 0);
//    strip.show();
//    delay(50);
//  }
  for(int i=0; i<NUM_LEDS; i++){
    strip.setPixelColor(i, 255, 0, 0, 0);
    strip.show();
    delay(50);
  }

  strip.show();

  for(int i=NUM_LEDS; i>=0; i--){
    strip.setPixelColor(i, 255, 0, 0, 0);
    strip.show();
    delay(50);
  }
//
//  for(int i=NUM_LEDS - 1; i >= 0; i--){
//    strip.setPixelColor(i, 250, 251, 164, 0);
//    strip.show();
//    delay(50);
//    strip.setPixelColor(i, 0, 0, 0, 0);
//    strip.show();
//  }
//
//  for(int i=0; i<NUM_LEDS; i++){
//    strip.setPixelColor(i, 161, 230, 227, 0);
//    strip.show();
//    delay(50);
//    strip.setPixelColor(i, 0, 0, 0, 0);
//    strip.show();
//  }
}
