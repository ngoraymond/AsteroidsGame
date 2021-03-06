//your variable declarations here
public int bulletTotal=0;
public int mineTotal=0;
public SpaceShip bob;
public ArrayList <Rock> phil;
public ArrayList <Bullet> bill;
public ArrayList <BadShip> enemy;
public ArrayList <Bullet> enemyBullet;
public Star[] castor;
boolean SplashScreen=true;
boolean endScreen=false;
boolean cheats=false;
boolean risingSun=false;
int level=1;
int shipscore=0;
int risingMoon = 5;
public void setup() 
{
  //your code here
  //fullScreen();
  size(1600,900);
  fill(0);
  bob = new SpaceShip();
  phil= new ArrayList <Rock>();
  enemy = new ArrayList<BadShip>();
  enemyBullet = new ArrayList<Bullet>();
  enemy.add(new BadShip());
  castor = new Star[200];
  for(int i = 0;i<15;i++)
  {
  phil.add(new Rock());
  }
  bill=new ArrayList <Bullet>();
  for(int i=0;i<castor.length;i++){
    castor[i]=new Star();
  }
}
public void draw() 
{
  //your code here
   if(SplashScreen==true){
    background(255);
    fill(0);
    textSize(30);
    textAlign(CENTER, TOP);
    text("Asteroids",width/2,100);
    textSize(50);
    text("Click to begin",width/2,600);
    textSize(20);
    text("Press W to move forward",width/4,200);
    text("Press S to move backward + slow down",width/4,230);
    text("Press A to move left",width/4,260);
    text("Press D to move right",width/4,290);
    text("Mouse Click to fire",width/4,320);
    text("Press N to spam bullets",width/4,350);
    text("Press Space to place mines",width/4,380);
    text("Press Q to rotate left",3*width/4,200);
    text("Press E to rotate right",3*width/4,230);
    text("Press L to accelerate",3*width/4,260);
    text("Press K to accelerate backwards",3*width/4,290);
    text("Press P to teleport",3*width/4,320);
    text("Press M to level instantly",3*width/4,350);
    text("Press O for a Final Attack",3*width/4,380);
    //text("Press esc to leave",width/2,450);
    noStroke();
    noFill();
  }
  else{
  background(0);
  if(bob.getHP()<1)
  {
    endScreen=true;
  }
  if(endScreen==false){
      if(frameCount%(300/level)==0)
      {
        enemy.add(new BadShip());
      }
      if(cheats==true){
              if(mousePressed){
                bill.add(new Bullet(bob,10,"gray"));
                bulletTotal++;
              }
      }
      if(risingSun==true && mousePressed){
              for(int i=0;i<24;i++){bill.add(new Bullet(bob,10,"gray",(int)(bob.getPointDirection()+(15*i))));}
              bulletTotal+=24;
      }
      for(int i = 0; i<castor.length;i++)
      {
        castor[i].show();
        castor[i].rotate(2);
        castor[i].move();
      }
      bob.move();
      bob.show();
      for(int i = (bill.size()-1);i>=0;i--)
      {
        bill.get(i).move();
        bill.get(i).show();
        if(bill.get(i).getX()<-50 || bill.get(i).getX()>(width+50) ||bill.get(i).getY()<-50 || bill.get(i).getY()>(height+50))
                    {
                      bill.remove(i);
                    } 
      }
      for(int i=(enemy.size()-1);i>=0;i--){
          enemy.get(i).move();
          enemy.get(i).show();
          //enemy.get(i).rotate(5);
          boolean dead = false;
          if(enemy.get(i).getX()<(bob.getX()+20) && enemy.get(i).getX()>(bob.getX()-20))
                {
                          if((i+1)%5==0){enemyBullet.add(new Bullet(enemy.get(i),6,"red"));}
                          enemyBullet.add(new Bullet(enemy.get(i),6,"red",(int)(Math.random()*360)));
                            if(cheats==true || risingSun==true){
                                enemyBullet.add(new Bullet(enemy.get(i),6,"red",(int)(Math.random()*360)));
                                //enemyBullet.add(new Bullet(enemy.get(i),6,"red",(int)(Math.random()*360)));
                                //enemyBullet.add(new Bullet(enemy.get(i),6,"red",(int)(Math.random()*360)));
                              }
                          
                }
          if(dist(bob.getX(),bob.getY(),enemy.get(i).getX(), enemy.get(i).getY())<=20)
          {
            enemyBullet.add(new Bullet(enemy.get(i),6,"red"));
            bob.setHP(bob.getHP()-(10+(10*level)));
            shipscore+=200;
            enemy.remove(i);
            break;
          }
          else{
            for(int z=(bill.size()-1);z>=0;z--)
            {
                  boolean bulletDead=false;
                  if(dist(enemy.get(i).getX(), enemy.get(i).getY(),bill.get(z).getX(),bill.get(z).getY())<=20)
                      {
                        for(int k=0;k<(5+(2*level));k++){enemyBullet.add(new Bullet(enemy.get(i),6,"blood",(int)(Math.random()*360)));}
                        if(cheats==true || risingSun==true)
                        {
                          for(int k=0;k<31;k++){enemyBullet.add(new Bullet(enemy.get(i),6,"blood",(int)(Math.random()*360)));}
                        }
                        bob.setHP(bob.getHP()+(20*level));
                        shipscore+=500;
                        dead=true;
                        bulletDead=true;       
                      } 
                  if(bulletDead==true){bill.remove(z);}      
            }
          }
        if(dead==true){enemy.remove(i);}
      }
      for(int i=0;i<enemyBullet.size();i++){
        enemyBullet.get(i).move();
        enemyBullet.get(i).show();
        enemyBullet.get(i).rotate(5);
        boolean isDead=false;
        if(dist(bob.getX(),bob.getY(), enemyBullet.get(i).getX(), enemyBullet.get(i).getY())<=20)
              {
                  isDead=true;
                  bob.setHP(bob.getHP()-((3+level)*level));
                  
              }
         for(int z=(bill.size()-1);z>=0;z--)
            {
              boolean bulletDown=false;
              if(dist(enemyBullet.get(i).getX(), enemyBullet.get(i).getY(),bill.get(z).getX(),bill.get(z).getY())<=20)
                      {
                        bob.setHP(bob.getHP()+(25*level));
                        shipscore+=600;
                        isDead=true;
                        bulletDown=true;
                      }
              if(bulletDown==true){bill.remove(z);}
            }
        if(isDead==true){enemyBullet.remove(i);}

      }
      //Level Up
      if(phil.size()==0)
          {
              level++;
              risingMoon++;
              bob.setHP(bob.getHP()+(100*level));
              for(int w = 0;w<(15+(5*level));w++)
              {
                  phil.add(w, new Rock());
              }
          }  
      for(int i=(phil.size()-1);i>=0;i--)
      { 
        phil.get(i).move();
        phil.get(i).show();
        boolean dead=false;
        if(dist(bob.getX(),bob.getY(), phil.get(i).getX(), phil.get(i).getY())<20)
              {
                  bob.setHP(bob.getHP()-(10*level));
                  phil.remove(i);
                  break;
              }
        else{
          for(int z=(bill.size()-1);z>=0;z--)
          {
            boolean bulletDead = false;
            if(dist(bill.get(z).getX(),bill.get(z).getY(), phil.get(i).getX(), phil.get(i).getY())<=20)
                {
                  dead=true;
                  bob.setHP(bob.getHP()+(5*level));
                  bulletDead=true;   
                }
            if(bulletDead==true){bill.remove(z);}      
          }
          if(dead==true){phil.remove(i);}
        }
      if(level>300){endScreen=true;}  
      fill(255);
      text(bulletTotal + " bullets used (Left Click)",180,80);
      text(mineTotal + " mines placed (Spacebar)",183,110);
      text("(O key) Final Attacks remaining: "+risingMoon,5*width/6,80);
      text("HP",30,50);
      text("Level "+level,width-60,30);
      fill(255,0,0);
      rect(50,50,bob.getHP(),20);
      fill(255);
      text((int)(bob.getHP()),width/6,50);
      if(cheats==true){text("RapidFire On",width/2,150);}
      fill(255,255,0);
      if(risingSun==true){text("Sunfire On",width/2,200);}
      }
    }
    else
    {
      for(int i=0;i<enemy.size();i++){enemy.remove(i);}
      for(int i=0;i<enemyBullet.size();i++){enemyBullet.remove(i);}
      for(int i=0;i<phil.size();i++){phil.remove(i);}
      for(int i=0;i<bill.size();i++){bill.remove(i);}
      textSize(50);
      fill(255,0,0);
      text("Game Over",width/2,height/8);
      int levelScore=(level-1)*1000;
      int bulletscore=(bulletTotal*2)+(mineTotal*5);
      int score=(levelScore+shipscore)-bulletscore;
      fill(255);
      textSize(20);
      text("Click To Retry",width/2,(height/4)+50);
      textSize(50);
      if(score>-1){
        fill(0,255,0);
        }
      else 
       {
        fill(255,0,0);
       }
      if(cheats==false && risingSun==false){text("Score: "+score,width/2,3*height/4);}
      if(cheats==true || risingSun==true){text("Score: Null",width/2,3*height/4);}
    }
  }

}

public void mouseClicked(){
  if(SplashScreen==true){
    SplashScreen=false;
  }
  if(SplashScreen==false && endScreen==false){
    bill.add(new Bullet(bob,10,"gray"));
    bulletTotal++;
  }
  if(SplashScreen==false && endScreen==true){
    bob.setHP(100);
    bulletTotal=0;
    risingMoon=5;
    bob.accelerate(0);
    bob.setDirectionX(0);
    bob.setDirectionY(0);
    bob.setX(width/2);
    bob.setY(height/2);
    for(int i = 0;i<15;i++){phil.add(new Rock());}
    level=1;
    endScreen=false;
    SplashScreen=true;
  }
     
}
public void keyPressed(){
  if(key == 'w'){
    //bob.setDirectionY(bob.getPointDirection());
    bob.movely(5);
    //for(int i = 0; i<castor.length;i++){castor[i].setDirectionY(5);}
  }
  if(key == 's'){
    bob.movely(-5);
    //for(int i = 0; i<castor.length;i++){castor[i].setDirectionY(-5);}
  }
  if(key == 'a'){
    bob.setDirectionX(-3);
    //for(int i = 0; i<castor.length;i++){castor[i].setDirectionX(3);}
  }
  if(key == 'd'){
    bob.setDirectionX(3);
    //for(int i = 0; i<castor.length;i++){castor[i].setDirectionX(-3);}
    
  }
  if(key == 'q'){
    bob.rotate(-5);
    for(int i = 0;i<bill.size();i++){bill.get(i).rotate(-5);}
  }
  if(key == 'e'){
    bob.rotate(5);
    for(int i = 0;i<bill.size();i++){bill.get(i).rotate(5);}
  }
  if(key == 'l'){
   bob.accelerate(1.2);
   /*
   for(int i = 0; i<castor.length;i++){
    castor[i].setPointDirection((int)(bob.getPointDirection()));
    castor[i].accelerate(1.2);
    }
    */
  }
  if(key == 'o'){
    if(risingMoon>0)
      {
          for(int i=0;i<72;i++){bill.add(new Bullet(bob,10,"gray",(int)(bob.getPointDirection()+(5*i))));}
          risingMoon--;
      }
  }
  if(key == 'k'){
     bob.accelerate(-0.3);
     /*
     for(int i = 0; i<castor.length;i++){
        castor[i].setPointDirection((int)(bob.getPointDirection()));
        castor[i].accelerate(-0.3);
       }
      */
  }
  if(key == 'p'){
     bob.setX((int)(Math.random()*width));
     bob.setY((int)(Math.random()*height));
     bob.accelerate(0);
     bob.setDirectionX(0);
     bob.setDirectionY(0);
     bob.setPointDirection((int)(Math.random()*360));
  }
  if(key == 'm'){
    for(int i=0;i<phil.size();i++){
      phil.remove(i);
    }

  }
  if(key == 'n'){
    if(cheats==false)
        cheats=true;
    else  
        cheats=false;
    }
    if(key == 'b'){
    if(risingSun==false)
        risingSun=true;
    else  
        risingSun=false;
    }
  if(risingSun==true)
    {
    if(key == ' '){
          bill.add(new Bullet(bob,0,"orange"));
          mineTotal++;
        }
    }
  }
  public void keyReleased() {
    if(cheats==false)
    {
     if(key == ' '){
          bill.add(new Bullet(bob,0,"orange"));
          mineTotal++;
        }
    }
  }
class SpaceShip extends Floater  
{   
    //your code here
  public void setX(int x){myCenterX=x;}
  public int getX(){return (int)myCenterX;}
  public void setY(int y){myCenterY=y;}
  public int getY(){return (int)myCenterY;}
  public void setDirectionX(double x){myDirectionX=x;}   
  public double getDirectionX(){return myDirectionX;}  
  public void setDirectionY(double y){myDirectionY=y;} 
  public double getDirectionY(){return myDirectionY;}   
  public void setPointDirection(int degrees){myPointDirection=degrees;}   
  public double getPointDirection(){return myPointDirection;} 
  //HP
  private float hp;
  public float getHP(){return hp;}
  public void setHP(float z){hp=z;}
  public SpaceShip()
  {
    corners=6;
    int[] xShape = {16,20,-24,0,-24,20};
    int[] yShape = {0,4,16,0,-16,-4}; 
    xCorners = xShape;
    yCorners = yShape;
    myPointDirection=-90;
    myDirectionY=0;
    //myCenterY=height-50;
    myCenterY=height/2;
    myCenterX=width/2;
    myColor=color(255,255,255);
    hp=100;

  }
   public void movely(int dAmount)   
  {          
    double dRadians =myPointDirection*(Math.PI/180);     
    myDirectionX = ((dAmount) * Math.cos(dRadians));    
    myDirectionY = ((dAmount) * Math.sin(dRadians));       
  } 
} 
  class BadShip extends SpaceShip
{
  public BadShip()
  {
    myColor=color(0,0,255);
    myPointDirection=90;
    myDirectionY=3;
    myCenterX=((float)(Math.random()*width));
    myCenterY=(float)(Math.random()*height);
  }
}

  class Rock extends Floater  
{   
    //your code here
  public void setX(int x){myCenterX=x;}
  public int getX(){return (int)myCenterX;}
  public void setY(int y){myCenterY=y;}
  public int getY(){return (int)myCenterY;}
  public void setDirectionX(double x){myDirectionX=x;}   
  public double getDirectionX(){return myDirectionX;}  
  public void setDirectionY(double y){myDirectionY=y;} 
  public double getDirectionY(){return myDirectionY;}   
  public void setPointDirection(int degrees){myPointDirection=degrees;}   
  public double getPointDirection(){return myPointDirection;} 
  private int rotateSpeed;
  public Rock()
   {
    corners=6;
    int[] xShape = {-12,12,24,12,-12,-24};
    int[] yShape = {-24,-24,0,24,24,0}; 
    xCorners = xShape;
    yCorners = yShape;
    myPointDirection=(int)(Math.random()*360);
    myDirectionY=(int)(Math.random()*3)-1;
    myDirectionX=(int)(Math.random()*3)-1;
    myCenterY=(int)(Math.random()*height);
    myCenterX=(int)(Math.random()*width);
    myColor=color(255,0,255,50);
    rotateSpeed=3;

  }
   public void move()   
  {      
    super.rotate(rotateSpeed);
    super.move();   
  }   
}
class Bullet extends Floater
{
  public void setX(int x){myCenterX=x;}
  public int getX(){return (int)myCenterX;}
  public void setY(int y){myCenterY=y;}
  public int getY(){return (int)myCenterY;}
  public void setDirectionX(double x){myDirectionX=x;}   
  public double getDirectionX(){return myDirectionX;}  
  public void setDirectionY(double y){myDirectionY=y;} 
  public double getDirectionY(){return myDirectionY;}   
  public void setPointDirection(int degrees){myPointDirection=degrees;}   
  public double getPointDirection(){return myPointDirection;} 
  private color myColor;
  private double dAmount;
  public Bullet(SpaceShip bob,double x, String text)
  {
    myPointDirection=bob.getPointDirection();
    myCenterX=bob.getX();
    myCenterY=bob.getY();
    dAmount=x;
    if(x>0)
        {
          double dRadians =myPointDirection*(Math.PI/180);     
          myDirectionX = ((dAmount+bob.getDirectionX()) * Math.cos(dRadians));    
          myDirectionY = ((dAmount+bob.getDirectionX()) * Math.sin(dRadians));
        }
    if(text=="gray"){myColor=color(200,200,200);}
    else if(text=="red"){myColor=color(255,0,0);}
    else{myColor=color(204,161,8);}
  }
  public Bullet(SpaceShip bob,double x, String text,int degrees)
  {
    myPointDirection=degrees;
    myCenterX=bob.getX();
    myCenterY=bob.getY();
    dAmount=x;
    if(x>0)
        {
          double dRadians =myPointDirection*(Math.PI/180);     
          myDirectionX = ((dAmount+bob.getDirectionX()) * Math.cos(dRadians));    
          myDirectionY = ((dAmount+bob.getDirectionX()) * Math.sin(dRadians));
        }
    if(text=="gray"){myColor=color(200,200,200);}
    else if(text=="red"){myColor=color(255,0,0);}
    else if(text=="blood"){myColor=color(104,2,2);}
    else{myColor=color(204,161,8);}
  }
  public void show(){
    fill(myColor);   
    noStroke();
    ellipse((int)myCenterX,(int)myCenterY,10,10);     
  }
  public void move(){
    if(myColor==color(104,2,2))
    {
      double dRadians =myPointDirection*(Math.PI/180);     
      myDirectionX = ((dAmount+bob.getDirectionX()) * Math.cos(dRadians));    
      myDirectionY = ((dAmount+bob.getDirectionX()) * Math.sin(dRadians));
    }
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;
  }
}
class Star extends Floater{
  public void setX(int x){myCenterX=x;}
  public int getX(){return (int)myCenterX;}
  public void setY(int y){myCenterY=y;}
  public int getY(){return (int)myCenterY;}
  public void setDirectionX(double x){myDirectionX=x;}   
  public double getDirectionX(){return myDirectionX;}  
  public void setDirectionY(double y){myDirectionY=y;} 
  public double getDirectionY(){return myDirectionY;}   
  public void setPointDirection(int degrees){myPointDirection=degrees;}   
  public double getPointDirection(){return myPointDirection;} 
  public Star(){
    corners=8;
    int[] xShape = {0,1,5,1,0,-1,-5,-1};
    int[] yShape = {-5,-1,0,1,5,1,0,-1}; 
    xCorners = xShape;
    yCorners = yShape;
    myPointDirection=0;
    myDirectionY=0;
    myCenterY=(int)(Math.random()*height);
    myCenterX=(int)(Math.random()*width);
    myColor=color(255,255,0,(int)(Math.random()*200));
  }
}
abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected int myColor;   
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x);  
  abstract public int getX();   
  abstract public void setY(int y);   
  abstract public int getY();   
  abstract public void setDirectionX(double x);   
  abstract public double getDirectionX();   
  abstract public void setDirectionY(double y);   
  abstract public double getDirectionY();   
  abstract public void setPointDirection(int degrees);   
  abstract public double getPointDirection(); 

  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate (double dAmount)   
  {          
    //convert the current direction the floater is pointing to radians    
    double dRadians =myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myDirectionX += ((dAmount) * Math.cos(dRadians));    
    myDirectionY += ((dAmount) * Math.sin(dRadians));       
  }   
  public void rotate (int nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;   
  }   
  public void move ()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     

    //wrap around screen    
    if(myCenterX >width)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX<0)
    {     
      myCenterX = width;    
    }    
    if(myCenterY >height)
    {    
      myCenterY = 0;    
    }   
    else if (myCenterY < 0)
    {     
      myCenterY = height;    
    }   
  }   
  public void show ()  //Draws the floater at the current position  
  {             
    fill(myColor);   
    stroke(myColor);    
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();         
    for(int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated,yRotatedTranslated);    
    }   
    endShape(CLOSE);  
  }   
} 

