class Map
{
  static final int NumOfCreatures = 100;
  Cell[][] area;
  
  ArrayList<Creature> creatures;
  
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
    
    creatures = new ArrayList<Creature>();
    for(int i = 0; i < NumOfCreatures; i ++)
    {
      creatures.add(new Creature(int(random(MapValues.Height)), int(random(MapValues.Width))));
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
    
    Creature animal;
    for(int i = 0; i < creatures.size(); i ++)
    {
      animal = creatures.get(i);
      if(animal != null)
      {
        animal.Draw();
      }
    }
  }
  
  void DrawCell(Cell cell, int _height, int _width)
  {
    fill(cell.ToAlphaValue(cell.nutrientA), cell.ToAlphaValue(cell.nutrientB), cell.ToAlphaValue(cell.nutrientC));
    rect((_height * MapValues.CellSize) + MapValues.CellSize /2, _width * MapValues.CellSize+ MapValues.CellSize /2,MapValues.CellSize,MapValues.CellSize);
  }
  
  void Tick()
  {
    Creature animal;
    ArrayList<Creature> creaturesHolder = new ArrayList<Creature>();
    for(int i = 0; i < creatures.size(); i ++)
    {
      animal = creatures.get(i);
      for(Creature compare : creatures)
      {
        if(compare._height == animal._height && compare._width == animal._width)
        {
          Creature breedHolder = animal.Breed(compare);
          if(breedHolder != null)
          {
            creaturesHolder.add(breedHolder);
          }
        }
      }
      if(animal != null)
      {
        animal.Tick(area[animal._height][animal._width]);
        if(animal.isDead() && animal.nutrient==0)
        {
          creatures.remove(i);
        }
      }
    }
    for(Creature creature: creaturesHolder)
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
        cell.nutrientA += amountToSpill * (1/cellList.size());
        break;
        case 1:
        cell.nutrientB += amountToSpill * (1/cellList.size());
        break;
        case 2:
        cell.nutrientC += amountToSpill * (1/cellList.size());
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
