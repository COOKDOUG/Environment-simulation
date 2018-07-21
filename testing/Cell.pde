class Cell
{
  float maxNutrients;
  
  FloatList Nutrients;
  
  
  
  Cell()
  {
    maxNutrients = random(3,5);
    Nutrients = new FloatList();
    for(int i = 0; i < 3; i ++)
    {
      Nutrients.append(random(maxNutrients - TotalNutrients()));
    }
    Nutrients.shuffle();
  }
  
  int ToAlphaValue(float nutrient)
  {
    float returnHolder = 256 * nutrient;
    return round(returnHolder / maxNutrients);
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
    return maxNutrients < TotalNutrients();
  }
  
  void Grow()
  {
    int holder = int(random(1000));
    
    if(holder == 4)
    {
      if(TotalNutrients() <= maxNutrients)
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
  
  void RemoveNutrients(float removeAmount)
  {
    float removePart;
    
    if(removeAmount > 1)
    {
      removePart = random(removeAmount);
    }
    else
    {
      removePart = removeAmount;
    }
    switch(int(random(3)))
    {
      case 0:
        if(removePart < Nutrients.get(Constants.NutrientA))
        {
          Nutrients.set(Constants.NutrientA, Nutrients.get(Constants.NutrientA) - removePart);
        }
      break;
      case 1:
        if(removePart < Nutrients.get(Constants.NutrientB))
        {
          Nutrients.set(Constants.NutrientB, Nutrients.get(Constants.NutrientB) - removePart);
        }
      break;
      case 2:
        if(removePart < Nutrients.get(Constants.NutrientC))
        {
          Nutrients.set(Constants.NutrientC, Nutrients.get(Constants.NutrientC) - removePart);
        }
      break;
    }
    removeAmount -= removePart;
  }
}