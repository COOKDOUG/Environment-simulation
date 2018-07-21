class Fern extends Plant
{
  Fern(int _height, int _width)
  {
    super(_height, _width);
  }
  
  void Draw()
  {
    switch(this.ResourceProduced)
    {
      case 0:
      fill(200, 0, 0);
      break;
      case 1:
      fill(0, 200, 0);
      break;
      case 2:
      fill(0, 0, 200);
      break;
    }
    rect(Height * MapValues.CellSize+ MapValues.CellSize /2, Width * MapValues.CellSize+ MapValues.CellSize /2, MapValues.CellSize -2, MapValues.CellSize -2);
  }
}