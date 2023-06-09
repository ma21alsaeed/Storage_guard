#ifndef OLED_h
#define OLED_h

#include <Adafruit_SSD1306.h>

class OLED {
  public:
    OLED();
    void begin();
    void splashScreen();
    void showText(String text);
    void showTempAndHum(float temperature, float humidity);
    void displayLoadingAnimation();
  private:
    Adafruit_SSD1306 display;
};

#endif