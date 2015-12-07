import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
import ddf.minim.*;

Minim minim;

color[] beach = {#D9C6B0, #314650, #2D4761, #45718C, #B6E1F2};
color[] palette = beach;

color[] dessert = {#9F9694, #791F33, #BA3D49, #F1E6D4, #E2E1DC};
color[] palette2 = dessert;

ArrayList<West> westArray = new ArrayList<West>();
String[] lines;

int counter = 0;
int drawcounter = 0;
int textcounter = 0;

int s = 50;

Audio audio;

void setup()
{
  size(500,500);
  minim = new Minim(this);
  
  audio = new Audio();
}

void menu()
{
  background(0);
  
  String txt = "Welcome to my program";
  String txt1 = "Press 1-3 to view graphs and Spacebar to return to the menu.";
  text(txt, height/5, width/5, 400,300);
  text(txt1,height/5,width/3, 400,300);
  
}

void loadData1()
{
  //loads data to a string array
  String[] lines = loadStrings("compensation.csv");
  //For loop for filling the global ArrayList
  for (int i=0; i<lines.length; i++)
  {
    //make new element for DublinWest class
    West westElement = new West(lines[i]);
    //Add this element to the ArrayList called westArray
    westArray.add(westElement);
  }
}

void loadData2()
{
  //loads data to a string array
  String[] lines = loadStrings("selfemployed.csv");

  //For loop for filling the global ArrayList
  for (int i=0; i<lines.length; i++)
  {
    //make new element for DublinWest class
    West westElement = new West(lines[i]);
    //Add this element to the ArrayList called westArray
    westArray.add(westElement);
  }
}

void loadData3()
{
  //loads data to a string array
  String[] lines = loadStrings("disposable_income.csv");

  //For loop for filling the global ArrayList
  for (int i=0; i<lines.length; i++)
  {
    //make new element for DublinWest class
    West westElement = new West(lines[i]);
    //Add this element to the ArrayList called westArray
    westArray.add(westElement);
  }
}

void keyPressed()
{
  if(key ==' ')
  {
    counter = 0;
    drawcounter = 0;
    textcounter = 0;
    //clearing the arraylist
    westArray.clear();
  }
  
  if(key == 'a')
  {
    westArray.clear();
    counter = 1;
    textcounter = 1;
  }
  
  if(key == 's')
  {
    westArray.clear();
    counter = 2;
    textcounter = 2;
  }
  
  if(key == 'd')
  {
    westArray.clear();
    counter = 3;
    textcounter = 3;
  }
  
   p1 = int(random(1, 5));
  p2 = int(random(1, 5));
  
  int choice = key;
  switch(choice){
    case 49:
      palette = rainbow;
      break;
    case 50:
      palette = chemistry;
      break;
    case 51:
      palette = kitties;
      break;
    case 52:
      palette = beach;
      break;
    case 53:
      palette = cottage;
      break;
    case 54:
      palette = minard;
      break;
  }
  
}

void draw()
{
  //frameRate(5);
  smooth();
  strokeWeight(5);
  noFill();
  
  if(counter == 0);
  {
    menu();
  }
  
  if(counter == 1)
  {
    loadData1();
    counter = 5;
    drawcounter = 1;
    audio.audio();
  }
  
  if(counter == 2)
  {
    loadData2();
    counter = 5;
    drawcounter = 1;
    audio.audio();
  }
  
  if(counter == 3)
  {
    loadData3();
    counter = 5;
    drawcounter = 1;
    audio.audio();
  }
  
  if(drawcounter == 1)
  {
    drawBackground3();
    drawAxis(50,10,10,30000);
    drawTrendLineGraph();
    
  }
   
}

void drawBackground1()
{
  noStroke();
  
    
  for(int x = 0; x < width; x += s)
  {
    for(int y = 0; y < height; y += s)
    {
      fill(palette[int(random(1, 5))]);
      rect(x, y, s, s);
    }
  }
  fill(palette[int(random(1, 5))]);
  int x = int(random(width/s))*s;
  int y = int(random(height/s))*s;
  rect(x, y, s, s);
}

void drawBackground2()
{
  background(#FFFFCD);
  float x = random(width);
  float y = random(height);
  float d = random(30, 300);
  stroke(dessert[int(random(1, 5))]);
  ellipse(x, y, d, d);
}


color[] rainbow   = {#FFFFCD, #CC5C54, #F69162, #85A562, #7AB5DB};
color[] chemistry = {#0C2550, #A3D0C1, #FDF6DD, #FEE406, #F4651C};
color[] kitties   = {#302F2F, #74AD92, #F07F47, #FFAA42, #FFE224};
color[] cottage   = {#C3CCC8, #442412, #475D1C, #859356, #B9961C};
color[] minard    = {#666666, #607F9C, #E9CCAE, #FFFFF3, #D01312};
color[] palette3   = minard;

int choice;
int p1 = 1;
int p2 = 2;

float x;
float y;
float d = 100;
float b = 10;

void drawBackground3()
{
  x = width/2;
  y = height/2;
  background(palette3[0]);
  fill(palette3[p1]);
  stroke(palette3[p2]);
  strokeWeight(b);
  ellipse(x, y, d, d);
  
  if(mouseX > width/2){
    d += .5;
  } else {
    d -= .5;
  }
  
  b = (mouseY > (height/2)) ? b + .1 : b - .1;
  b = constrain(b, 0, 50);
}

void drawAxis(float border, int horizIntervals, int verticalIntervals, int vertDataRange)
{
  stroke(255,255,0);
  //draw horizontal axis
  line(border, height - border, width - border, height - border);

  // Draw the vertical axis
  line(border, border, border, height - border);

  float windowRange = (width - (border * 2.0f));  
  float tickSize = border * 0.1f;

  for (int i = 0; i <= horizIntervals; i ++)
  {   
    // Draw the ticks
    float x = map(i, 0, horizIntervals, border, border + windowRange);
    line(x, height - (border - tickSize)
      , x, (height - border));  

    //vertical ticks and name
    textAlign(CENTER, CENTER);   
    float textY = height - (border * 0.5f); 
    //text from 2000 - 2013
    text((int) map(i, 0, horizIntervals, 2000, 2013), x, textY);
  }

  for (int i = 0; i <= verticalIntervals; i ++)
  {
    float y = map(i, 0, verticalIntervals, height - border, border);
    line(border - tickSize, y, border, y);
    float hAxisLabel = map(i, 0, verticalIntervals, 0, vertDataRange);

    textAlign(RIGHT, CENTER);  
    text((int)hAxisLabel, border - (tickSize * 2.0f), y);
  }
}

void drawTrendLineGraph( )
{
  float border = width * 0.1f;
  
  //Print the text

  textAlign(CENTER, CENTER);
  float textY = (border * 0.5f);
    
  if ( textcounter == 1)
  {
   text(" Compensation for Employees, e.g. Wages, Salaries, Benefits in Kind etc.", width * 0.5f, textY);
  }
  
  if ( textcounter == 2)
  {
   text("Salary of Self Employed", width * 0.5f, textY);
  }
  
  if ( textcounter == 3)
  {
   text("Total Disposable Income per person", width * 0.5f, textY);
  }

  float windowRange = (width - (border * 2.0f));
  float lineWidth = windowRange / (float) (westArray.size() - 1);

  stroke(255,0,0);
  fill(255);

  for (int i = 1; i < westArray.size(); i++)
  {
    float x1 = map(i-1, 0, westArray.size()-1, border, border+windowRange);
    float x2 = map(i, 0, westArray.size()-1, border, border+windowRange);
    /*remember when you gonna use the map function you have to get the min value and map into somewhere on the screen 
     example border which is 50 and  get the max value map it onto another place onto the screen windowsRange = 450*/

    float y1 = map(westArray.get(i-1).west, 0, 30000, height - border, ( height - border)  - windowRange);
    float y2 = map(westArray.get(i).west, 0, 30000, height - border, (height - border) - windowRange);
    stroke(0,255,0);
    line(x1, y1, x2, y2);
    
    if(mouseX >=x1 && mouseX <=x2)
    {
      stroke(255,0,0);
      fill(255,0,0);
      ellipse(x1,y1,5,5);
      fill(255);
      text("West Region Values(in millions):  "+ westArray.get(i-1).west,x1+10,y1);
    }
    
    
  } 

  for (int i = 1; i < westArray.size(); i++)
  {
    
    float x1 = map(i-1, 0, westArray.size()-1, border, border+windowRange);
    float x2 = map(i, 0, westArray.size()-1, border, border+windowRange);
    /*remember when you gonna use the map function you have to get the min value and map into somewhere on the screen 
     example border which is 50 and  get the max value map it onto another place onto the screen windowsRange = 450*/

    float y1 = map(westArray.get(i-1).dublin, 0, 30000, height - border, ( height - border)  - windowRange);
    float y2 = map(westArray.get(i).dublin, 0, 30000, height - border, (height - border) - windowRange);
    stroke(0,0,255);
    line(x1, y1, x2, y2);
    
    if(mouseX >=x1 && mouseX <=x2)
    {
      stroke(255,0,0);
      fill(255,0,0);
      ellipse(x1,y1,5,5);
      fill(255);
      text("Dublin Region Values (in millions) :  "+ westArray.get(i-1).dublin,x1+10,y1);
    }
  }
}