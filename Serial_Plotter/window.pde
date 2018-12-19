/*********************************************************
* Window Class
**********************************************************/
class Window
{
  /* Properties */
  int size_X; // width of window
  int size_Y; // height of window
  int pos_X; // position of window from left
  int pos_Y; // position of window from top
  int[] data;
  int[] timestamp;
  int[] graph;
    
  /* Constructor */
  Window(int layoutPosition)
  {
    size_X = int((width / numWindowsPerRow) - windowSpacing); // sets the width of the window to evenly space it to allow 'numWindowsPerRow' to fit smoothly
    size_Y = int(((height - 100) / numWindowsPerColumn) - windowSpacing); // sets the height of the window to evenly space it to allow 'numWindowsPerColumn' to fit smoothly while allowing 100px for buttons at the bottom
    data = new int[size_X];
    graph = new int[size_X];
    timestamp = new int[size_X];
    for(int i = 0; i < size_X; i++)
    {
      data[i] = 0;
      graph[i] = 0;
      timestamp[i] = 0;
    }
    for(int rowNumber = 1; rowNumber <= numWindowsPerColumn; rowNumber++) // loop determines window's position on screen based on the 'layoutPosition' and 'numWindowsPerColumn' variables
    {
      if(layoutPosition <=  rowNumber * numWindowsPerRow)
      {
        pos_X = int(borderSpacing + ((layoutPosition - (numWindowsPerRow * (rowNumber - 1) + 1)) * (size_X + windowSpacing)));
        pos_Y = int(borderSpacing + ((windowSpacing + size_Y) * (rowNumber - 1)));
        break;
      }
    }
  }
  
  /* Functions */
  void show() // function for drawing window to screen
  {
    fill(color(255,255,255)); // chooses the color white for the window background
    rect(pos_X, pos_Y, size_X, size_Y); // draws the window background as a rectangle
    for(int i = 0; i < (size_X - 1); i++)
    {
      stroke(0);
      graph[size_X - 1 - i] = int(map(data[size_X - 1 - i], 0, 255, 0, (size_Y - 1)));
      graph[size_X - 2 - i] = int(map(data[size_X - 2 - i], 0, 255, 0, (size_Y - 1)));
      line((pos_X + i),(pos_Y + size_Y - graph[size_X - 1 - i]),(pos_X + 1 + i),(pos_Y + size_Y - graph[size_X - 2 - i]));
    }
  }
}
