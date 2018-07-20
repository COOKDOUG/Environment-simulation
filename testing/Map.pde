class Map
{
  static final int Height = 160;
  static final int Width = 100;
  static final int CellSize = 10;
  static final int NumOfCreatures = 15;
  Cell[][] area;
  
  Creature[] creatures;
  
  void PopulateMap()
  {
    area = new Cell[Height][Width];
    for(int i = 0;i<Height;i++)
    {
      for(int j = 0; j<Width; j++)
      {
        area[i][j] = new Cell();
      }
    }
    
    creatures = new Creature[NumOfCreatures];
    for(int i = 0; i < NumOfCreatures; i ++)
    {
      creatures[i] = new Creature(int(random(Height)), int(random(Width)));
    }
  }
  
  void DrawMap()
  {
    for(int i = 0;i<Height;i++)
    {
      for(int j = 0; j<Width; j++)
      {
        DrawCell(area[i][j], i, j);
      }
    }
    
    for(int i = 0; i < NumOfCreatures; i ++)
    {
      if(creatures[i] != null)
      {
        creatures[i].Draw();
      }
    }
  }
  
  void DrawCell(Cell cell, int _height, int _width)
  {
    fill(cell.ToAlphaValue(cell.nutrientA), cell.ToAlphaValue(cell.nutrientB), cell.ToAlphaValue(cell.nutrientC));
    rect((_height * CellSize) + CellSize /2, _width * CellSize+ CellSize /2,CellSize,CellSize);
  }
  
  void Tick()
  {
    for(int i = 0; i < NumOfCreatures; i ++)
    {
      if(creatures[i] != null)
      {
        creatures[i].Tick(area[creatures[i]._height][creatures[i]._width]);
        if(creatures[i].isDead() && creatures[i].nutrient==0)
        {
          creatures[i] = null;
        }
      }
    }
    
    for(int i = 0; i < 16; i++)
    {
      int _height = int(random(Height));
      int _width = int(random(Width));
      
      area[_height][_width].Grow();
    }
    
    for(int i = 0;i<Height;i++)
    {
      for(int j = 0; j<Width; j++)
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
    println("actually spilling");
    float amountToSpill = overflowingCell.TotalNutrients() - overflowingCell.maxNutrients;
    
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
    
    if((_height + 1) < Height)
    {
      if((_width + 1) < Width)
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
      if((_width + 1) < Width)
      {
        cellList.add(area[_height - 1][_width + 1]);
      }
      if((_width - 1) > -1)
      {
        cellList.add(area[_height - 1][_width - 1]);
      }
      cellList.add(area[_height - 1][_width]);
    }
    if((_width + 1) < Width)
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