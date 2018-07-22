static class MapValues
{
  static int Height;
  static int Width;
  static int CellSize;
  static int BreedingCooldown;
  static int NumOfCreatures;
  static int NumOfPlants;
  
  public static void Init(int _height, 
    int _width, 
    int cellSize,
    int breedingCD,
    int numOfCreatures,
    int numOfPlants)
  {
    MapValues.Height = _height;
    MapValues.Width = _width;
    MapValues.CellSize = cellSize;
    MapValues.BreedingCooldown = breedingCD;
    MapValues.NumOfCreatures = numOfCreatures;
    MapValues.NumOfPlants = numOfPlants;
  }
}