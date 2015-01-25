import processing.serial.*;

class Window                                                                                                                                                              //class Window
{
  // Properties
  float size_X; // width of window
  float size_Y; // height of window
  float pos_X; // position of window from left
  float pos_Y; // position of window from top
  int[] data;
  
  
  
  // Constructor
  Window(int layoutPosition)
  {
    size_X = (width / numWindowsPerRow) - windowSpacing; // sets the width of the window to evenly space it to allow 'numWindowsPerRow' to fit smoothly
    size_Y = ((height - 100) / numWindowsPerColumn) - windowSpacing; // sets the height of the window to evenly space it to allow 'numWindowsPerColumn' to fit smoothly while allowing 100px for buttons at the bottom
    data = new int[int(size_X)];
    for(int i = 0; i < int(size_X); i++)
    {
      data[i] = 0;
    }
    for(int rowNumber = 1; rowNumber <= numWindowsPerColumn; rowNumber++) // loop determines window's position on screen based on the 'layoutPosition' and 'numWindowsPerColumn' variables
    {
      if(layoutPosition <=  rowNumber * numWindowsPerRow)
      {
        pos_X = borderSpacing + ((layoutPosition - (numWindowsPerRow * (rowNumber - 1) + 1)) * (size_X + windowSpacing));
        pos_Y = borderSpacing + ((windowSpacing + size_Y) * (rowNumber - 1));
        break;
      }
    }
  }
  // Functions
  void show() // function for drawing window to screen
  {
    fill(color(255,255,255)); // chooses the color white for the window background
    rect(pos_X, pos_Y, size_X, size_Y); // draws the window background as a rectangle
    for(int i = 0; i < (int(size_X) - 1); i++)
    {
      stroke(0);
      line((pos_X + i),(pos_Y + size_Y - data[i]),(pos_X + i + 1),(pos_Y + size_Y - data[i + 1]));
    }
  }
}                                                                                                                                                                          //class Window
//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
class Button                                                                                                                                                               //class Button
{
  //properties
  String label;
  float size_X;
  float size_Y;
  float pos_X;
  float pos_Y;
  Boolean disabled;
  
  
  
  //constructor
  Button(String Text, int layoutPosition)
  {
    size_X = (width / 9) - 20;
    size_Y = 30;
    if(layoutPosition < 10)
    {
      pos_X = 10 + ((layoutPosition - 1) * (size_X + 20));
      pos_Y = (height - 90);
    }
    if(layoutPosition > 9)
    {
      pos_X = 10 + ((layoutPosition - 10) * (size_X + 20));
      pos_Y = (height - 40);
    }
    label = Text;
    disabled = false;
  }
  //functions
  void show()
  {
    fill(color(255,255,255));
    rect(pos_X, pos_Y, size_X, size_Y);
    fill(color(0,0,0));
    if(disabled) fill(color(128,128,128));
    textAlign(CENTER, CENTER);
    textSize(14);
    text(label, (pos_X +(size_X / 2)), (pos_Y + (size_Y / 2)));
  }
}                                                                                                                                                                         // class Button
//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  int numWindows = 2;                                                                                                                                              
  final int numButtons = 18;
  int numWindowsPerRow = 2;
  int numWindowsPerColumn = 1;
  final int windowSpacing = 20;
  final int borderSpacing = 10;
  final String[] buttonLabel = { "button1", "button2" , "button3" , "button4" , "button5" , "button6" , "button7" , "button8" , "button9", 
                              "button10", "button11", "button12", "button13", "button14", "button15", "button16", "button17", "button18" };
  Window[] window = new Window[numWindows];
  Button[] button = new Button[numButtons];
  Serial input = new Serial(this, Serial.list()[0], 9600);
  String dataString = null;
  void setup()                                                                                                                                                              // function setup()
{
  size(1200, 600);

  for(int i = 0; i < numWindows; i++)
  {
    window[i] = new Window(i + 1);
  }
  for(int i = 0; i < numButtons; i++)
  {
    button[i] = new Button(buttonLabel[i], i + 1);
  }
}                                                                                                                                                                        // function setup()
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
void draw()                                                                                                                                                              // function draw()
{
  
  /*for(int i = 0; i < (window[0].size_X - 1); i++)
  {
    window[0].data[i] = window[0].data[i+1];
  }
  window[0].data[int(window[0].size_X - 1)] = input.read();
  println(window[0].data[int(window[0].size_X - 1)]);  */
  /*byte[] inBuffer = new byte[5];
  if (input.available() > 0)
  {
    for(int i = 0; i < (window[0].size_X - 1); i++)
    {
      window[0].data[i] = window[0].data[i+1];
    }
    inBuffer = input.readBytes();
    input.readBytes(inBuffer);
    if(inBuffer != null)
    {
      String myString = new String(inBuffer);
      window[0].data[int(window[0].size_X - 1)] = int(myString);
      button[0].label = myString;
      println(window[0].data[int(window[0].size_X - 1)]);
    }
  }*/
  /*int inBuffer;
  while (input.available() > 0)
  {
    for(int i = 0; i < (window[0].size_X - 1); i++)
    {
      window[0].data[i] = window[0].data[i+1];
    }
    inBuffer = input.read();
    window[0].data[int(window[0].size_X - 1)] = inBuffer;
  }*/
  
  background(0);
  for(int i = 0; i < numWindows; i++)
  {
    window[i].show();
  }
  for(int i = 0; i < numButtons; i++)
  {
    button[i].show();
  }  
}                                                                                                                                                                    // function draw()
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
void mouseClicked()                                                                                                                                                  // function mouseClicked()
{
  int windowClicked = -1;
  int buttonClicked = -1;
  for(int i = 0; i < numWindows; i++)
  {
    if((mouseY >= (window[i].pos_Y)) && (mouseY <= (window[i].pos_Y + window[i].size_Y)) && (mouseX >= window[i].pos_X) && (mouseX <= (window[i].pos_X + window[i].size_X))) windowClicked = i;
    if(windowClicked >= 0)
    {
      button[i].label = "Window Clicked";
      windowClicked = -1;
    }
  }
  for(int i = 0; i < numButtons; i++)
  {
    if((mouseY >= (button[i].pos_Y)) && (mouseY <= (button[i].pos_Y + button[i].size_Y)) && (mouseX >= button[i].pos_X) && (mouseX <= (button[i].pos_X + button[i].size_X))) buttonClicked = i;
    if(buttonClicked >= 0)
    {
      button[i].label = "I feel violated..";
      buttonClicked = -1;
    }
  }
}
