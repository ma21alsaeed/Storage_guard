#include "oled.h"
#include "storage_guard_logo.h"
#include "temp_icon.h"
#include "hum_icon.h"

OLED::OLED() : display(128, 64, &Wire, -1) {}

void OLED::begin() {
  display.begin(SSD1306_SWITCHCAPVCC, 0x3C);
}

void OLED::splashScreen() {
  String senstes[8] = {
    "Welcome to Storage Guard",
    "Your storage is secure with us",
    "Secure storage at your service",
    "We're watching over your items",
    "Your safety is our top priority",
    "Trust us to keep your storage secure",
    "Keeping your valuables safe and sound",
    "Welcome to the Storage Guard family"
  };
  display.clearDisplay();
  display.drawBitmap(0, 0, storage_guard_logo, 56, 62, 1);
  display.display();
  delay(1000);
  for (int i = 0; i < 10; i++) {
    display.drawBitmap(i * 15, 0, storage_guard_logo, 56, 62, 1);
    display.display();
    display.clearDisplay();
    delay(100);
  }
  delay(2000);
  int randomNumber = random(8);
  showText(senstes[randomNumber]);
  delay(2000);
}

void OLED::showText(String text) {
  display.clearDisplay();
  display.setTextSize(1.1);
  display.setTextColor(WHITE);
  if (text.length() > 15) {
    display.setCursor(5, 20);
    display.println(text.substring(0, 18));
    display.setCursor(20, 30);
    display.println(text.substring(18, text.length()));
    display.display();
  } else {
    display.setCursor(5, 40);
    display.println(text);
    display.display();
  }
}

void OLED::showTempAndHum(float temperature, float humidity) {
  display.clearDisplay();
  display.setTextSize(1);
  display.setTextColor(SSD1306_WHITE);
  display.setCursor(0, 10);
  display.println("Temperature:");
  display.setCursor(0, 20);
  display.print(temperature, 1);
  display.drawBitmap(70, 10, temp_icon, 12, 12, SSD1306_WHITE);
  display.drawLine(0, 30, 80, 30, SSD1306_WHITE);
  display.setCursor(0, 40);
  display.println("Humidity:");
  display.setCursor(0, 50);
  display.print(humidity, 1);
  display.drawBitmap(70, 40, hum_icon, 12, 12, SSD1306_WHITE);
  display.drawLine(0, 60, 80, 60, SSD1306_WHITE);
  display.display();
  delay(2000);
}

void OLED::displayLoadingAnimation() {
  display.setTextSize(1);
  display.setTextColor(WHITE);
  for (int i = 0; i < 100; i++) {
    float progress = (float)i / 100.0;
    display.clearDisplay();
    display.setCursor(0, 0);
    display.println("Loading...");
    display.fillRect(0, 20, progress * display.width(), 5, WHITE);
    display.display();
    delay(10);
  }
}
