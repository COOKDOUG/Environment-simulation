class Cell
{
  FloatList MaxNutrients;
  FloatList Nutrients;
  float maxNutrientsHolder;
  
  float Total_Max_Nutrients()
  {
    if(maxNutrientsHolder == 0)
    {
      for(float number : MaxNutrients)
      {
        maxNutrientsHolder += number;
      }
    }
    return maxNutrientsHolder;
  }
  
  boolean CanAddNutrient(int nutrient)
  {
    if (Nutrients.get(nutrient) < (2* MaxNutrients.get(nutrient)))
    {
      return true;
    }
    
    return false;
  }
  
  Cell()
  {
    MaxNutrients = new FloatList();
    MaxNutrients.append(random(3,5));
    MaxNutrients.append(random(3,5));
    MaxNutrients.append(random(3,5));
    Nutrients = new FloatList();
    for(int i = 0; i < 3; i ++)
    {
      Nutrients.append(random(MaxNutrients.get(i) - TotalNutrients()));
    }
    Nutrients.shuffle();

    maxNutrientsHolder = 0;
  }
  
  int ToAlphaValue(int nutrient)
  {
    return int(200 * (this.Nutrients.get(nutrient) / this.MaxNutrients.get(nutrient)));
  }
  
  float TotalNutrients()
  {
    float holder = 0;
    for(float number : Nutrients)
    {
      holder = holder + number;
    }
    return holder;
  }
  
  boolean isOverflowing()
  {
    return Total_Max_Nutrients() < TotalNutrients();
  }
  
  void Grow()
  {
    int holder = int(random(1000));
    
    if(holder == 4)
    {
      if(TotalNutrients() <= Total_Max_Nutrients())
      {
        if (Nutrients.get(Constants.NutrientA) > Nutrients.get(Constants.NutrientB) && Nutrients.get(Constants.NutrientA) > Nutrients.get(Constants.NutrientC))
        {
          Nutrients.set(Constants.NutrientA, Nutrients.get(Constants.NutrientA) + (Nutrients.get(Constants.NutrientA) * .5)) ;
        }
        else if (Nutrients.get(Constants.NutrientB) > Nutrients.get(Constants.NutrientA) && Nutrients.get(Constants.NutrientB) > Nutrients.get(Constants.NutrientC))
        {
          Nutrients.set(Constants.NutrientB, Nutrients.get(Constants.NutrientB) + (Nutrients.get(Constants.NutrientB) * .5));
        }
        else if (Nutrients.get(Constants.NutrientC) > Nutrients.get(Constants.NutrientB) && Nutrients.get(Constants.NutrientC) > Nutrients.get(Constants.NutrientA))
        {
          Nutrients.set(Constants.NutrientC, Nutrients.get(Constants.NutrientC) + (Nutrients.get(Constants.NutrientC) * .5));
        }
      }
    }
  }
  
  void RemoveNutrients(int nutrient, float removeAmount) throws Exception
  {
    //take the given amount from the given nutrient
    if(this.Nutrients.get(nutrient) >= removeAmount)
    {
      this.Nutrients.sub(nutrient, removeAmount);
    }
    else
    {
      throw new Exception("Can't remove more than a cell has.");
    }
  }
  
  int GetOverflowingNutrient()
  {
    IntList indexHolder = new IntList();
    for(int i =0; i < 3; i ++)
    {
      if(this.Nutrients.get(i) > this.MaxNutrients.get(i))
      {
        indexHolder.append(i);
      }
    }
    
    if(indexHolder.size() != 0)
    {
      indexHolder.shuffle();
      return indexHolder.get(0);
    }
    else 
    {
      return -1;
    }
  }
}