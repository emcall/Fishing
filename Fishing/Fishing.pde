//some notes
//speed is currently a static val and is going to cause problems. need to make it better
//still need collision detection obvs. put that in process fish i assume


import java.util.*;

Serval myGirl = new Serval();
PImage kitty;
int score;
public ArrayList<Fish> fishes = new ArrayList<Fish>();


static final int TOPEDGE = 10;
static final int BOTTOMEDGE = 500;
static final int RIGHTEDGE = 500;


//setup is where all images are loaded
void setup(){
      kitty = loadImage("/meow.png");  
      size(800, 800);
}//end setup

//draw is the main loop i think?
void draw(){
     background(0);

    processFish();
    myGirl.drawServal(kitty);
}//end draw

void keyPressed(){
     if(key == 'a'){
        myGirl.moveServal(-3);
     }//end key a
   
     else if(key == 'd'){
        myGirl.moveServal(3);
     }//end key d
   
     else if(key == 's'){
       myGirl.diving = true;
      }//end key s
      
}//end keypressed


class Serval{
  int xPos;
  int yPos;
  boolean diving;
  boolean surfacing;
  int speed;
  Serval(){
      xPos = 10;
      yPos = 10;
      diving = false;
      surfacing = false;
      speed = 100;
   }//end serval()
  //overload
  Serval(int x, int y){
     xPos = x;
     yPos = y;
     diving = false;
     surfacing = false;
     speed = 100;
     
  }//end serval(x,y)
  
  void moveServal(int xMove){
      xPos = xPos+xMove;
  }//end moveserval
 
  void dive(){
    if (diving == true){
      
      //if not surfacing she needs to keep going down, otherwise g backup
      if (surfacing == false){
        
       if(yPos <= BOTTOMEDGE){
          yPos+= speed/10;
          speed--;
      yPos++;
       }//end if not at bottom
       else{
         surfacing = true;
         speed = 100;
       }//end at/below at bottom
       
      }//end if diving true
      
      else{
       if (yPos <= TOPEDGE){
           diving = false;
           surfacing = false;
           speed = 100;
       }//end if at top
       else{
        yPos -= speed/10;
        if (speed >10){
          speed--;
        }
       }
      }//end if surfacing true
      
    }//end if diving true
  }//end dive()
  
  
  void drawServal(PImage img){
    
    //check on what she's doing
    
    dive();
    
    image(img, xPos, yPos);
  }//end drawserval
  
  
}//end serval

public class Fish{
 int xPos;
 int yPos;
 int speed;
  
  Fish(int x, int y, int spd){
   xPos = x;
   yPos = y;
   speed = spd;
 }//end constructor
  
  boolean moveFish(){
    if(xPos == RIGHTEDGE){
      return true;
      //this bit is to let the draw loop know it hit an edge and needs deleting
    }//end if
    else{
     xPos += 1; 
     return false;
    }
    
  }//end move
   
  
  void drawFish(){
   rect(xPos, yPos, 20, 20); 
  }
  
}//end fish

void processFish(){
  
  //first let's see if we wanna add somebody
   if((Math.random()<.01)){
    fishes.add(new Fish(1, (int)(Math.random()*400), 1)); 
    System.out.println("added");
   }//end if
   
   //now let's go through and see if anyone hit the edge of the screen
  for (Iterator<Fish> iterator = fishes.iterator(); iterator.hasNext();) {
    Fish fish = iterator.next();
    if(fish.moveFish()){
     iterator.remove(); 
    }
    else{
     fish.drawFish(); 
    }
    
  }//end iterator loop
     
   
   
}//end newfish