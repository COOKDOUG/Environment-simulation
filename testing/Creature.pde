class Cow extends Creature implements ICreature 
{
    int Get_apetite()
    {return apetite;}
    void Set_apetite(int value)
    {apetite = value;}
    float Get_hunger()
    {return hunger;}
    void Set_hunger(float value)
    {hunger = value;}
    float Get_nutrient()
    {return nutrient;}
    void Set_nutrient(float value)
    {nutrient = value;}
    
    int Get_height()
    {return _height;}
    void Set_height(int value)
    {_height = value;}
    int Get_width()
    {return _width;}
    void Set_width(int value)
    {_width = value;}
    
    int Get_color1()
    {return color1;}
    void Set_color1(int value)
    {color1 = value;}
    int Get_color2()
    {return color2;}
    void Set_color2(int value)
    {color2 = value;}
    int Get_color3()
    {return color3;}
    void Set_color3(int value)
    {color3 = value;}
    
    int Get_stepsToDeath()
    {return stepsToDeath;}
    void Set_stepsToDeath(int value)
    {stepsToDeath = value;}
    int Get_breedingCooldown()
    {return breedingCooldown;}
    void Set_breedingCooldown(int value)
    {breedingCooldown = value;}
  
  Cow(int Height, int Width, int breedCooldown)
  {
    Init(Height, Width, breedCooldown);
  }
  
  private Cow()
  {}
  
  void Init(int Height, int Width, int breedCooldown)
  {
    apetite = (int)random(3);
    hunger = random(.2,1);
    
    Set_height(Height);
    Set_width(Width);
    
    Set_color1(256);//round(random(256));
    Set_color2(256);//round(random(256));
    Set_color3(256);//round(random(256));
    
    Set_stepsToDeath(DeathCounter);
    Set_breedingCooldown(breedCooldown);
  }
  
  public <T extends ICreature> T NewCreature(int Height, int Width, int breedCooldown) //<>//
  { //<>//
    println("Height " + Height); //<>//
    println("Width " + Width); //<>//
    Cow holder = new Cow(); //<>//
    holder.apetite = (int)random(3); //<>//
    holder.hunger = random(.2,1);
    
    holder.Set_height(Height);
    holder.Set_width(Width);
    
    holder.Set_color1(256);//round(random(256));
    holder.Set_color2(256);//round(random(256));
    holder.Set_color3(256);//round(random(256));
    
    holder.Set_stepsToDeath(DeathCounter);
    holder.Set_breedingCooldown(breedCooldown);
    return (T)holder;
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
      if(stepsToDeath < DeathCounter)
      {
        stepsToDeath += 5;
      }
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
          if(_height + 1 < MapValues.Height)
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
          if(_width + 1 < MapValues.Width)
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
      if(breedingCooldown > 0)
      {
        breedingCooldown --;
      }
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
      amountToAdd = nutrient;
      nutrient = 0;
    }
    else
    {
      amountToAdd = nutrient * .3;
      nutrient = nutrient - amountToAdd;
    }
    
    switch(apetite)
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
    ellipse(_height * MapValues.CellSize+ MapValues.CellSize /2, _width * MapValues.CellSize+ MapValues.CellSize /2, MapValues.CellSize-2, MapValues.CellSize-2);
    
    int greenWidth;
    if((float)stepsToDeath/(float)DeathCounter != 0)
    {
      greenWidth = int(healthBarWidth * ((float)stepsToDeath/(float)DeathCounter));
    }
    else 
    {
      greenWidth = 1;
    }
    if(greenWidth > 20)
    {
      greenWidth = 20;
    }
    int redWidth = healthBarWidth - greenWidth;
    fill(0,256,0);
    rectMode(CORNER);
    rect(_height * MapValues.CellSize - (healthBarWidth / 4), (_width * MapValues.CellSize) - (MapValues.CellSize),greenWidth,6);
    fill(256,0,0);
    if(!isDead())
    {
      rect(_height * MapValues.CellSize - (healthBarWidth /4) + greenWidth, (_width * MapValues.CellSize) - (MapValues.CellSize),redWidth,6);
    }
    else
    {
      rect(_height * MapValues.CellSize - (healthBarWidth / 4), (_width * MapValues.CellSize) - (MapValues.CellSize),healthBarWidth,6);
    }
    rectMode(CENTER);
  }
  
  boolean isDead()
  {
    return stepsToDeath <= 0;
  }
  
  ICreature Breed(ICreature creature)
  {
    Cow holder = (Cow)creature;
    if(breedingCooldown == 0)
    {
      RunStatistics.BirthChances += 1;
      if(int(random(20)) == 1)
      {
        breedingCooldown = MapValues.BreedingCooldown;
        holder.breedingCooldown = MapValues.BreedingCooldown;
        RunStatistics.Births += 1;
        return NewCreature(holder.Get_height(), holder.Get_width(), MapValues.BreedingCooldown);
      }
    }
    
    return null;
  }
}