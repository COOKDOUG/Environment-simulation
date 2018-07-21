class Cell
{
  float maxNutrients;
  
  FloatList Nutrients;
  
  final int NutrientA = 0;
  final int NutrientB = 1;
  final int NutrientC = 2;
  
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
        if (Nutrients.get(NutrientA) > Nutrients.get(NutrientB) && Nutrients.get(NutrientA) > Nutrients.get(NutrientC))
        {
          Nutrients.set(NutrientA, Nutrients.get(NutrientA) + (Nutrients.get(NutrientA) * .5)) ;
        }
        else if (Nutrients.get(NutrientB) > Nutrients.get(NutrientA) && Nutrients.get(NutrientB) > Nutrients.get(NutrientC))
        {
          Nutrients.set(NutrientB, Nutrients.get(NutrientB) + (Nutrients.get(NutrientB) * .5));
        }
        else if (Nutrients.get(NutrientC) > Nutrients.get(NutrientB) && Nutrients.get(NutrientC) > Nutrients.get(NutrientA))
        {
          Nutrients.set(NutrientC, Nutrients.get(NutrientC) + (Nutrients.get(NutrientC) * .5));
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
        if(removePart < Nutrients.get(NutrientA))
        {
          Nutrients.set(NutrientA, Nutrients.get(NutrientA) - removePart);
        }
      break;
      case 1:
        if(removePart < Nutrients.get(NutrientB))
        {
          Nutrients.set(NutrientB, Nutrients.get(NutrientB) - removePart);
        }
      break;
      case 2:
        if(removePart < Nutrients.get(NutrientC))
        {
          Nutrients.set(NutrientC, Nutrients.get(NutrientC) - removePart);
        }
      break;
    }
    removeAmount -= removePart;
  }
}