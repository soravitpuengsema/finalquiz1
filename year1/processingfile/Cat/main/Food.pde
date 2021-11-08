class Food{
  Body body;
  Vec2 location;
  Vec2 velocity;
  Vec2 acceleration;
  float lifespan;
  float w,h;
  float r;
  
  Food(){
    w = 7*2;
    h = 19*2;
    r = 7*2;
    
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    location = bd.position.set(box2d.coordPixelsToWorld(random(width),random(0,height-(300*2))));
    velocity = new Vec2(0,0);
    acceleration = new Vec2(0,0.02);
    lifespan = 255.0;
    body = box2d.createBody(bd);
    
    PolygonShape ps = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    ps.setAsBox(box2dW,box2dH);
    
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r);
    
    FixtureDef fd = new FixtureDef();
    fd.shape = ps;
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.5;
    
    body.createFixture(fd);
    body.createFixture(cs,1.0);
    
    body.setUserData(this);
    //fd.setUserData("Food");
  }
  
  
  void run(){
    update();
    display();
  }
  
  
  void update(){
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mulLocal(0);
    lifespan -= 0.8;
    if(lifespan <= 0){
      box2d.destroyBody(body);
    }
  }
  
  
  void display(){
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();  
    rectMode(CENTER);
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(-a);
    fill(175,lifespan);
    stroke(0,lifespan);
    rect(0,0,w,h);
    ellipse(0,-h/2,r*2,r*2);
    popMatrix();
  }
  
  
  void applyForce(Vec2 force){
    Vec2 pos = body.getWorldCenter();
    body.applyForce(force,pos);
  }
  
  
  boolean isExpired(){
    if(lifespan <= 10.0){
      return true;
    }
    else{
      return false;
    }
  }


  void killBody(){
    lifespan = 0;
    try{
      box2d.world.destroyBody(body);
    }
    catch(AssertionError e){      
    }
  }
}
