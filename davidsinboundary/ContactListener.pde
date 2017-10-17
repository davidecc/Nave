import org.jbox2d.callbacks.ContactImpulse;
import org.jbox2d.callbacks.ContactListener;
import org.jbox2d.collision.Manifold;
import org.jbox2d.dynamics.contacts.Contact;

 class CustomListener implements ContactListener {
  CustomListener() {
  }

    void beginContact(Contact cp) {
    // Get both fixtures
    Fixture f1 = cp.getFixtureA();
    Fixture f2 = cp.getFixtureB();

    Body b1 = f1.getBody();
    Body b2 = f2.getBody();
    
    Object o1 = b1.getUserData();
    Object o2 = b2.getUserData();

    if (o1.getClass() == Box.class) {
    Particle p = (Particle) o2;
    p.change();
    box.crecer();
      
    } 
    else if (o2.getClass() == Box.class) {
      Particle p = (Particle) o1;
      p.change();
      box.crecer();
    }
  }

   void endContact(Contact contact) {
    }

   void preSolve(Contact contact, Manifold oldManifold) {
   }

   void postSolve(Contact contact, ContactImpulse impulse) {
   }
}