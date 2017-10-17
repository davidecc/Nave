import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;
import processing.sound.*;

PImage fondo1;
PImage fondo2;
SoundFile file;
Box2DProcessing box2d;

   Box box;

ArrayList<Particle> particles;
int pantalla=0;

//TIEMPO
int tiempoTranscurrido;
int tiempoDesdeInicio;
int limiteDeTiempo = 60000;



Spring spring;

// Perlin noise values
float xoff = -0.1;
float yoff = -0.1;


void setup() {
  size(1000, 700);
  fondo1 = loadImage("2.jpg");
  fondo2 = loadImage("4.jpg");
  smooth();

  file = new SoundFile(this, "cancion8bits.mp3");
  file.loop();
  
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, -7);

  
  box2d.world.setContactListener(new CustomListener());

  box = new Box(width/2, height/2);
    
  spring = new Spring();
  spring.bind(width/2, height/2, box);
    
  particles = new ArrayList<Particle>();
  
  

  
  
}

void draw() {
  switch (pantalla)
  {
  case 0:
    image(fondo1,0,0);    
    pushMatrix();
    translate(150, 0);
    textSize(30);
    fill(255);
    text("LLUVIA DE PARTICULAS", 250, 400);
    text("PRESIONE FLECHA ARRIBA PARA CONTINUAR", 50, 300);
    popMatrix();
    break;

  case 1:
    image(fondo2,0,0);
    pushMatrix();
    translate(0,0);
    fill(0);
    String s = "CON CLICK ARRASTRADO, ESQUIVA TANTAS PARTICULAS COMO PUEDAS EN 1 MINUTO PARA GANAR. AL TOCAR LAS PARTÍCULAS AUMENTA EL TAMAÑO DE TU NAVE, NO LA DEJES CRECER DEMASIADO O PERDERAS.             PRESIONE FLECHA ABAJO PARA CONTINUAR.";
    text(s, 200, 250, 600, 500);
    popMatrix();
    break;

  case 2:
     background(random(50,100));
     
     //número de partículas
     if (random(1) < 0.2) {
      float sz = random(5, 12);
      particles.add(new Particle(random(100,900),random(100,600), sz));
    }
    
    box2d.step();

  
  
    // Make an x,y coordinate out of perlin noise
    float x = noise(xoff)*width;
    float y = noise(yoff)*height;
    xoff += 0.01;
    yoff += 0.01;


    // Instead update the spring which pulls the mouse along
    if (mousePressed) {
      spring.update(mouseX, mouseY);
    } else {
      spring.update(x, y);
    }
    
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.display();
      
     if (p.done()) {
        particles.remove(i);
      }
    }

    box.display();

tiempoTranscurrido = millis() - tiempoDesdeInicio;
  if (tiempoDesdeInicio > 0){
    fill(255,0,0);
    text(tiempoTranscurrido/1000,800,50);
  //println(millis() - tiempoDesdeInicio);
  }
    
  if (millis() - tiempoDesdeInicio > limiteDeTiempo){
    background(0);
    textSize(30);
    fill(random(0,255));
    stroke(255);
    text("YOU WIN", 270, 380);
    fill(200,150,150);
    stroke(255);
    text("PRESS ENTER TO PLAY AGAIN", 110, 480);
    
}
    break;
    
    case 3:
    background(255);
    pushMatrix();
    translate(200,0);
    textSize(30);
    fill(200,150,150);
    stroke(255);
    text("YOU LOSE", 270, 380);
    fill(200,150,150);
    stroke(255);
    text("PRESS ENTER TO PLAY AGAIN", 110, 480);
    popMatrix();
    break;
  }
}

void keyPressed()
{
  if (keyCode==UP)
  {
    pantalla=1;
  }
  
  if (keyCode==DOWN)
  {
    pantalla=2;
  }
  
  if (keyCode==DOWN)
  {
    tiempoDesdeInicio = millis();   
  }
  if (keyCode==ENTER)
  {
    pantalla=0;
  }
}