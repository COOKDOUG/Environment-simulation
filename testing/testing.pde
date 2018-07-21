
Map mapHolder;
boolean isPaused = false;
boolean statisticsAreShowing = false;
PFont f; 

void setup()
{
  fullScreen();
  frameRate(144);
  rectMode(CENTER);
  ellipseMode(CENTER);
  int cellSize = 10;
  MapValues.Height = width/cellSize;
  MapValues.Width = height / cellSize;
  MapValues.CellSize = cellSize;
  MapValues.BreedingCooldown = 40;
  mapHolder = new Map();
  mapHolder.PopulateMap();

  f = createFont("Arial Black", 16, true);
}

void draw()
{ 
  if(!isPaused)
  {
    mapHolder.RunSimulation(10);
    mapHolder.Tick();
  }
  
  mapHolder.DrawMap();
  if(statisticsAreShowing)
  {
    DrawStatistics();
  }
}

void keyPressed() {
  if(key == ' ')
  {
    isPaused = !isPaused;
  }
  else if (key == 's')
  {
    isPaused = !isPaused;
    statisticsAreShowing = !statisticsAreShowing;
  }
}

void DrawStatistics()
{
  fill(200,200,200,80);
  rect(width/2, height/2, width, height);
  
  int currentHeight = height/8;
  
  textFont(f, 40);
  fill(0);
  text("Statistics", width/8, currentHeight);
  
  currentHeight += height/8;
  
  textFont(f,30);
  text("Births :" + str(RunStatistics.Births) + "/" + str(RunStatistics.BirthChances),width/8, currentHeight);  
  
  currentHeight += 60;
  textFont(f,30);
  text("Deaths :" + str(RunStatistics.Deaths),width/8, currentHeight);
}