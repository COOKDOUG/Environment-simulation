
Map mapHolder;
boolean isPaused = false;
void setup()
{
  fullScreen();
  rectMode(CENTER);
  ellipseMode(CENTER);
  int cellSize = 10;
  MapValues.Height = width/cellSize;
  MapValues.Width = height / cellSize;
  MapValues.CellSize = cellSize;
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
