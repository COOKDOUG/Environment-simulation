class Creature
{
  int apetite;
  float hunger;
  float nutrient;
  
  int _height;
  int _width;
  
  int color1;
  int color2;
  int color3;
  
  final int healthBarWidth = 20;
  
  final int DeathCounter = 200;
  
  int stepsToDeath;
  
  Creature(int Height, int Width)
  {
    apetite = (int)random(3);
    hunger = random(1);
    
    _height = Height;
    _width = Width;
    
    color1 = 256;//round(random(256));
    color2 = 256;//round(random(256));
    color3 = 256;//round(random(256));
    
    stepsToDeath = DeathCounter;
  }
  
  int GetHeight()
  {
    return _height;
  }
  
  int GetWidth()
  {
    return _width;
  }
  
  boolean Eat(Cell cell)
  {
    if (isDead())
    {
      return false;
    }
    boolean result;
    switch(apetite)
    {
      case 0:
        if(cell.nutrientA > hunger)
        {
          cell.nutrientA = cell.nutrientA - hunger;
          if(cell.TotalNutrients() + (hunger/2) < cell.maxNutrients)
          {
            cell.nutrientB = cell.nutrientB + (hunger/2);
          }
          result = true;
        }
        else
        {
          result = false;
        }
        break;
    case 1:
      if(cell.nutrientB > hunger)
        {
          cell.nutrientB = cell.nutrientB - hunger;
          if(cell.TotalNutrients() + (hunger/2) < cell.maxNutrients)
          {
            cell.nutrientC = cell.nutrientC + (hunger/2);
          }
          result = true;
        }
        else
        {
          result = false;
        }
        break;
    case 2:
      if(cell.nutrientC > hunger)
        {
          cell.nutrientC = cell.nutrientC - hunger;
          if(cell.TotalNutrients() + (hunger/2) < cell.maxNutrients)
          {
            cell.nutrientA = cell.nutrientA + (hunger/2);
          }
          result = true;
        }
        else
        {
          result = false;
        }
        break;
    default:
      result = false;
      break;
    }
    if(result == false)
    {
      stepsToDeath --;
    }
    else
    {
      nutrient = nutrient + hunger;
      stepsToDeath = DeathCounter;
    }
    return result;
  }
  
  void Move()
  {
    if (isDead())
    {
      return;
    }
    int direction = (int)random(4);
    switch(direction)
      {
        case 0://move up
          if(_height - 1 >= 0)
            {
              _height = _height -1;
            }
        break;
          
        case 1: //move down
          if(_height + 1 < Map.Height)
            {
              _height = _height +1;
            }
        break;
        
        case 2://move right
        if(_width - 1 >= 0)
            {
              _width = _width -1;
            }
        break;
        
        case 3:
          if(_width + 1 < Map.Width)
            {
              _width = _width +1;
            }
        break;
      }
  }
  
  void Tick(Cell cell)
  {
    if(!isDead())
    {
      if(!Eat(cell))
      {
        Move();
      }
    }
    else
    {
      Rot(cell);
    }
  }
  
  void Rot(Cell cell)
  {
    float amountToAdd;
    if(nutrient < 1)
    {
      println("nutrient less than 1 "+ nutrient);
      amountToAdd = nutrient;
      nutrient = 0;
    }
    else
    {
      amountToAdd = nutrient * .3;
      nutrient = nutrient - amountToAdd;
    }
    println("nutrient" + nutrient);
    println("rotting " + amountToAdd);
    
    switch(int(random(3)))
    {
      case 0:
        cell.nutrientC += amountToAdd;
        break;
      
      case 1:
        cell.nutrientA += amountToAdd;
        break;
      
      case 2:
        cell.nutrientB += amountToAdd;
        break;
    }
  }
  
  void Draw()
  {
    fill(color1, color2, color3);
    ellipse(_height * Map.CellSize+ Map.CellSize /2, _width * Map.CellSize+ Map.CellSize /2, Map.CellSize-2, Map.CellSize-2);
    
    int greenWidth;
    if(stepsToDeath/healthBarWidth != 0)
    {
      greenWidth = stepsToDeath / (stepsToDeath/healthBarWidth);
    }
    else 
    {
      greenWidth = 1;
    }
    int redWidth = healthBarWidth - greenWidth;
    fill(0,256,0);
    println(greenWidth);
    rectMode(CORNER);
    rect(_height * Map.CellSize - (healthBarWidth / 4), (_width * Map.CellSize) - (Map.CellSize),greenWidth,6);
    fill(256,0,0);
    if(!isDead())
    {
      rect(_height * Map.CellSize - (healthBarWidth /4) + greenWidth, (_width * Map.CellSize) - (Map.CellSize),redWidth,6);
    }
    else
    {
      rect(_height * Map.CellSize+ Map.CellSize /2 , (_width * Map.CellSize) - (Map.CellSize),healthBarWidth,6);
    }
    rectMode(CENTER);
  }
  
  boolean isDead()
  {
    return stepsToDeath <= 0;
  }
}