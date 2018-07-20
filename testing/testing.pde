
Map mapHolder;
boolean isPaused = false;
void setup()
{
  fullScreen();
  rectMode(CENTER);
  ellipseMode(CENTER);
  mapHolder = new Map();
  mapHolder.PopulateMap();
}

void draw()
{ 
  if(!isPaused)
  {
    mapHolder.RunSimulation(10);
    mapHolder.Tick();
  }
  mapHolder.DrawMap();
}

void keyPressed() {
  if(key == ' ')
  {
    isPaused = !isPaused;
  }
}