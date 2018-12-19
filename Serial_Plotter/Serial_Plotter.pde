import processing.serial.*;

/*********************************************************
* Variables
**********************************************************/
int numWindows = 2;
final int numButtons = 18;
int numWindowsPerRow = 2;
int numWindowsPerColumn = 1;
final int windowSpacing = 20;
final int borderSpacing = 10;
final String[] buttonLabel = { "Record", "Play" , "button3" , "button4" , "button5" , "button6" , "button7" , "button8" , "button9", 
                              "button10", "button11", "button12", "button13", "button14", "button15", "button16", "button17", "button18" };
Window[] window = new Window[numWindows];
Button[] button = new Button[numButtons];
Serial input = new Serial(this, Serial.list()[1], 921600);
OutputStream fileOutput;
InputStream fileInput;
int timesize;
boolean save = false;
boolean play = false;

/*********************************************************
* Setup function
* INFO: Ran once on startup of application
**********************************************************/
void setup()
{
  size(1200, 600);
  fileInput = createInput("output.txt");
  fileOutput = createOutput("output.txt");
  for(int i = 0; i < numWindows; i++)
  {
    window[i] = new Window(i + 1);
  }
  for(int i = 0; i < numButtons; i++)
  {
    button[i] = new Button(buttonLabel[i], i + 1);
  }
}

/*********************************************************
* Draw function
* INFO: Ran continuously to allow for updating the screen
**********************************************************/
void draw()
{
  if(input.available() > 0)
  {
    for(int i = (window[0].size_X - 1); i > 0; i--)
    {
      window[0].data[i] = window[0].data[i-1];
      window[0].timestamp[i] = window[0].timestamp[i-1];
    }
    timesize = input.read();
    window[0].timestamp[0] = 0;
    for(int i = 0; i < timesize; i++)
    {
      window[0].timestamp[0] = window[0].timestamp[0] + input.read();
    }
    //println(timesize);
    //println(window[0].timestamp[0]);
    //println(window[0].data[0]);
    window[0].data[0] = input.read();
    if(save)
    {
      try
      {
        fileOutput.write(timesize);
        fileOutput.write(window[0].timestamp[0]);
        fileOutput.write(window[0].data[0]);
      }
      catch(IOException e)
      {
        e.printStackTrace();
      }
    }
    if(play)
    {
      for(int i = (window[1].size_X - 1); i > 0; i--)
      {
        window[1].data[i] = window[1].data[i-1];
        window[1].timestamp[i] = window[1].timestamp[i-1];
      }
      try
      {
        timesize = fileInput.read();
      }
      catch(IOException e)
      {
        e.printStackTrace();
      }
      window[1].timestamp[0] = 0;
      for(int i = 0; i < timesize; i++)
      {
        try
        {
          window[1].timestamp[0] = window[1].timestamp[0] + fileInput.read();
        }
        catch(IOException e)
        {
          e.printStackTrace();
        }
      }  
      try
      {
        window[1].data[0] = fileInput.read();
      }
      catch(IOException e)
      {
        e.printStackTrace();
      }
    }
    input.write('G');
  }
  background(0);
  for(int i = 0; i < numWindows; i++)
  {
    window[i].show();
  }
  for(int i = 0; i < numButtons; i++)
  {
    button[i].show();
  }  
}

/*********************************************************
* mouseClicked function
* INFO: The mouseClicked() function is called after a mouse button has been pressed and then released.
**********************************************************/
void mouseClicked()
{
  int windowClicked = -1;
  int buttonClicked = -1;
  for(int i = 0; i < numWindows; i++)
  {
    if((mouseY >= (window[i].pos_Y)) && (mouseY <= (window[i].pos_Y + window[i].size_Y)) && (mouseX >= window[i].pos_X) && (mouseX <= (window[i].pos_X + window[i].size_X))) windowClicked = i;
    if(windowClicked >= 2)
    {
      button[i].label = "Window Clicked";
      windowClicked = -1;
    }
  }
  for(int i = 0; i < numButtons; i++)
  {
    if((mouseY >= (button[i].pos_Y)) && (mouseY <= (button[i].pos_Y + button[i].size_Y)) && (mouseX >= button[i].pos_X) && (mouseX <= (button[i].pos_X + button[i].size_X))) buttonClicked = i;
    if(buttonClicked >= 2)
    {
      button[i].label = "I feel violated..";
      buttonClicked = -1;
    }
    else if(buttonClicked == 0)
    {
      if(!save)
      {
        fileOutput = createOutput("output.txt");
        save = true;
        button[0].label = "Stop";
      }
      else
      {
        save = false;
        button[0].label = "Record";
        if(button[1].label == "Stop recording!") button[1].label = "Play";
      }
      buttonClicked = -1;
    }
    else if(buttonClicked == 1)
    {
      if(!play)
      {
        if(save)
        {
          button[1].label = "Stop recording!";
        }
        else
        {
          fileInput = createInput("output.txt");
          play = true;
          button[1].label = "Stop";
        }
      }
      else
      {
        play = false;
        button[1].label = "Play";
      }
      buttonClicked = -1;
    }
  }
}
