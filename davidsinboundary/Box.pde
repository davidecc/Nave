class Box {

  Body body;
  float w;
  float h;

  Box(float x_, float y_) {
    float x = x_;
    float y = y_;
    w = 18;
    h = 24;

    makeBody(new Vec2(x, y), w, h);
    body.setUserData(this);
  }

  
  void killBody() {
    box2d.destroyBody(body);
  }

  boolean contains(float x, float y) {
    Vec2 worldPoint = box2d.coordPixelsToWorld(x, y);
    Fixture f = body.getFixtureList();
    boolean inside = f.testPoint(worldPoint);
    return inside;
  }

  
  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
   
    float a = body.getAngle();

   
    pushMatrix();
    ellipseMode(PConstants.CENTER);
    rectMode(PConstants.CENTER);
    translate(pos.x, pos.y);
    rotate(-a);
    fill(175);
    stroke(0);
    ellipse(0, 0, w, h);
    fill(80,20,255);
    rect(0,0,w/2,h/2);
    rect(0,w/2,w/2,h/2);
    popMatrix();
  }

   void makeBody(Vec2 center, float w_, float h_) {
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));
    body = box2d.createBody(bd);

    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w_/2);
    float box2dH = box2d.scalarPixelsToWorld(h_/2);
    sd.setAsBox(box2dW, box2dH);

    
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    // Parameters that affect physics
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.5;

    body.createFixture(fd);
    
    body.setLinearVelocity(new Vec2(random(-5, 5), random(2, 5)));
    body.setAngularVelocity(random(-5, 5));
  }

  void crecer() {
    w = w * 1.3;
    h = h * 1.3;
    
    if(w > 500 ){
      pantalla=3;
      w= 18;
      h=24;
    }
  }
}