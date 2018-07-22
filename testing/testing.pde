Map mapHolder;
boolean isPaused = false;
boolean statisticsAreShowing = false;
PFont f; 
int accelerateMultiplier;

void setup()
{
  fullScreen();
  frameRate(144);
  rectMode(CENTER);
  ellipseMode(CENTER);
  int cellSize = 10;
  MapValues.Init(width/cellSize,
    height / cellSize,
    cellSize,
    40,//Breeding CD
    40,//Creatures
    20);//Plants
  mapHolder = new Map();
  mapHolder.PopulateMap();

  f = createFont("Arial Black", 16, true);
  accelerateMultiplier = 0;
}

void draw()
{ 
  if(!isPaused)
  {
    if(this.accelerateMultiplier > 0)
    {
      mapHolder.RunSimulation(accelerateMultiplier * 10);
    }
    else
    {
      mapHolder.Tick();
    }
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
  else if (key == CODED)
  {
    if (keyCode == UP)
    {
      this.accelerateMultiplier ++;
    }
    else if(keyCode ==DOWN)
    {
      if(this.accelerateMultiplier > 0)
      {
        this.accelerateMultiplier --;
      }
    }
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
  text("Deaths :" + str(RunStatistics.Deaths),width/8, currentHeight);

  currentHeight += 60;
  text("Poop Amount :" + str(RunStatistics.PoopAmount),width/8, currentHeight);

  currentHeight += 60;
  text("Eat Amount :" + str(RunStatistics.EatAmount),width/8, currentHeight);
  
  currentHeight += 60;
  text("Steps :" + str(RunStatistics.Ticks),width/8, currentHeight);
  
  currentHeight += 60;
  text("Generation :" + str(RunStatistics.Generations),width/8, currentHeight);
  
    currentHeight += 60;
  text("Acceleration Multiplier :" + str(this.accelerateMultiplier * 10) + "X",width/8, currentHeight);
}