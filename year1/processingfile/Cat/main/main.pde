import shiffman.box2d.*;

import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;
import java.util.Iterator;
Box2DProcessing box2d;
ArrayList<Food> foods;
Cat cat;
Food f;
Boundary floor;
Boundary wall_L;
Boundary wall_R;
Vec2 wind;
int count = 0;

void setup(){
  size(920,1280);
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.listenForCollisions();
  box2d.setGravity(0,-9.8*2);
  cat = new Cat();
  foods = new ArrayList<Food>();
  floor = new Boundary(width/2,height+100,width,height);// x,y,w,h location and size
  wall_L = new Boundary(0,0,10,height*2);
  wall_R = new Boundary(width,0,10,height*2);
  
}
void draw(){
  wind = new Vec2(random(-10*2,10*2),0);
  Vec2 move = new Vec2(random(-300*2,300*2),random(15*5,30*5));
  //println(move);
  box2d.step();
  background(255);
  floor.display();
  wall_L.display();
  wall_R.display();
  
  cat.run();
  cat.applyForce(move);
  
  Iterator<Food> it = foods.iterator();
  while (it.hasNext()) {
    Food f = it.next();
    f.run();
    f.applyForce(wind);
    if(keyPressed){
      if(key == 'k'){ //reset food
        f.killBody();
      }
    }
    if (f.isExpired()) {
      it.remove();
    }
  }
  
}

void mousePressed(){
  f = new Food();
  foods.add(f);
}

void beginContact(Contact cp){
  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();
  
  Body b1 = f1.getBody();
  Body b2 = f2.getBody();
  
  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();
  
  if(o1.getClass() == Cat.class && o2.getClass() == Food.class){
    Cat c = (Cat) o1;
    count+=1;
    if(count%4 == 3){
      c.upSize();
    }
    Food f = (Food) o2;
    f.killBody();
  }
}

void endContact(Contact cp){
  
}

void removeContact(Contact cp){

}

//void keyPressed(){
//  if(key == 'k'){
//    f.killBody();
//  }
//}
