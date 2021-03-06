interface ICreature
{
    int Get_apetite();
    void Set_apetite(int value);
    float Get_hunger();
    void Set_hunger(float value);
    
    FloatList Get_nutrients();
    void Set_Nutrients(FloatList value);
    void Set_nutrients_value(int index, float value);
    void Add_nutrients(int index, float value);
    float Get_Total_Nutrients();
    
    int Get_height();
    void Set_height(int value);
    int Get_width();
    void Set_width(int value);
    
    int Get_color1();
    void Set_color1(int value);
    int Get_color2();
    void Set_color2(int value);
    int Get_color3();
    void Set_color3(int value);
    
    int Get_breedingCooldown();
    void Set_breedingCooldown(int value);

    boolean IsHungry();

    int healthBarWidth = 20;
  
    int DeathCounter = 100;

    <T extends Creature> T NewCreature(int Height, int Width, int breedingCD);
    boolean Eat(Cell cell);
    void Move();
    void Tick(Cell cell);
    void Rot(Cell cell);
    void Draw();
    boolean isDead();
    ICreature Breed(ICreature creature);
    int Suitability();
    String ToString();
}

abstract class Creature implements ICreature
{
  int apetite;
  float hunger;
  FloatList Nutrients;
  float hungryLevel;
  
  int _height;
  int _width;
  
  int color1;
  int color2;
  int color3;
  
  //Genome
  int   BreedingCooldown;
  float BreedingChance;
  int   OldAge;
  float EatEfficiency;

  int A_Min_Healthy;
  int A_Max_Healthy;
  int B_Min_Healthy;
  int B_Max_Healthy;
  int C_Min_Healthy;
  int C_Max_Healthy;

  int MaxHealth;
  int CurrentHealth;
  
  float MoveCost;
  int FitnessScore;

  int TimeAlive;
  int ChildrenSpawned;
  int TimeInHealthyZone;
  boolean DeadFlag;

}