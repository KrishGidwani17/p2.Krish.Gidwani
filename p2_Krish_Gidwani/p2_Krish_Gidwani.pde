/*

Krish Gidwani
CS 3366 Section 002 - Human Computer Interaction

Project 2

This Processing project simulates a smart mirror interface

This smart mirror is interactive, and changes based on the users inputs
*/

//importing neccesary libraries
import java.util.Calendar;


//defining reused variables

//basic reused varibales
int roundedRadius = 20;
int borderLength = 6;
int textSize = 25;

String todayViewText = "";
String tempTodayViewText = "";
String cleanedHourVal;
String cleanedMinuteVal;
String cleanedMonthVal;

//csv table
Table table;

//png image objects
PImage bulbIcon;
PImage moreAppsIcon;
PImage calandarIcon;
PImage gearIcon;
PImage heartIcon;
PImage newsIcon;
PImage weatherIcon;
PImage powerIcon;
PImage bathrromBackround;


//basic length and width variables
int baseX = 100;
int baseY = 50;
int baseLength = 1400;
int baseWidth = 900;

int mirrorX = 125;
int mirrorY = 75;
int mirrorLength = 1350;
int mirrorWidth = 850;

int todayViewX = 150;
int todayViewY = 100;
int todayViewLength = 300;
int todayViewWidth = 800;

int todayViewTextX = 160;
int todayViewTextY = 110;

int ledOnOffX = 750;
int ledOnOffY = 825;
int ledOnOffLength = 75;
int ledOnOffWidth = 75;

int moreAppsX = 150;
int moreAppsY = 825;
int moreAppsLength = 75;
int moreAppsWidth = 75;

int moreAppsWindowX = 232;
int moreAppsWindowY = 830;
int moreAppsWindowWidth = 70;
int moreAppsWindowLength = 500;

//app icons
int iconX = 242;
int iconY = 840;
int iconWidth = 60;
int iconLength = 50;

//boolean display today values
boolean displayTime = true;
boolean displayDate = true;
boolean displayWeather = true;
boolean displayHealth = false;
boolean displayCalandar = false;
boolean displayNews = false;


//basic colors
color mirrorColor = color(127, 135, 132);
color applicationColor = color(60, 66, 64, 120);
color blackColor = color(0, 0, 0);
color displayInfoColor = color(60, 66, 64);
color hoverColor = color(212, 207, 207);


//LED colors
color redColor = color(224, 56, 47);
color orangeColor = color(224, 106, 47);
color yellowColor = color(218, 224, 47);
color greenColor = color(74, 224, 47);
color blueColor = color(47, 91, 224);
color purpleColor = color(192, 47, 224);
color whiteLedColor = color(246, 240, 247);
color warmColor = color(240, 199, 77);
color softColor = color(77, 221, 240);
color ledFrameColor;

color redHover = color(212, 112, 110);
color orangeHover = color(237, 164, 69);
color yellowHover = color(212, 203, 108);
color greenHover = color(146, 212, 108);
color blueHover = color(79, 168, 219);
color purpleHover = color(169, 124, 194);
color whiteHover = color(147, 145, 148);
color warmHover = color(237, 205, 159);
color softHover = color(183, 225, 237);

//LED boolean values 
boolean redOn = false;
boolean orangeOn = false;
boolean yellowOn = false;
boolean greenOn = false;
boolean blueOn = false;
boolean purpleOn = false;
boolean whiteOn = true;
boolean softOn = false;
boolean warmOn = false;

//turn on/off led
boolean turnOnLed = false;
boolean turnOffLed = true;


//over boolean values
boolean overLedButton = false;
boolean overMoreAppsButton = false;

boolean overCalendarApp = false;
boolean overWeatherApp = false;
boolean overHealthApp = false;
boolean overNewsApp = false;
boolean overBulbApp = false;
boolean overSettingsApp = false;


//more apps window
boolean displayMoreApps = false;
boolean displayMoreAppsWindow = false;

//application functions
boolean displayCalendarData = false;
boolean displayWeatherData = false;
boolean displayHealthData = false;
boolean displayNewsData = false;
boolean displayLightsData = false;
boolean displaySettingsData = false;

//app LED boolaen values
boolean overRed = false;
boolean overOrange = false;
boolean overYellow = false;
boolean overGreen = false;
boolean overBlue = false;
boolean overPurple = false;
boolean overWhite = false;
boolean overSoft = false;
boolean overWarm = false;
boolean overOnOff = false;

//settings boolean value
boolean overTimeToggle = false;
boolean overWeatherToggle = false;
boolean overDateToggle = false;
boolean overHealthToggle = false;
boolean overCalendarToggle = false;
boolean overNewsToggle = false;


//power button
boolean overPowerButton = false;
boolean continueToDisplay = true;
int powerButtonX = 1375;
int powerButtonY = 825;
int powerButtonWidth = 75;
int powerButtonLength= 75;

boolean powerOn = true;

//notifications
int notificationWindowX = 1150;
int notificationWindowY = 105;
int notificationWindowLength = 300;
int notificationWindowWidth = 125;

boolean runWeather;


 //setup function -> ran once
void setup() {
  //window size
  size(1600, 1000);  
   //loading data csv
  table = loadTable("p2_data_file.csv", "header");
  //loading images
  bulbIcon = loadImage("bulb_icon.png");
  moreAppsIcon = loadImage("apps_icon.png");
  calandarIcon = loadImage("calandar_icon.png");
  gearIcon = loadImage("gear_icon.png");
  newsIcon = loadImage("news_icon.png");
  weatherIcon = loadImage("weather_icon.png");
  heartIcon = loadImage("heart_icon.png");
  powerIcon = loadImage("power_icon.png");
  bathrromBackround = loadImage("bathroom_backround.png");
  runWeather = true;
}

StringList todayViewFinalList;

//draw function -> runs forever
void draw() {
  
  //creating led frame of mirror
  ledFrameColor = getLedColor();
  if (turnOnLed) {
    fill(ledFrameColor);
  }
  
  else {
    fill(blackColor);
  }
  stroke(blackColor);
  strokeWeight(borderLength);
  rect(baseX, baseY, baseLength, baseWidth, roundedRadius);
  
  //creating base mirror
  fill(mirrorColor);
  stroke(blackColor);
  strokeWeight(borderLength);
  rect(mirrorX, mirrorY, mirrorLength, mirrorWidth, roundedRadius);
  image(bathrromBackround, mirrorX, mirrorY, width/1.18, height/1.17);
  
  
  //Today View Text
  if (continueToDisplay) {
      todayViewFinalList = displayTodayMessage();
      todayViewText = getTodayMessage(todayViewFinalList);
  }
  
  else {
      todayViewText = "";
  }
  fill(blackColor);
  textSize(textSize); 
  text(todayViewText, todayViewTextX, todayViewTextY);
  
  update(mouseX, mouseY);
  //LED on/off button
  if (overLedButton && powerOn) {
    fill(hoverColor);
    textSize(20);
    text("LED ON/OFF", 740, 800);
  }
  else {
    fill(applicationColor);
  }
  stroke(blackColor);
  strokeWeight(borderLength);
  rect(ledOnOffX, ledOnOffY, ledOnOffLength, ledOnOffWidth, roundedRadius);
  //displaying image
  image(bulbIcon, 750, 827, width/22, height/16);
  
  //Multiple Apps Icon
  update(mouseX, mouseY);
  
  if (overMoreAppsButton && powerOn) {
      fill(hoverColor);
      text("Open More Apps", 280, 800);
      fill(hoverColor);
  }
  
  else {
      fill(applicationColor);
  }
  stroke(blackColor);
  strokeWeight(borderLength);
  rect(moreAppsX, moreAppsY, moreAppsWidth, moreAppsLength, roundedRadius);
  image(moreAppsIcon, 160, 835, width/28, height/20);
  
  //more apps window
  
  if (displayMoreApps && powerOn) {

    fill(applicationColor, 0.0);
    stroke(mirrorColor, 0.0);
    strokeWeight(3);
    rect(moreAppsWindowX, moreAppsWindowY, moreAppsWindowLength, moreAppsWindowWidth, roundedRadius);
    //having individual applications
    stroke(blackColor);
    strokeWeight(3);
    
    //calandar
    if (overCalendarApp) {
      fill(hoverColor);
      textSize(20);
      textSize(textSize);
      text("Calendar", 280, 800);
      fill(hoverColor);
    }
    else {
      fill(applicationColor);
    }
    stroke(blackColor);
    strokeWeight(3);
    rect(iconX, iconY, iconWidth, iconLength, roundedRadius);
    image(calandarIcon, 248, 842, width/33, height/23);
    if (displayCalendarData && powerOn) {
        stroke(blackColor);
        strokeWeight(borderLength);
        fill(applicationColor);
        rect(475, 550, 250, 259, roundedRadius);
        fill(blackColor);
        text("Calendar", 555, 580);
        
        //displaying calendar data
        StringList calendarData;
        String todaysDate;
        String[] cleanedValOneString;
        calendarData = getCalendar();
        todaysDate = getDate();
        
        cleanedValOneString = split(calendarData.get(1), " ");
        
        text(todaysDate + ":", 482, 620);
        text("   •" + calendarData.get(0), 480, 660); 
        text("   •" + "HCI Class", 480, 700); 
        text("   •" + calendarData.get(2), 480, 740); 
        text("   •" + calendarData.get(3), 480, 780);     
    }
    //weather
    if (overWeatherApp) {
      fill(hoverColor);
      //textSize(20);
      text("Weather", 280, 800);
      fill(hoverColor);
    }
    else {
      fill(applicationColor);
    }
    stroke(blackColor);
    strokeWeight(3);
    rect(iconX+82, iconY, iconWidth, iconLength, roundedRadius);
    image(weatherIcon, 330, 843, width/33, height/23);
    if (displayWeatherData && powerOn) {
        stroke(blackColor);
        strokeWeight(borderLength);
        fill(applicationColor);
        rect(475, 550, 250, 259, roundedRadius);
        fill(blackColor);
        text("Weather", 555, 580);
        
        //displaying weather data
        fill(applicationColor);
        strokeWeight(3);
        circle(496, 630, 25);
        fill(blackColor);
        textSize(16);
        text("U", 491, 635);
        
        fill(applicationColor);
        circle(531, 630, 25);
        fill(blackColor);
        textSize(16);
        text("M", 525, 635);
        
        fill(applicationColor);
        circle(566, 630, 25);
        fill(blackColor);
        textSize(16);
        text("T", 562, 635);
        
        fill(applicationColor);
        circle(601, 630, 25);
        fill(blackColor);
        textSize(16);
        text("W", 595, 635);
        
        fill(applicationColor);
        circle(636, 630, 25);
        fill(blackColor);
        textSize(16);
        text("R", 632, 635);
        
        fill(applicationColor);
        circle(671, 630, 25);
        fill(blackColor);
        textSize(16);
        text("F", 667, 635);
        
        fill(applicationColor);
        circle(706, 630, 25);
        fill(blackColor);
        textSize(16);
        text("S", 702, 635);
        
        //filing data
        StringList weatherData;
        String[] highData = new String[7];
        String[] lowData = new String[7];
        weatherData = getWeather();
        
        highData[0] = weatherData.get(0);
        highData[1] = weatherData.get(2);
        highData[2] = weatherData.get(4);
        highData[3] = weatherData.get(6);
        highData[4] = weatherData.get(8);
        highData[5] = weatherData.get(10);
        highData[6] = weatherData.get(12);
        
        lowData[0] = weatherData.get(1);
        lowData[1] = weatherData.get(3);
        lowData[2] = weatherData.get(5);
        lowData[3] = weatherData.get(7);
        lowData[4] = weatherData.get(9);
        lowData[5] = weatherData.get(11);
        lowData[6] = weatherData.get(13);
        
        fill(242, 138, 10);
        textSize(19);
        text(highData[0], 488, 675);
        text(highData[1], 522, 675);
        text(highData[2], 559, 675);
        text(highData[3], 592, 675);
        text(highData[4], 628, 675);
        text(highData[5], 661, 675);
        text(highData[6], 690, 675);
        
        fill(14, 170, 237);
        textSize(19);
        text(lowData[0], 488, 705);
        text(lowData[1], 522, 705);
        text(lowData[2], 559, 705);
        text(lowData[3], 592, 705);
        text(lowData[4], 628, 705);
        text(lowData[5], 661, 705);
        text(lowData[6], 694, 705);
        
        fill(blackColor);
        textSize(14);
        text("Special Notes:\n •30% Chance of Rain\n •Hurricane Warning", 491 ,735);

        
    }
    //health
    if (overHealthApp) {
      fill(hoverColor);
      text("Health", 280, 800);
      fill(hoverColor);
    }
    else {
      fill(applicationColor);
    }
    stroke(blackColor);
    strokeWeight(3);
    rect(iconX+164, iconY, iconWidth, iconLength, roundedRadius);
    image(heartIcon, 412, 844, width/33, height/23);
    if (displayHealthData && powerOn) {
        stroke(blackColor);
        strokeWeight(borderLength);
        fill(applicationColor);
        rect(475, 550, 250, 259, roundedRadius);
        fill(blackColor);
        text("Health", 565, 580);
        
        //display health data
        int numDay = getNumberDayOfTheWeek();
        int yesterdayNumDay;
        StringList weightData = getWeight();
        StringList sleepData = getSleep();
        StringList stepData = getStep();
        
        String todayWeight = weightData.get(numDay);
        String todaySleep = sleepData.get(numDay);
        String todaySteps = stepData.get(numDay);
        
        if (numDay == 6) {
            yesterdayNumDay = 0;
        }
        
        else {
            yesterdayNumDay = numDay - 1;
        }
        
        String yesterdayWeight = weightData.get(yesterdayNumDay);
        String yesterdaySleep = sleepData.get(yesterdayNumDay);
        String yesterdaySteps = stepData.get(yesterdayNumDay);
        
        String weightSign = "";
        String sleepSign = "";
        String stepSign = "";
        
        //computing differences
        int weightDiff = int(todayWeight) - int(yesterdayWeight);
        int sleepDiff = int(todaySleep) - int(yesterdaySleep);
        int stepDiff = int(todaySteps) - int(yesterdaySteps);
        
        
        if (weightDiff > 0) {
          weightSign = "+";
        }
        
        if (sleepDiff > 0) {
          sleepSign = "+";
        }
        
        if (stepDiff > 0) {
          stepSign = "+";
        }
        textSize(20);
        text("Todays Weight: " + todayWeight + "    " + weightSign + weightDiff + " lbs", 485, 620);
        text("Todays Sleep: " + todaySleep + "              " + sleepSign + sleepDiff + " hrs", 485, 660);
        textSize(16);
        text("Todays Steps: " + todaySteps + "         " + stepSign + stepDiff + " Steps", 485, 700);
        
        textSize(15);
        text("  Your On Track to Meeting Your Goals\n                           Great Job!", 485, 740);
    }
    //news
    if (overNewsApp) {
      fill(hoverColor);
      text("News", 280, 800);
      fill(hoverColor);
    }
    else {
      fill(applicationColor);
    }
    stroke(blackColor);
    strokeWeight(3);
    rect(iconX+246, iconY, iconWidth, iconLength, roundedRadius);
    image(newsIcon, 496, 845, width/36, height/26);
    if (displayNewsData && powerOn) {
        stroke(blackColor);
        strokeWeight(borderLength);
        fill(applicationColor);
        rect(475, 550, 250, 259, roundedRadius);
        fill(blackColor);
        text("News", 570, 580);
        
        //displaying news data
        StringList newsData = getNews();
        String todaysDate = getDate();
        
        text(todaysDate + ":", 482, 620);
        text("   •" + newsData.get(0), 480, 660); 
        text("   •" + newsData.get(1), 480, 700); 
        text("   •" + newsData.get(2), 480, 740); 
        text("   •" + newsData.get(3), 480, 780);  
    }
    //lights
    if (overBulbApp) {
      fill(hoverColor);
      text("Lights", 280, 800);
      fill(hoverColor);
    }
    else {
      fill(applicationColor);
    }
    stroke(blackColor);
    strokeWeight(3);
    rect(iconX+332, iconY, iconWidth, iconLength, roundedRadius);
    image(bulbIcon,579, 845, width/33, height/23);
    //window pop up for bulb
    if (displayLightsData && powerOn) {
        stroke(blackColor);
        strokeWeight(borderLength);
        fill(applicationColor);
        rect(475, 550, 250, 259, roundedRadius);
        fill(blackColor);
        text("Lights", 570, 580);
        
        update(mouseX, mouseY);
        //displaying lights functions
        if (overRed) {
            fill(redHover);
        }
        
        else {
            fill(redColor);
        }
        circle(510, 620, 40);
        
        if (overOrange) {
          fill(orangeHover);
        }
        else {
            fill(orangeColor);
        }
        circle(600, 620, 40);
        if (overYellow) {
            fill(yellowHover);
        }
        else {
            fill(yellowColor);
        }
        circle(690, 620, 40);
        
        if (overGreen) {
            fill(greenHover);
        }
        else {
        fill(greenColor);
        }
        circle(510, 675, 40);
        
        if (overBlue) {
            fill(blueHover);
        }
        else {
        fill(blueColor);
        }
        circle(600, 675, 40);
        
        if (overPurple) {
            fill(purpleHover);
        }
        else {
        fill(purpleColor);
        }
        circle(690, 675, 40);
        
        if (overWhite) {
            fill(whiteHover);
        }
        else {
        fill(whiteLedColor);
        }
        circle(510, 730, 40);
        
        if (overWarm) {
            fill(warmHover);
        }
        else {
        fill(warmColor);
        }
        circle(600, 730, 40);
        
        if (overSoft) {
            fill(softHover);
        }
        else {
        fill(softColor);
        }
        circle(690, 730, 40);
        
        if (overOnOff) {
          fill(hoverColor);
        }
        
        else {
          fill(applicationColor);
        }
        rect(525, 760, 150, 30, roundedRadius);
        fill(blackColor);
        textSize(22);
        text("ON/OFF", 565, 782);
    }
    if (overSettingsApp) {
      fill(hoverColor);
      text("Settings", 280, 800);
      fill(hoverColor);
    }
    else {
      fill(applicationColor);
    }
    //settings
    stroke(blackColor);
    strokeWeight(3);
    rect(iconX+414, iconY, iconWidth, iconLength, roundedRadius);
    image(gearIcon, 663, 844, width/33, height/23);
    if (displaySettingsData && powerOn) {
        stroke(blackColor);
        strokeWeight(borderLength);
        fill(applicationColor);
        rect(475, 550, 250, 259, roundedRadius);
        fill(blackColor);
        text("Settings", 555, 580);
        
        //display settings option
        update(mouseX, mouseY);
        displayTodayMessage();
        //time toggle
        if (overTimeToggle) {
            fill(hoverColor);
        }
        else {
            fill(applicationColor);
        }
        strokeWeight(3);
        rect(485, 600, 225, 25, roundedRadius);
        fill(blackColor);
        textSize(18);
        text("Time On/Off", 553, 618);
        
        //date toggle
        if (overDateToggle) {
            fill(hoverColor);
        }
        else {
            fill(applicationColor);
        }
        rect(485, 635, 225, 25, roundedRadius);
        fill(blackColor);
        textSize(18);
        text("Date On/Off", 553, 653);
        
        //weather toggle
        if (overWeatherToggle) {
            fill(hoverColor);
        }
        else {
            fill(applicationColor);
        }
        rect(485, 670, 225, 25, roundedRadius);
        fill(blackColor);
        textSize(18);
        text("Weather On/Off", 544, 688);
        
        //calendar toggle
        if (overCalendarToggle) {
            fill(hoverColor);
        }
        else {
            fill(applicationColor);
        }

        rect(485, 705, 225, 25, roundedRadius);
        fill(blackColor);
        textSize(18);
        text("Calendar On/Off", 537, 723);
        
        //health toggle
        if (overHealthToggle) {
            fill(hoverColor);
        }
        else {
            fill(applicationColor);
        }
        rect(485, 740, 225, 25, roundedRadius);
        fill(blackColor);
        textSize(18);
        text("Health On/Off", 544, 758);
        
        //news toggle
        if (overNewsToggle) {
            fill(hoverColor);
        }
        else {
            fill(applicationColor);
        }
        rect(485, 775, 225, 25, roundedRadius);
        fill(blackColor);
        textSize(18);
        text("News On/Off", 548, 793);
    }
    
    
    
    
  }
  
  //power button
  update(mouseX, mouseY);
  
  if (overPowerButton) {
      fill(255, 255, 255);
      textSize(20);
      text("Power ON/OFF", 1350, 775);
      fill(hoverColor);
  }
  
  else {
      fill(applicationColor);
  }
  stroke(blackColor);
  strokeWeight(borderLength);
  rect(powerButtonX, powerButtonY, powerButtonWidth, powerButtonLength, roundedRadius);
  image(powerIcon, 1391, 843, width/36, height/26);
  
  //power LED
  if (powerOn) {
    stroke(117, 245, 66);
    fill(117, 245, 66);
    circle(1412, 803, 5);
    
  } 
  
  else {
    stroke(212, 19, 25);
    fill(212, 19, 25);
    circle(1412, 803, 5);
  }
  
  //notifications
  if (powerOn) {
      //this is where we will simulate the notifications
      stroke(blackColor, 0.0);
      fill(applicationColor, 0.0);
      rect(notificationWindowX + 65, notificationWindowY, notificationWindowLength - 75, notificationWindowWidth + 35, roundedRadius);
      
      //displaying notification data
      textSize(20);
      fill(blackColor);
      textSize(textSize);
      text("3 New Notifications\n    •Snapchat\n    •Instagram\n    •Twitter", 1265, 110);
  }
  
}


//updates with mouse coordinates
void update(int x, int y) {
  if (overLightBulbButton(ledOnOffX, ledOnOffY, ledOnOffLength, ledOnOffWidth)) {
    overLedButton = true;
  }
  else {
    overLedButton = false;
  }
  if (overMoreApps(moreAppsX, moreAppsY, moreAppsLength, moreAppsWidth)){
     overMoreAppsButton = true;
  }
  else {
    overMoreAppsButton = false;
    displayMoreAppsWindow = false;
  }
  if (overCalendar(iconX, iconY, iconWidth, iconLength)) {
      overCalendarApp = true;
  }
  else {
      overCalendarApp = false;
  }
  
  if(overWeather(iconX+82, iconY, iconWidth, iconLength)) {
      overWeatherApp = true;
  }
  else {
      overWeatherApp = false;
  }
  
  if(overHealth(iconX+164, iconY, iconWidth, iconLength)) {
      overHealthApp = true;
  }
  else {
      overHealthApp = false;
  }
  if (overNews(iconX+246, iconY, iconWidth, iconLength)) {
    overNewsApp = true;
  }
  
  else{
    overNewsApp = false;
  }
  if (overLights(iconX+332, iconY, iconWidth, iconLength)) {
      overBulbApp = true;
  }
  else {
    overBulbApp = false;
  }
  if (overSettings(iconX+414, iconY, iconWidth, iconLength)) {
      overSettingsApp = true;
  }
  else {
    overSettingsApp = false;
  }
  
  //power button 
  if (overPowerButtonApp(powerButtonX, powerButtonY, powerButtonWidth, powerButtonLength)) {
    overPowerButton = true;
  }
  
  else {
    overPowerButton = false;
  }
  
  
  //LED app 
  if (overRedApp(495, 600, 25, 28)) {
      overRed = true;
  }
  
  else {
      overRed = false;
  }
  
  if (overOrangeApp(585, 600, 25, 28)) {
      overOrange = true;
  }
  else {
    overOrange = false;
  }
  
  if (overYellowApp(675, 600, 25, 28)) {
    overYellow = true;
  }
  else {
    overYellow = false;
  }
  
  if (overGreenApp(495, 655, 25, 28)) {
      overGreen = true;
  }
  
  else {
    overGreen = false;
  }
  
  if (overBlueApp(585, 655, 25, 28)) {
    overBlue = true;
  }
  else {
    overBlue = false;
  }
  
  if (overPurpleApp(675, 655, 25, 28)) {
    overPurple = true;
  }
  else {
    overPurple = false;
  }
  
  if (overWhiteApp(495, 710, 25, 28)) {
    overWhite = true;
  }
  else {
    overWhite = false;
  }
  
  if (overWarmApp(585, 710, 25, 28)) {
    overWarm = true;
  }
  else {
    overWarm = false;
  }
  
  if (overSoftApp(675, 710, 25, 28)) {
    overSoft = true;
  }
  
  else {
    overSoft = false;
  }
  
  if (overOnOffApp(525, 760, 150, 30)) {
    overOnOff = true;
  }
  
  else {
    overOnOff = false;
  }
  
  if(settingsOverTime(485, 600, 225, 25)) {
    overTimeToggle = true;
  }
  
  else {
    overTimeToggle = false;
  }
  
  if(settingsOverDate(485, 635, 225, 25)) {
    overDateToggle = true;
  
  }
  
  else {
    overDateToggle = false;
  }
  
  if (settingsOverWeather(485, 670, 225, 25)) {
    overWeatherToggle = true;
  }
  
  else {
    overWeatherToggle = false;
  }
  
  if (settingsOverCalendar(485, 705, 225, 25)) {
    overCalendarToggle = true;
  }
  
  else {
    overCalendarToggle = false;
  }
  
  if(settingsOverHealth(485, 740, 225, 25)) {
    overHealthToggle = true;
  }
  
  else {
    overHealthToggle = false;
  }
  
  if(settingsOverNews(485, 775, 225, 25)) {
    overNewsToggle = true;
  }
  
  else {
    overNewsToggle = false;
  }
  
  
  
}

String getTodayMessage (StringList finalList) {
  String returnString = "";
  
  returnString = returnString + finalList.get(0);
  returnString = returnString + finalList.get(1);
  returnString = returnString + finalList.get(2); 
  returnString = returnString + finalList.get(3);
  returnString = returnString + finalList.get(4);
  returnString = returnString + finalList.get(5);
  
  
  return(returnString);
}

void mousePressed() {
  if (overLedButton) {
    if (turnOnLed == true) {
      turnOnLed = false;
    }
    
    else {
      turnOnLed = true;
    }
  }
  if (overMoreAppsButton) {
    if (displayMoreApps == true) {
        displayMoreApps = false;
        displayMoreAppsWindow = false;
        displayCalendarData = false;
        displayWeatherData = false;
        displayHealthData = false;
        displayNewsData = false;
        displayLightsData = false;
        displaySettingsData = false;
    }
    else {
        displayMoreApps = true;
        displayMoreAppsWindow = true;
    }
  }
  
  
  //application window display
  if (overCalendarApp) {
    if (displayCalendarData == true) {
      displayCalendarData = false;
      displayWeatherData = false;
      displayHealthData = false;
      displayNewsData = false;
      displayLightsData = false;
      displaySettingsData = false;
    }
    
    else {
      displayCalendarData = true;
      displayWeatherData = false;
      displayHealthData = false;
      displayNewsData = false;
      displayLightsData = false;
      displaySettingsData = false;
    }
  }
  if (overWeatherApp) {
    if (displayWeatherData == true) {
      displayCalendarData = false;
      displayWeatherData = false;
      displayHealthData = false;
      displayNewsData = false;
      displayLightsData = false;
      displaySettingsData = false;
    }
    
    else {
      displayCalendarData = false;
      displayWeatherData = true;
      displayHealthData = false;
      displayNewsData = false;
      displayLightsData = false;
      displaySettingsData = false;
    }
  }
  if (overHealthApp) {
    if (displayHealthData == true){
      displayCalendarData = false;
      displayWeatherData = false;
      displayHealthData = false;
      displayNewsData = false;
      displayLightsData = false;
      displaySettingsData = false;
    }
    
    else {
      displayCalendarData = false;
      displayWeatherData = false;
      displayHealthData = true;
      displayNewsData = false;
      displayLightsData = false;
      displaySettingsData = false;
    }
  }
  if(overNewsApp) {
    if (displayNewsData == true) {
      displayCalendarData = false;
      displayWeatherData = false;
      displayHealthData = false;
      displayNewsData = false;
      displayLightsData = false;
      displaySettingsData = false;
    }
    else {
      displayCalendarData = false;
      displayWeatherData = false;
      displayHealthData = false;
      displayNewsData = true;
      displayLightsData = false;
      displaySettingsData = false;
    }
  }
  if (overBulbApp) {
    if (displayLightsData == true) {
      displayCalendarData = false;
      displayWeatherData = false;
      displayHealthData = false;
      displayNewsData = false;
      displayLightsData = false;
      displaySettingsData = false;
    }
    else {
      displayCalendarData = false;
      displayWeatherData = false;
      displayHealthData = false;
      displayNewsData = false;
      displayLightsData = true;
      displaySettingsData = false;
    }
  }
  if(overSettingsApp) {
    if (displaySettingsData == true) {
      displayCalendarData = false;
      displayWeatherData = false;
      displayHealthData = false;
      displayNewsData = false;
      displayLightsData = false;
      displaySettingsData = false;
    }
    else {
      displayCalendarData = false;
      displayWeatherData = false;
      displayHealthData = false;
      displayNewsData = false;
      displayLightsData = false;
      displaySettingsData = true;
    }
  }
  
  
  if (overRed && displayLightsData) {
      redOn = true;
      orangeOn = false;
      yellowOn = false;
      greenOn = false;
      blueOn = false;
      purpleOn = false;
      whiteOn = false;
      warmOn  = false;
      softOn = false;
      turnOnLed = true;
  }
  
  if (overOrange && displayLightsData) {
      redOn = false;
      orangeOn = true;
      yellowOn = false;
      greenOn = false;
      blueOn = false;
      purpleOn = false;
      whiteOn = false;
      warmOn  = false;
      softOn = false;
      turnOnLed = true;
  }
  
  if (overYellow && displayLightsData) {
      redOn = false;
      orangeOn = false;
      yellowOn = true;
      greenOn = false;
      blueOn = false;
      purpleOn = false;
      whiteOn = false;
      warmOn  = false;
      softOn = false;
      turnOnLed = true;
  }
  
  if (overGreen && displayLightsData) {
      redOn = false;
      orangeOn = false;
      yellowOn = false;
      greenOn = true;
      blueOn = false;
      purpleOn = false;
      whiteOn = false;
      warmOn  = false;
      softOn = false;
      greenOn = true;
      turnOnLed = true;
  }
  
  if (overBlue && displayLightsData) {
      redOn = false;
      orangeOn = false;
      yellowOn = false;
      greenOn = false;
      blueOn = true;
      purpleOn = false;
      whiteOn = false;
      warmOn  = false;
      softOn = false;
      blueOn = true;
      turnOnLed = true;
  }
  
  if (overPurple && displayLightsData) {
      redOn = false;
      orangeOn = false;
      yellowOn = false;
      greenOn = false;
      blueOn = false;
      purpleOn = true;
      whiteOn = false;
      warmOn  = false;
      softOn = false;
      turnOnLed = true;
  }
  
  if (overWhite && displayLightsData) {
      redOn = false;
      orangeOn = false;
      yellowOn = false;
      greenOn = false;
      blueOn = false;
      purpleOn = false;
      whiteOn = true;
      warmOn  = false;
      softOn = false;
      turnOnLed = true;
  }
  
  if (overWarm && displayLightsData) {
      redOn = false;
      orangeOn = false;
      yellowOn = false;
      greenOn = false;
      blueOn = false;
      purpleOn = false;
      whiteOn = false;
      warmOn  = true;
      softOn = false;
    turnOnLed = true;
  }
  
  if (overSoft && displayLightsData) {
      redOn = false;
      orangeOn = false;
      yellowOn = false;
      greenOn = false;
      blueOn = false;
      purpleOn = false;
      whiteOn = false;
      warmOn  = false;
      softOn = true;
    turnOnLed = true;
  } 
  
  if (overOnOff && displayLightsData) {
    if (turnOnLed == true) {
      turnOnLed = false;
    }
    
    else {
      turnOnLed = true;
    }
  }
  
  
  //settings app function
  
  if (overTimeToggle && displaySettingsData) {
    if (displayTime == false) {
      displayTime = true;
    }
    else {
      displayTime = false;
    }
  }
  
  if (overDateToggle && displaySettingsData) {
    if (displayDate == false) {
      displayDate = true;
    }
    else {
      displayDate = false;
    }
  }
  
  if (overWeatherToggle && displaySettingsData) {
    if (displayWeather == false) {
      displayWeather = true;
    }
    else {
      displayWeather = false;
    }
  }
  
  if (overHealthToggle && displaySettingsData) {
    if (displayHealth == false) {
      displayHealth = true;
    }
    else {
      displayHealth = false;
    }
  }
  
  if (overNewsToggle && displaySettingsData) {
    if (displayNews == false) {
        displayNews = true;
    }
    
    else {
      displayNews = false;
    }
  }
  
  if (overCalendarToggle && displaySettingsData) {
    if (displayCalandar == false) {
      displayCalandar = true;
    }
    else {
      displayCalandar = false;
    }
  }
  
  if (overPowerButton) {
    if (continueToDisplay == true) {
      continueToDisplay = false;
      powerOn = false;
    }
    
    else {
      continueToDisplay = true;
      powerOn = true;
    }
    
      
  }
  
  


  
  
}

boolean overPowerButtonApp (int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && mouseY >= y && mouseY <= y+height) {
    return true;
  } 
  else {
    return false;
  }
}

//settings app
boolean settingsOverTime (int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && mouseY >= y && mouseY <= y+height) {
    return true;
  } 
  else {
    return false;
  }
}

boolean settingsOverWeather (int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && mouseY >= y && mouseY <= y+height) {
    return true;
  } 
  else {
    return false;
  }
}

boolean settingsOverDate (int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && mouseY >= y && mouseY <= y+height) {
    return true;
  } 
  else {
    return false;
  }
}

boolean settingsOverHealth (int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && mouseY >= y && mouseY <= y+height) {
    return true;
  } 
  else {
    return false;
  }
}



boolean settingsOverCalendar (int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && mouseY >= y && mouseY <= y+height) {
    return true;
  } 
  else {
    return false;
  }
}

boolean settingsOverNews (int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && mouseY >= y && mouseY <= y+height) {
    return true;
  } 
  else {
    return false;
  }
}


//LED app
boolean overOnOffApp (int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && mouseY >= y && mouseY <= y+height) {
    return true;
  } 
  else {
    return false;
  }
}

boolean overRedApp (int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && mouseY >= y && mouseY <= y+height) {
    return true;
  } 
  else {
    return false;
  }
}

boolean overOrangeApp (int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && mouseY >= y && mouseY <= y+height) {
    return true;
  } 
  else {
    return false;
  }
}

boolean overYellowApp (int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && mouseY >= y && mouseY <= y+height) {
    return true;
  } 
  else {
    return false;
  }
}

boolean overGreenApp (int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && mouseY >= y && mouseY <= y+height) {
    return true;
  } 
  else {
    return false;
  }
}

boolean overBlueApp (int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && mouseY >= y && mouseY <= y+height) {
    return true;
  } 
  else {
    return false;
  }
}

boolean overPurpleApp (int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && mouseY >= y && mouseY <= y+height) {
    return true;
  } 
  else {
    return false;
  }
}

boolean overWhiteApp (int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && mouseY >= y && mouseY <= y+height) {
    return true;
  } 
  else {
    return false;
  }
}

boolean overWarmApp (int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && mouseY >= y && mouseY <= y+height) {
    return true;
  } 
  else {
    return false;
  }
}

boolean overSoftApp (int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && mouseY >= y && mouseY <= y+height) {
    return true;
  } 
  else {
    return false;
  }
}


//sees if over the turn led's on or off button
boolean overLightBulbButton (int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && mouseY >= y && mouseY <= y+height) {
    return true;
  } 
  else {
    return false;
  }
}

//sees if over the more Apps mutton
boolean overMoreApps (int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && mouseY >= y && mouseY <= y+height) {
    return true;
  } 
  else {
    return false;
  }
}

//sees if app is over the apps
boolean overCalendar (int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && mouseY >= y && mouseY <= y+height) {
    return true;
  } 
  else {
    return false;
  }
}

boolean overWeather (int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && mouseY >= y && mouseY <= y+height) {
    return true;
  } 
  else {
    return false;
  }
}

boolean overHealth (int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && mouseY >= y && mouseY <= y+height) {
    return true;
  } 
  else {
    return false;
  }
}

boolean overNews (int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && mouseY >= y && mouseY <= y+height) {
    return true;
  } 
  else {
    return false;
  }
}

boolean overLights (int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && mouseY >= y && mouseY <= y+height) {
    return true;
  } 
  else {
    return false;
  }
}

boolean overSettings (int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && mouseY >= y && mouseY <= y+height) {
    return true;
  } 
  else {
    return false;
  }
}


//gets time of day
String getTime() {
  //logic to display correct time
  int hourVal = hour();
  int minuteVal = minute();
  String timeOfDay = "AM";
  
   if (hourVal > 12) {
      hourVal = hourVal - 12;
      timeOfDay = "PM";
    }
    
    if (hourVal < 10) {
      cleanedHourVal = "0" + str(hourVal);
    }
    
    else {
      cleanedHourVal = str(hourVal);
    }
    
    if (minuteVal < 10) {
      cleanedMinuteVal = "0" + str(minuteVal);
    }
    
    else {
      cleanedMinuteVal = str(minuteVal);
    }
    
    return(cleanedHourVal + ":" + cleanedMinuteVal + " " + timeOfDay);
}

//determines LED color 
color getLedColor() {
  if (redOn) {
    return(redColor);
  }
  
  if (orangeOn) {
    return(orangeColor);
  }
  
  if (yellowOn) {
    return(yellowColor);
  }
  
  if (greenOn) {
  return(greenColor);
  }
  
  if (blueOn) {
    return(blueColor);
  }
  
  if (purpleOn) {
    return(purpleColor);
  }
  
  if (whiteOn) {
    return(whiteLedColor);
  }
  
  if (warmOn) {
    return(warmColor);
  }
  
  if (softOn) {
    return(softColor);
  }
  
  else {
    return(blackColor);
  }
}

//gets todays date
String getDate() {
  int dayVal = day();
  int monthVal = month();
  int yearVal = year();
  
  //getting month string
    if (monthVal == 1){
      cleanedMonthVal = "January";
    }
    
    else if (monthVal == 2){
      cleanedMonthVal = "Frebruary";
    } 
    
    else if (monthVal == 3){
      cleanedMonthVal = "March";
    } 
    
    else if (monthVal == 4){
      cleanedMonthVal = "April";
    } 
    
    else if (monthVal == 5){
      cleanedMonthVal = "May";
    } 
    
    else if (monthVal == 6){
      cleanedMonthVal = "June";
    } 
    
    else if (monthVal == 7){
      cleanedMonthVal = "July";
    } 
    
    else if (monthVal == 8){
      cleanedMonthVal = "August";
    } 
    
    else if (monthVal == 9){
      cleanedMonthVal = "September";
    } 
    
    else if (monthVal == 10){
      cleanedMonthVal = "October";
    } 
    
    else if (monthVal == 11){
      cleanedMonthVal = "November";
    } 
    
    else if (monthVal == 12){
      cleanedMonthVal = "December";
    } 
    
    return(cleanedMonthVal + " " + str(dayVal)); 
}

int getNumberDayOfTheWeek () {
  Calendar c;
  int dayOfTheWeek;
  c = Calendar.getInstance();
  dayOfTheWeek = c.get(Calendar.DAY_OF_WEEK);
  
  return(dayOfTheWeek);
}

//gets day of the week
String getDayOfTheWeek () {
  Calendar c;
  int dayOfTheWeek;
  c = Calendar.getInstance();
  dayOfTheWeek = c.get(Calendar.DAY_OF_WEEK);
  
  if (dayOfTheWeek == 1) {
    return("Sunday");
  } 
  
  if (dayOfTheWeek == 2) {
    return("Monday");
  }
  
    if (dayOfTheWeek == 3) {
    return("Tuesday");
  } 
  
    if (dayOfTheWeek == 4) {
    return("Wednesday");
  } 
  
    if (dayOfTheWeek == 5) {
    return("Thursday");
  } 
  
  if (dayOfTheWeek == 6) {
    return("Friday");
  } 
  
  if (dayOfTheWeek == 7) {
    return("Saturday");
  } 
  
  else {
    return("");
  }
  
}

//gets weather data
StringList getWeather () {
  //data structires to get data from csv file
  String weatherData = "";
  StringList weatherArray = new StringList();

  for (TableRow row : table.rows()) {
    weatherData = row.getString("Weather");
    weatherArray.append(weatherData);
  }
  return(weatherArray);

}


//gets weight health data
StringList getWeight() {
  String weightData = "";
  StringList weightArray = new StringList();

  for (TableRow row : table.rows()) {
    weightData = row.getString("Weight");
    weightArray.append(weightData);
  }
  return(weightArray);
}

//gets sleep health data
StringList getSleep() {
  String sleepData = "";
  StringList sleepArray = new StringList();

  for (TableRow row : table.rows()) {
    sleepData = row.getString("Sleep");
    sleepArray.append(sleepData);
  }
  return(sleepArray);
}

//gets step health data
StringList getStep() {
  String stepData = "";
  StringList stepArray = new StringList();

  for (TableRow row : table.rows()) {
    stepData = row.getString("Steps");
    stepArray.append(stepData);
  }
  return(stepArray);
}

//gets step health data
StringList getCalendar() {
  String calendarData = "";
  StringList calendarArray = new StringList();

  for (TableRow row : table.rows()) {
    calendarData = row.getString("Calandar");
    calendarArray.append(calendarData);
  }
  return(calendarArray);
}

//gets step health data
StringList getNews() {
  String newsData = "";
  StringList newsArray = new StringList();

  for (TableRow row : table.rows()) {
    newsData = row.getString("News");
    newsArray.append(newsData);
  }
  return(newsArray);
}

StringList getNotifications () {
  String notificationData = "";
  StringList notificationArray = new StringList();

  for (TableRow row : table.rows()) {
    notificationData = row.getString("Notifications");
    notificationArray.append(notificationData);
  }
  return(notificationArray);
}


StringList displayTodayMessage() {
  int numWeek;
  numWeek = getNumberDayOfTheWeek();
  int remainingCalendarEvents = 0;
  int remainingNewsEvents = 0;
  String timeVal;
  String dateVal;
  String weekDayVal;
  StringList weatherArray;
  StringList weightArray;
  StringList sleepArray;
  StringList stepsArray;
  StringList calendarArray;
  StringList newsArray;
  String todayWeatherLow;
  String todayWeatherHigh;
  String todayWeather;
  String todayWeatherNum = "";
  String todayWeight;
  String todaySteps;
  String todaySleep;
  String calendarValue;
  String newsValue;
  
  
  StringList todayViewList = new StringList(7); 
  
  int len;
  
  //settings edit variables
  
  if (displayTime) {
    timeVal = getTime();
    tempTodayViewText = tempTodayViewText + timeVal + "\n";
    todayViewList.set(0, timeVal + "\n");
  }
  
  if (displayTime == false) {
    todayViewList.set(0, "");
  }
  
  if (displayDate) {
    dateVal = getDate();
    weekDayVal = getDayOfTheWeek();
    tempTodayViewText = tempTodayViewText + weekDayVal + ", " + dateVal + "\n";
    todayViewList.set(1, weekDayVal + ", " + dateVal + "\n");
  }
  
  if (displayDate == false) {
    todayViewList.set(1, "");
  }
  
  if (displayWeather) {
    weatherArray = getWeather();
    todayWeatherLow = weatherArray.get((numWeek * 2) - 1);
    todayWeatherHigh = weatherArray.get((numWeek * 2));
    tempTodayViewText = tempTodayViewText + todayWeatherHigh + "°, Partly Cloudy\n";
    todayViewList.set(2, todayWeatherHigh + "°, Partly Cloudy\n");
  }
  if (displayWeather == false) {
    todayViewList.set(2, "");
  }
  
  if (displayHealth) {
    weightArray = getWeight();
    sleepArray = getSleep();
    stepsArray = getStep();
    todayWeight = weightArray.get(numWeek);
    todaySteps = stepsArray.get(numWeek);
    todaySleep = sleepArray.get(numWeek);
    tempTodayViewText = tempTodayViewText + "\nTodays Health Values:\n"  + "    - Weight: " + todayWeight + " lbs\n" + "    - Sleep: " + todaySleep + " hours\n" + "    - Steps: " + todaySteps + "\n";
    todayViewList.set(4, "\nTodays Health Values:\n"  + "    - Weight: " + todayWeight + " lbs\n" + "    - Sleep: " + todaySleep + " hours\n" + "    - Steps: " + todaySteps + "\n");
  }
  
  if (displayHealth == false) {
    todayViewList.set(4, "");
  }
  
  if (displayCalandar) {
    calendarArray = getCalendar();
    calendarArray.remove(4);
    calendarArray.remove(5);
    calendarArray.remove(6);
    calendarArray.remove(7);
    calendarArray.remove(8);
    calendarArray.remove(4);
    calendarArray.remove(5);
    calendarArray.remove(6);
    calendarArray.remove(4);
    calendarArray.remove(4);
    //calendarArray.shuffle();
    calendarValue = calendarArray.get(0);
    remainingCalendarEvents = calendarArray.size() - 1;
    tempTodayViewText = tempTodayViewText + "\nYour Calendar:\n" + "    -" + calendarValue + "\n    " +  remainingCalendarEvents + " Remaining Events\n";
    todayViewList.set(3, "\nYour Calendar:\n" + "    -" + calendarValue + "\n    " +  remainingCalendarEvents + " Remaining Events\n");
  }
  
  if (displayCalandar == false) {
    todayViewList.set(3, "");
  }
  
  if (displayNews) {
    newsArray = getNews();
    newsArray.remove(4);
    newsArray.remove(5);
    newsArray.remove(6);
    newsArray.remove(7);
    newsArray.remove(8);
    newsArray.remove(4);
    newsArray.remove(5);
    newsArray.remove(6);
    newsArray.remove(4);
    newsArray.remove(4);
    //newsArray.shuffle();
    newsValue = newsArray.get(0);
    remainingNewsEvents = newsArray.size() - 1;
    tempTodayViewText = tempTodayViewText + "\nDaily News:\n" + "    -" + newsValue + "\n    " + remainingNewsEvents + " Remaining Events\n";
    todayViewList.set(5, "\nDaily News:\n" + "    -" + newsValue + "\n    " + remainingNewsEvents + " Remaining Events\n");
  }
  
  if (displayNews == false) {
      todayViewList.set(5, "");
  }
  
  return(todayViewList);
}
