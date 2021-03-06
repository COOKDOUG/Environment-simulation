class Cow extends Creature
{
    boolean _canEatHere; 
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
    Nutrients.add(index, value);}
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
    
    int Get_breedingCooldown()
    {return BreedingCooldown;}
    void Set_breedingCooldown(int value)
    {BreedingCooldown = value;}
    
    boolean IsHungry()
    {
      if(Get_Total_Nutrients() < hungryLevel)
      {
        return true;
      }
      return false;
    }
  
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
    MoveCost = (cow1.MoveCost + cow2.MoveCost)/2f + random(-.2, .2);
    BreedingChance = (cow1.BreedingChance + cow2.BreedingChance)/2f + random(-.001, .001);

    //Average the OldAges of the animals and add a random range
    int oldAgeSum = (cow1.OldAge + cow2.OldAge);
    OldAge = (oldAgeSum/2 + int(random((-1 * random(0,.02) * oldAgeSum), (random(0,.02) * oldAgeSum))));

    int A_min_sum = cow1.A_Min_Healthy + cow2.A_Min_Healthy;
    int A_max_sum = cow1.A_Max_Healthy + cow2.A_Max_Healthy;
    int B_min_sum = cow1.B_Min_Healthy + cow2.B_Min_Healthy;
    int B_max_sum = cow1.B_Max_Healthy + cow2.B_Max_Healthy;
    int C_min_sum = cow1.C_Min_Healthy + cow2.C_Min_Healthy;
    int C_max_sum = cow1.C_Max_Healthy + cow2.C_Max_Healthy;

    A_Min_Healthy = A_min_sum/2 + int(random((-1 * A_min_sum * .005),(A_min_sum * .005)));
    A_Max_Healthy = A_max_sum/2 + int(random((-1 * A_min_sum * .005),(A_min_sum * .005)));
    B_Min_Healthy = B_min_sum/2 + int(random((-1 * B_min_sum * .005),(B_min_sum * .005)));
    B_Max_Healthy = B_max_sum/2 + int(random((-1 * B_min_sum * .005),(B_min_sum * .005)));
    C_Min_Healthy = C_min_sum/2 + int(random((-1 * C_min_sum * .005),(C_min_sum * .005)));
    C_Max_Healthy = C_max_sum/2 + int(random((-1 * C_min_sum * .005),(C_min_sum * .005)));

    float eatEfficiencySum = cow1.EatEfficiency + cow2.EatEfficiency;
    EatEfficiency = eatEfficiencySum/2f + (random((-1 * eatEfficiencySum * .005),(eatEfficiencySum * .005)));
    if(EatEfficiency > 1)
    {
      EatEfficiency = 1;
    }
  }
  
  void Init(int Height, int Width, int breedCooldown)
  {
    apetite = (int)random(3);
    hunger = random(.2,1);
    
    Set_height(Height);
    Set_width(Width);
    
    Set_color1(256);//round(random(256));
    Set_color2(256);//round(random(256));
    Set_color3(256);//round(random(256));
    
    Set_breedingCooldown(breedCooldown);
    Nutrients = new FloatList(3);
    Nutrients.append(0);
    Nutrients.append(0);
    Nutrients.append(0);
    _canEatHere = true;

    A_Min_Healthy = int(random(15));
    A_Max_Healthy = int(random(A_Min_Healthy, A_Min_Healthy + 30));
    B_Min_Healthy = int(random(15));
    B_Max_Healthy = int(random(B_Min_Healthy, B_Min_Healthy + 30));
    C_Min_Healthy = int(random(15));
    C_Max_Healthy = int(random(C_Min_Healthy, C_Min_Healthy + 30));

    hungryLevel = ((A_Min_Healthy + A_Max_Healthy) /2f) + ((B_Min_Healthy + B_Max_Healthy) /2f) + ((C_Min_Healthy + C_Max_Healthy) /2f);

    MaxHealth = 200;
    CurrentHealth = MaxHealth;
    MoveCost = random(0.01, 0.3);

    TimeAlive = 0;
    ChildrenSpawned = 0;
    TimeInHealthyZone = 0;
    BreedingChance = random(0f,.03f);
    OldAge = int(random(8000,10000));
    EatEfficiency = random(.2,1);
  }
  
  public <T extends Creature> T NewCreature(int Height, int Width, int breedCooldown)
  {
    Cow holder = new Cow();
    holder.apetite = (int)random(3);
    holder.hunger = random(.2,1);
    
    holder.Set_height(Height);
    holder.Set_width(Width);
    
    holder.Set_color1(256);
    holder.Set_color2(256);
    holder.Set_color3(256);
    
    holder.Set_breedingCooldown(breedCooldown);
    holder.Set_Nutrients(new FloatList(3));
    
    holder.Nutrients.append(0);
    holder.Nutrients.append(0);
    holder.Nutrients.append(0);
    
    _canEatHere = true;
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

    if(cell.Nutrients.get(this.apetite) > hunger)
    {
      cell.Nutrients.add(this.apetite, -1 * hunger);
      result = true;
    }
    else
    {
      result = false;
    }

    if(result == true)
    {
      //put eaten stuff into random nutrient
      this.Nutrients.add(int(random(3)), hunger * EatEfficiency);
      RunStatistics.EatAmount += hunger;
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
    this.Nutrients.add(int(random(3)), -1 * MoveCost);
    _canEatHere = true;
  }
  
  private void AdjustHealth()
  {
    for(int i = 0; i < 3; i ++)
    {
      boolean shouldAdd = false;
      switch(i)
      {
        case 0:
          if(this.Nutrients.get(i) >= this.A_Min_Healthy && this.Nutrients.get(i) <= this.A_Max_Healthy)
          {
            shouldAdd = true;
          }
          else
          {
            shouldAdd = false;
          }
        break;
        case 1:
          if(this.Nutrients.get(i) >= this.B_Min_Healthy && this.Nutrients.get(i) <= this.B_Max_Healthy)
          {
            shouldAdd = true;
          }
          else
          {
            shouldAdd = false;
          }
        break;
        case 2:
          if(this.Nutrients.get(i) >= this.C_Min_Healthy && this.Nutrients.get(i) <= this.C_Max_Healthy)
          {
            shouldAdd = true;
          }
          else
          {
            shouldAdd = false;
          }
        break;
      }
      if(shouldAdd)
      {
        this.TimeInHealthyZone ++;
        this.CurrentHealth += 2;
      }
      else
      {
        this.CurrentHealth --;
      }
      if(this.CurrentHealth > this.MaxHealth)
      {
        this.CurrentHealth = this.MaxHealth;
      }
    }
    if(this.TimeAlive > this.OldAge)
    {
      int decreaseBy = 4;
      if(this.TimeAlive > (this.OldAge * 1.5))
      {
        decreaseBy = 6;
      }
      this.CurrentHealth -= decreaseBy;
    }
  }

  void Tick(Cell cell)
  {
    this.AdjustHealth();
    if(!isDead())
    {
      this.TimeAlive ++;
      if(BreedingCooldown > 0)
      {
        BreedingCooldown --;
      }
      if(IsHungry() && _canEatHere)
      {
        if(Eat(cell))
        {
          _canEatHere = true;
          Poop(cell);
        }
        else
        {
          _canEatHere = false;
        }
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
    }
  }
  
  void Draw()
  {
    fill(Nutrients.get(Constants.NutrientA)/Get_Total_Nutrients() * 256, Nutrients.get(Constants.NutrientB)/Get_Total_Nutrients()* 256, Nutrients.get(Constants.NutrientC)/Get_Total_Nutrients()* 256);
    ellipse(_height * MapValues.CellSize+ MapValues.CellSize /2, _width * MapValues.CellSize+ MapValues.CellSize /2, MapValues.CellSize-2, MapValues.CellSize-2);
    
    int greenWidth;
    if((float)CurrentHealth/(float)MaxHealth != 0)
    {
      greenWidth = int(healthBarWidth * ((float)CurrentHealth/(float)MaxHealth));
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
    if(!DeadFlag)
    {
      DeadFlag = CurrentHealth <= 0;
    }
    return DeadFlag;
  }
  
  ICreature Breed(ICreature creature)
  {
    Cow holder = (Cow)creature;
    if(BreedingCooldown == 0)
    {
      RunStatistics.BirthChances += 1;
      if(random(1) <= (holder.BreedingChance + ((1 - holder.BreedingChance) * this.BreedingChance)))
      {
        this.BreedingCooldown = MapValues.BreedingCooldown;
        holder.BreedingCooldown = MapValues.BreedingCooldown;
        ChildrenSpawned ++;
        holder.ChildrenSpawned ++;
        RunStatistics.Births += 1;
        return new Cow(this, holder);
      }
    }
    
    return null;
  }

  int Suitability()
  {
    return int(sqrt(this.TimeAlive) + this.TimeInHealthyZone + (this.ChildrenSpawned * 2000));
  }

  String ToString()
  {
    String s = "Suitability: " + Suitability() + "\n"
      +"TimeHealthy: " + TimeInHealthyZone + "\n"
      +"Children:" + ChildrenSpawned + "\n"
      +"TimeAlive:" + TimeAlive + "\n";
      //+":" + + "\n"
      return s;
  }
}