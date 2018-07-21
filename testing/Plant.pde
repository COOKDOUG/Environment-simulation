//Plants should act as a resource producer

abstract class Plant
{
    int ResourceProduced;
    int ProductionCooldown;
    float ProductionAmount;
    
    int Height;
    int Width;
    
    int prodCD;
    
    Plant()
    {
      Init();
    }
    
    Plant(int _height, int _width)
    {
      Init();
      this.Height = _height;
      this.Width = _width;
    }
    
    private void Init()
    {
      ResourceProduced = int(random(3));
      ProductionAmount = random(10);
      ProductionCooldown = int(random(Constants.PlantCDMin, Constants.PlantCDMax +1)); 
      prodCD = ProductionCooldown;
    }
    
    void Tick(Cell cell)
    {
      if(prodCD <= 0)
      {
        if(true)//cell.CanAddNutrient(ResourceProduced))
        {
          println(ProductionAmount);
          cell.Nutrients.add(ResourceProduced, ProductionAmount);
          prodCD = ProductionCooldown;
        }
      }
      else
      {
        prodCD --;
      }
    }
    
    abstract void Draw();
}