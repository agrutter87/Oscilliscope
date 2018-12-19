/*********************************************************
* Button Class
**********************************************************/
class Button
{
  /* Properties */
  String label;
  int size_X;
  int size_Y;
  int pos_X;
  int pos_Y;
  Boolean disabled;
    
  /* Constructor */
  Button(String Text, int layoutPosition)
  {
    size_X = int((width / 9) - 20);
    size_Y = 30;
    if(layoutPosition < 10)
    {
      pos_X = 10 + ((layoutPosition - 1) * (size_X + 20));
      pos_Y = int((height - 90));
    }
    if(layoutPosition > 9)
    {
      pos_X = 10 + ((layoutPosition - 10) * (size_X + 20));
      pos_Y = int((height - 40));
    }
    label = Text;
    disabled = false;
  }
  
  /* Functions */
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
}
