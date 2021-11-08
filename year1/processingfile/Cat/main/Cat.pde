class Cat{
  BodyDef bd = new BodyDef();
  Body body;
  Vec2 location;
  //Vec2 velocity;
  //Vec2 acceleration;
  Vec2 move;
  float r;
  color col = color(175);
  
  Cat(){
    r = 10*2;
    //BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    location = bd.position.set(box2d.coordPixelsToWorld(mouseX,mouseY));
    //velocity = new Vec2(100,0);
    //acceleration = new Vec2(0,0);
    move = new Vec2(mouseX,mouseY);
    body = box2d.createBody(bd);
    
    CircleShape cat_head = new CircleShape();
    cat_head.m_radius = box2d.scalarPixelsToWorld(r);
    
    //CircleShape cat_body = new CircleShape();
    //cat_body.m_radius = box2d.scalarPixelsToWorld(r);
    FixtureDef fd = new FixtureDef();
    fd.shape = cat_head;
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.5;
    
    body.createFixture(fd);    
    //body.createFixture(cat_body,1.0);
    body.setUserData(this);
    //fd.setUserData("Cat");
  }
  
  
  void run(){
    move.set(mouseX,mouseY);
    location.set(move);
    display();
    println(mouseX,mouseY);
  }
  
  
  void upSize(){
    r+=1;
    if(r>=15){
      col = color(0,255,0);
      r=15;
    }
  }
  
  
  void applyForce(Vec2 force){
    Vec2 pos = body.getWorldCenter();
    body.applyForce(force,pos);
  }
  
  
  void update(){
    //acceleration.add(new Vec2(random(-width,width),0));
    //velocity.add(acceleration);
    //location.add(velocity);
  }
  
  
  void display(){
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    
    rectMode(CENTER);
    pushMatrix();
    translate(pos.x,pos.y);
    //rotate(-a);
    fill(col);
    stroke(0);
    strokeWeight(2);
    ellipse(0,0,r*2,r*2);
    line(0, 0, r, 0);
    //ellipse(r-25,0,r*2,r*2);
    popMatrix();
  }
}
