boolean readyToSend = true;
unsigned long stopwatch[2];
int timestamp = 0;
int timesize = 1;
void setup() 
{
  stopwatch[0] = millis();
  stopwatch[1] = stopwatch[0];
  Serial.begin(921600);
}

void loop() 
{
  if(Serial.available() > 0)
  {
    if(Serial.read() == 'G')
    {
      readyToSend = true;
    }
  }
  while(readyToSend == true)
  { 
    stopwatch[0] = millis();   
    int sensorValue = map(analogRead(A0), 0, 1023, 0, 255);
    timestamp = stopwatch[0] - stopwatch[1];
    if(timestamp <= 255)
    {
      timesize = 1;
    }
    else if(timestamp % 255 == 0)
    {
      timesize = timestamp / 255;
    }
    else
    {
      timesize = (timestamp / 255) + 1;
    }
    
    Serial.write(timesize);
    
    for(int i = 0; i < timesize; i++)
    {
      if(timestamp < 256)
      {
        Serial.write(timestamp);
      }
      else
      {
        timestamp = timestamp - 255;
        Serial.write(255);
      }
    }
    Serial.write(sensorValue);
    readyToSend = false;
    stopwatch[1] = stopwatch[0];
  }
}


