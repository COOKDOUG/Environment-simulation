class Map
{
  static final int NumOfCreatures = 100;
  Cell[][] area;
  
  ArrayList<ICreature> creatures; //<>//
  
  void PopulateMap()
  { //<>//
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
    { //<>//
      int spawnHeight = int(random(MapValues.Height));
      int spawnWidth = int(random(MapValues.Width));
      creatures.add(new Cow(spawnHeight, spawnWidth));
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
    
    ICreature animal;
    for(int i = 0; i < creatures.size(); i ++)
    {
      animal = creatures.get(i);
      if(animal != null)
      {
        ((Cow)animal).Draw();
      }
    }
  }
  
  void DrawCell(Cell cell, int _height, int _width)
  {
    fill(cell.ToAlphaValue(cell.Nutrients.get(Constants.NutrientA)), cell.ToAlphaValue(cell.Nutrients.get(Constants.NutrientB)), cell.ToAlphaValue(cell.Nutrients.get(Constants.NutrientC)));
    rect((_height * MapValues.CellSize) + MapValues.CellSize /2, _width * MapValues.CellSize+ MapValues.CellSize /2,MapValues.CellSize,MapValues.CellSize);
  }
  
  void Tick()
  {
    if(creatures.size() == 0)
    {
      PopulateMap();
    }

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
    
    for(int i = 0; i < 16; i++)
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
    float amountToSpill = overflowingCell.TotalNutrients() - overflowingCell.maxNutrients;
    overflowingCell.RemoveNutrients(amountToSpill);
    Cell cell;
    for(int i = 0; i < cellList.size(); i ++)
    {
      cell = cellList.get(i);
      switch(int(random(3)))
      {
        case 0:
        cell.Nutrients.set(Constants.NutrientA, cell.Nutrients.get(Constants.NutrientA) + amountToSpill * (1/cellList.size()));
        break;
        case 1:
        cell.Nutrients.set(Constants.NutrientB, cell.Nutrients.get(Constants.NutrientB) + amountToSpill * (1/cellList.size()));
        break;
        case 2:
        cell.Nutrients.set(Constants.NutrientC, cell.Nutrients.get(Constants.NutrientC) + amountToSpill * (1/cellList.size()));
        break;
      }
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