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
    
    FloatList Get_nutrients()
    {return Nutrients;}
    void Set_Nutrients(FloatList value)
    {Nutrients = value;}
    void Set_nutrients_value(int index, float value)
    {Nutrients.set(index, value);}
    void Add_nutrients(int index, float value)
    {
    Nutrients.add(index, value);} //<>//
    float Get_Total_Nutrients()
    {return Nutrients.get(Constants.NutrientA) + Nutrients.get(Constants.NutrientC) + Nutrients.get(Constants.NutrientC);}
    
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
  
  Cow(int Height, int Width)
  {
    Init(Height, Width, MapValues.BreedingCooldown);
  }
  
  private Cow()
  {}

  Cow(Cow cow1, Cow cow2)
  {
    Init(cow1.Get_height(),cow1.Get_width(), MapValues.BreedingCooldown);
    hunger = (cow1.Get_hunger() + cow2.Get_hunger()) / 2;
    Set_color1(int(random(128,250)));
    Set_color2(int(random(128,250)));
    Set_color3(int(random(128,250)));
  }
  
  void Init(int Height, int Width, int breedCooldown)
  {
    apetite = (int)random(3); //<>//
    hunger = random(.2,1); //<>//
     //<>//
    Set_height(Height); //<>//
    Set_width(Width);
     //<>//
    Set_color1(256);//round(random(256)); //<>//
    Set_color2(256);//round(random(256)); //<>//
    Set_color3(256);//round(random(256)); //<>//
    
    Set_stepsToDeath(DeathCounter);
    Set_breedingCooldown(breedCooldown);
    Nutrients = new FloatList(3);
    Nutrients.append(0);
    Nutrients.append(0);
    Nutrients.append(0);
  }
  
  public <T extends ICreature> T NewCreature(int Height, int Width, int breedCooldown) //<>//
  { //<>// //<>// //<>//
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
    holder.Set_Nutrients(new FloatList(3));
    
    holder.Nutrients.append(0);
    holder.Nutrients.append(0);
    holder.Nutrients.append(0);
    return (T)holder;
  }
  
  void Poop(Cell cell)
  {
    if(isDead())
    {return;}
    
    int randomNutrient = int(random(3));
    
    if(hunger * 25 < Nutrients.get(randomNutrient))
    {
      if(int(random(10)) != 1)
      {return;}
      switch(apetite)
      {
        case 0:
          cell.Nutrients.set(Constants.NutrientB, cell.Nutrients.get(Constants.NutrientB) + (this.Nutrients.get(randomNutrient)/4));
          break;
      case 1:
          cell.Nutrients.set(Constants.NutrientC, cell.Nutrients.get(Constants.NutrientC) + (this.Nutrients.get(randomNutrient)/4));
          break;
      case 2:
          cell.Nutrients.set(Constants.NutrientA, cell.Nutrients.get(Constants.NutrientA) + (this.Nutrients.get(randomNutrient)/4));
          break;
      default:
      break;
      }
      Set_nutrients_value(randomNutrient,2 * (Nutrients.get(randomNutrient)/3));
      RunStatistics.PoopAmount += Nutrients.get(randomNutrient)/3;
    }
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
        if(cell.Nutrients.get(Constants.NutrientA) > hunger)
        {
          cell.Nutrients.set(Constants.NutrientA, cell.Nutrients.get(Constants.NutrientA) - hunger);
          result = true;
        }
        else
        {
          result = false;
        }
        break;
    case 1:
      if(cell.Nutrients.get(Constants.NutrientB) > hunger)
        {
          cell.Nutrients.set(Constants.NutrientB, cell.Nutrients.get(Constants.NutrientB) - hunger);
          result = true;
        }
        else
        {
          result = false;
        }
        break;
    case 2:
      if(cell.Nutrients.get(Constants.NutrientC) > hunger)
        {
          cell.Nutrients.set(Constants.NutrientC, cell.Nutrients.get(Constants.NutrientC) - hunger);
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
    if(result == true)
    {
      //put eaten stuff into random nutrient
      int randomNutrient = int(random(3));
      Add_nutrients(randomNutrient, hunger);
      RunStatistics.EatAmount += hunger;
      if(stepsToDeath < DeathCounter)
      {
        stepsToDeath += 5;
      }
    }
    else
    {
      stepsToDeath --;
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
      if(Eat(cell))
      {
        Poop(cell);
      }
      else
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
    // creatures now store all three nutrients
    // we should transfer those to the cell gradually
    for(int i = 0; i < 3; i ++)
    {
      float amountToAdd;
      float nutrientAmount = Nutrients.get(i);
      if( nutrientAmount < 1)
      {
        amountToAdd = nutrientAmount;
        Set_nutrients_value(i, 0);
      }
      else
      {
        amountToAdd = nutrientAmount * .3;
        Add_nutrients(i, amountToAdd * -1);
      }
      
      cell.Nutrients.set(i, cell.Nutrients.get(i) + amountToAdd);
      // switch(apetite)
      // {
      //   case 0:
      //     cell.Nutrients.set(Constants.NutrientC, cell.Nutrients.get(Constants.NutrientC)+ amountToAdd);
      //     break;
        
      //   case 1:
      //     cell.Nutrients.set(Constants.NutrientA, cell.Nutrients.get(Constants.NutrientA)+ amountToAdd);
      //     break;
        
      //   case 2:
      //     cell.Nutrients.set(Constants.NutrientB, cell.Nutrients.get(Constants.NutrientB)+ amountToAdd);
      //     break;
      // }
    }
  }
  
  void Draw()
  {
    fill(Nutrients.get(Constants.NutrientA)/Get_Total_Nutrients() * 256, Nutrients.get(Constants.NutrientB)/Get_Total_Nutrients()* 256, Nutrients.get(Constants.NutrientC)/Get_Total_Nutrients()* 256);
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
      if(int(random(16)) == 1)
      {
        breedingCooldown = MapValues.BreedingCooldown;
        holder.breedingCooldown = MapValues.BreedingCooldown;
        RunStatistics.Births += 1;
        return new Cow(this, holder);
      }
    }
    
    return null;
  }
}