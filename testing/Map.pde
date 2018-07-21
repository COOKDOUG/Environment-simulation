class Map
{
  static final int NumOfCreatures = 60;
  static final int NumOfPlants = 15;
  Cell[][] area;
  
  ArrayList<ICreature> creatures; 
  ArrayList<Plant> plants;
      
  void PopulateMap()
  { 
    area = new Cell[MapValues.Height][MapValues.Width];
    for(int i = 0;i<MapValues.Height;i++)
    {
      for(int j = 0; j<MapValues.Width; j++)
      {
        area[i][j] = new Cell();
      }
    }
    
    creatures = new ArrayList<ICreature>();    
    for(int i = 0; i < NumOfCreatures; i ++)
    { 
      int spawnHeight = int(random(MapValues.Height));
      int spawnWidth = int(random(MapValues.Width));
      creatures.add(new Cow(spawnHeight, spawnWidth));
    }
    
    plants = new ArrayList<Plant>();
    for(int i = 0; i < NumOfPlants; i++)
    {
      int spawnHeight = int(random(MapValues.Height));
      int spawnWidth = int(random(MapValues.Width));
      plants.add(new Fern(spawnHeight, spawnWidth));
    }
  }
  
  void DrawMap()
  {
    for(int i = 0;i<MapValues.Height;i++)
    {
      for(int j = 0; j<MapValues.Width; j++)
      {
        DrawCell(area[i][j], i, j);
      }
    }
    
    
    for(ICreature animal: creatures)
    {
      animal.Draw();
    }
    
    for (Plant plant : plants)
    {
      plant.Draw();
    }
  }
  
  void DrawCell(Cell cell, int _height, int _width)
  {
    fill(cell.ToAlphaValue(Constants.NutrientA), cell.ToAlphaValue(Constants.NutrientB), cell.ToAlphaValue(Constants.NutrientC));
    rect((_height * MapValues.CellSize) + MapValues.CellSize /2, _width * MapValues.CellSize+ MapValues.CellSize /2,MapValues.CellSize,MapValues.CellSize);
  }
  
  void Tick()
  {
    RunStatistics.Ticks ++;
    //if(creatures.size() == 0)
    //{
    //  PopulateMap();
    //}

    ICreature animal;
    ICreature compare;
    ArrayList<ICreature> creaturesHolder = new ArrayList<ICreature>();
    for(int i = 0; i < creatures.size(); i ++)
    {
      animal = creatures.get(i);
      for(int j = 0; j < creatures.size(); j ++)
      {
        if (j != i)
        {
          compare = creatures.get(j);
          if(compare.Get_height() == animal.Get_height() && compare.Get_width() == animal.Get_width())
          {
            ICreature breedHolder = (animal).Breed(compare);
            if(breedHolder != null)
            {
              creaturesHolder.add(breedHolder);
            }
          }
        }
      }
      if(animal != null)
      {
        ((ICreature)animal).Tick(area[animal.Get_height()][animal.Get_width()]);
        if(((ICreature)animal).isDead() && animal.Get_Total_Nutrients()==0)
        {
          RunStatistics.Deaths += 1;
          creatures.remove(i);
        }
      }
    }
    for(ICreature creature: creaturesHolder)
    {
      creatures.add(creature);
    }
    creaturesHolder.clear();
    
    for(int i = 0; i < (MapValues.Height * MapValues.Width / 100); i++)
    {
      int _height = int(random(MapValues.Height));
      int _width = int(random(MapValues.Width));
  
      area[_height][_width].Grow();
    }
    
    for(int i = 0;i<MapValues.Height;i++)
    {
      for(int j = 0; j<MapValues.Width; j++)
      {
        SpillOver(area[i][j], GetSurroundingCells(i,j));
      }
    }

    for(Plant plant : plants)
    {
      plant.Tick(area[plant.Height][plant.Width]);
    }
    
    
  }
  
  void RunSimulation(int steps)
  {
    for(int i = 0; i < steps; i ++)
    {
      Tick();
    }
  }
  
  void SpillOver(Cell overflowingCell, ArrayList<Cell> cellList)
  {
    if(!overflowingCell.isOverflowing())
    {
      return;
    }
    int overflowingNutrient = overflowingCell.GetOverflowingNutrient();
    float amountToSpill = overflowingCell.TotalNutrients() - overflowingCell.Total_Max_Nutrients();
    try
    {
      overflowingCell.RemoveNutrients(overflowingNutrient, amountToSpill);
    }
    catch(Exception e)
    {
      return;
    }
    Cell cell; 
    for(int i = 0; i < cellList.size(); i ++)  
    {
      cell = cellList.get(i);

      cell.Nutrients.add(overflowingNutrient,  amountToSpill * ((float)1/((float)cellList.size()*2))); 
    }
  }
  
  ArrayList<Cell> GetSurroundingCells(int _height, int _width)
  {
    ArrayList<Cell> cellList = new ArrayList<Cell>();
    
    if((_height + 1) < MapValues.Height)
    {
      if((_width + 1) < MapValues.Width)
      {
        cellList.add(area[_height + 1][_width + 1]);
      }
      if((_width - 1) > -1)
      {
        cellList.add(area[_height + 1][_width - 1]);
      }
      cellList.add(area[_height + 1][_width]);
    }
    if((_height - 1) > -1)
    {
      if((_width + 1) < MapValues.Width)
      {
        cellList.add(area[_height - 1][_width + 1]);
      }
      if((_width - 1) > -1)
      {
        cellList.add(area[_height - 1][_width - 1]);
      }
      cellList.add(area[_height - 1][_width]);
    }
    if((_width + 1) < MapValues.Width)
    {
      cellList.add(area[_height][_width + 1]);
    }
    if((_width - 1) > -1)
    {
      cellList.add(area[_height][_width - 1]);
    }
    
    return cellList;
  }
  
  Map()
  {
  
  }
}