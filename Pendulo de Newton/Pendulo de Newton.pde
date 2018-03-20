import shiffman.box2d.*;
import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;
Box2DProcessing box2d;
import ddf.minim.*;
Body body;

final int base = 235; 
final int Distancia = 125;  // entre esferas
//
PVector posVector1 = new PVector(); // esfera de la izquierda
PVector posVector2 = new PVector(); // esfera de la derecha
//
int stringLength=210;
//
float rotationAngle = 90;
float rotationAngleAdd = 1.7; 
//
int phase = 0;

int screen;
//
void setup() {
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
box2d.listenForCollisions();

  size (900, 300);
  screen=1;
  smooth();
  fill(random(155), random(0), random(255));
  stroke(255, 0, 0);
  strokeWeight(5);
  //noStroke();
  posVector1.set (stringLength * cos(radians(rotationAngle)),
  stringLength * sin(radians(rotationAngle)),
  0);
  posVector2.set (stringLength * cos(radians(rotationAngle)),
  stringLength * sin(radians(rotationAngle)),
  0);
}

void draw() {
  background(255);
  // para probar la colisión 
  println(phase);
  
  background(200);
  if (screen==1) {
    {
      textAlign(CENTER);
      textSize(50);
      fill(255);
      text("Pendulo de Newton", 400, 100);
      textSize(20);
      fill(0);
      text("Comienza con v :)", 400, 200);
      
      if (key == 'v') {
        screen = 2;
      }
    }
  }
if (screen==2) {

  
  // angulo para ambas esferas
  rotationAngle += rotationAngleAdd;
  
  switch (phase) {
  case 0:
    // esfera izquierda yendo hacía la izquierda
    posVector1.set (stringLength * cos(radians(rotationAngle)),
    stringLength * sin(radians(rotationAngle)),
    0);
    if (rotationAngle>130) 
    { rotationAngleAdd = -abs(rotationAngleAdd); // negativo: va a la derecha
      phase=1;
    }
    break;
  case 1:
    // esfera izquierda yendo a la derecha
    posVector1.set (stringLength * cos(radians(rotationAngle)),
    stringLength * sin(radians(rotationAngle)),
    0);
    if (rotationAngle<=90) {
      rotationAngleAdd = -abs(rotationAngleAdd); // positivo: va a la izquierda
      phase=2;
    }
    break;
  case 2:
    // esfera derecha yendo a la derecha
    posVector2.set (stringLength * cos(radians(rotationAngle)),
    stringLength * sin(radians(rotationAngle)),
    0);
    if (rotationAngle<=40) {
      rotationAngleAdd = abs(rotationAngleAdd); 
      phase=3;
    }   
    break;
  case 3:
    // esfera derecha yendo a la izquierda
    posVector2.set (stringLength * cos(radians(rotationAngle)),
    stringLength * sin(radians(rotationAngle)),
    0);
    if (rotationAngle>=90) {
      rotationAngleAdd = abs(rotationAngleAdd); 
      phase=0; 
    }   
   
  } 
 
  // dibujo las esferas estaticas
  
  line(base+Distancia, 0, base+Distancia, 150 );
  line(base+2*Distancia, 0, base+2*Distancia, 150);
  ellipse(base+Distancia, 210, Distancia, Distancia);
  ellipse(base+2*Distancia, 210, Distancia, Distancia);
  
  
  // dibujo las esferas en movimiento
  // moviendo la esfera izquierda
  line (base, 0, base+posVector1.x, posVector1.y );
  ellipse(  base+posVector1.x, posVector1.y, Distancia, Distancia);
  //
  // moviendo la esfera derecha
  line (base+3*Distancia, 0, base+3*+Distancia+posVector2.x, posVector2.y );
  ellipse(  base+3*Distancia+posVector2.x, posVector2.y, Distancia, Distancia);
  text("Acción", 230, 100);
  text("Consecuencias",350,100);
  text("Reacción",490,100);
 text("Karma", 610, 100);
}
}