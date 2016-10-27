//your variable declarations here
public int numBulletUsed=0;
public SpaceShip bob;
public Rock[] phil;
public Bullet[] bill;
public Star[] castor;
public boolean SplashScreen=true;
public void setup() 
{
  //your code here
  size(800,600);
  fill(0);
  bob = new SpaceShip();
  phil= new Rock[10];
  bill= new Bullet[20];
  castor = new Star[200];
  for(int i = 0;i<phil.length;i++)
  {
  phil[i] = new Rock();
  }
  for(int i = 0;i<bill.length;i++)
  {
    bill[i]=new Bullet();
  }
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
    textSize(20);
    text("Press W to move forward",width/4,200);
    text("Press S to move backward + slow down",width/4,230);
    text("Press A to move left",width/4,260);
    text("Press D to move right",width/4,290);
    text("Mouse Click to fire",width/4,320);
    text("Press Q to rotate left",3*width/4,200);
    text("Press E to rotate right",3*width/4,230);
    text("Press L to accelerate",3*width/4,260);
    text("Press K to accelerate backwards",3*width/4,290);
    text("Press P to teleport",3*width/4,320);

    noStroke();
    noFill();
  }
  else{
  background(0);
  for(int i = 0; i<castor.length;i++)
  {
    castor[i].show();
    castor[i].rotate(2);
    castor[i].move();
  }
  for(int i = 0;i<bill.length;i++)
  {
    bill[i].show();
    bill[i].move();
  }
  for(int i = 0; i<phil.length;i++)
  {
  phil[i].move();
  phil[i].show();
  }
  bob.move();
  bob.show();
  double theDir=(Math.atan2(mouseY-(bob.getY()),mouseX-(bob.getX()))*(180/Math.PI));
  //bob.setPointDirection((int)theDir);
  }

}
public void mouseClicked(){
  if(SplashScreen==true){
    SplashScreen=false;
    redraw();
  }
  if(SplashScreen==false){
    bill[numBulletUsed].setPointDirection((int)(bob.getPointDirection()));
    bill[numBulletUsed].setY(bob.getY());
    bill[numBulletUsed].setX(bob.getX());
    bill[numBulletUsed].movely(10);

    numBulletUsed++;
     if(numBulletUsed==bill.length){numBulletUsed=0;}
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
    for(int i = 0;i<bill.length;i++){bill[i].rotate(-5);}
  }
  if(key == 'e'){
    bob.rotate(5);
    for(int i = 0;i<bill.length;i++){bill[i].rotate(5);}
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
  public SpaceShip()
  {
    corners=6;
    int[] xShape = {16,20,-24,0,-24,20};
    int[] yShape = {0,4,16,0,-16,-4}; 
    xCorners = xShape;
    yCorners = yShape;
    myPointDirection=-90;
    myDirectionY=0;
    myCenterY=height-50;
    myCenterX=width/2;
    myColor=color(255,255,255);

  }
   public void movely(int dAmount)   
  {          
    double dRadians =myPointDirection*(Math.PI/180);     
    myDirectionX = ((dAmount) * Math.cos(dRadians));    
    myDirectionY = ((dAmount) * Math.sin(dRadians));       
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
    corners=3;
    int[] xShape = {-24,24,-24};
    int[] yShape = {-24,0,24}; 
    xCorners = xShape;
    yCorners = yShape;
    myPointDirection=(int)(Math.random()*360);
    myDirectionY=(int)(Math.random()*3)-1;
    myDirectionX=(int)(Math.random()*3)-1;
    myCenterY=(int)(Math.random()*height);
    myCenterX=(int)(Math.random()*width);
    myColor=color(255,0,255,50);
    rotateSpeed=(int)(Math.random()*5)-2;

  }
   public void move ()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY   
    myPointDirection+=rotateSpeed;
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     
    //wrap around screen    
    if(myCenterX >width){myCenterX = 0;}    
    else if (myCenterX<0){myCenterX = width;}    
    if(myCenterY >height){myCenterY = 0;}   
    else if (myCenterY < 0){myCenterY = height;}   
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
  public Bullet()
  {
    corners=4;
    int[] xShape = {-1,1,1,-1};
    int[] yShape = {-1,-1,1,1}; 
    xCorners = xShape;
    yCorners = yShape;
    myPointDirection=-90;
    myDirectionY=0;
    myCenterY=-10;
    myCenterX=-10;
    myColor=color(200,200,200);

  }
   public void movely(int dAmount)   
  {          
    double dRadians =myPointDirection*(Math.PI/180);     
    myDirectionX = ((dAmount) * Math.cos(dRadians));    
    myDirectionY = ((dAmount) * Math.sin(dRadians));       
  } 
  public void show(){
    fill(myColor);   
    stroke(myColor);
    ellipse((int)myCenterX,(int)myCenterY,10,10);     
  }
  public void move(){
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

