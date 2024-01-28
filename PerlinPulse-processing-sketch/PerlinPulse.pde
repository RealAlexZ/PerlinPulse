// Create a list to store active Ripple objects
ArrayList<Ripple> ripples = new ArrayList<Ripple>();

// Define the Ripple class
class Ripple {
  float x, y; // X and Y coordinates of the ripple's center
  float size = 0; // Initial size of the ripple, starts at 0
  float growthRate = 2; // Rate at which the ripple expands each frame
  float maxDiameter = 200; // Maximum size the ripple can reach before disappearing
  float alpha = 255; // Initial transparency of the ripple, starts fully opaque

  // Constructor for the Ripple class, initializes a ripple at a given position
  Ripple(float x, float y) {
    this.x = x;
    this.y = y;
  }

  // Update the ripple's size and transparency each frame
  void update() {
    size += growthRate; // Increase the size of the ripple
    alpha -= growthRate * 2; // Decrease the transparency to create a fading effect
  }

  // Draw the ripple to the screen
  void display() {
    noFill();
    stroke(255, alpha); // Set the stroke color to white with current transparency
    ellipse(x, y, size, size); // Draw the ellipse at the ripple's position with its current size
  }

  // Check if the ripple is done expanding or has become fully transparent
  boolean isDone() {
    return size > maxDiameter || alpha <= 0; // Returns true if the ripple has reached its maximum size or is fully transparent
  }
}


void setup() {
  fullScreen();
  noStroke(); // Do not draw strokes by default
}


void draw() {
  background(255); // Repaint
  float time = millis() / 1000.0; // Calculate the current time in *seconds*

  int rectSize = 60; // Size of each square in the grid

  // Calculate the total size of the grid (10 squares each of size rectSize)
  int gridSize = 10 * rectSize;
  
  // Calculate starting points to center the grid on the screen
  float startX = (width - gridSize) / 2;
  float startY = (height - gridSize) / 2;

  // Create a 10x10 grid of squares with noise-based color and position offsets
  for (int i = 0; i < 10; i++) {
    for (int j = 0; j < 10; j++) {
      // Calculate noise-based offsets for position and color
      float xOff = noise(i * 0.1, j * 0.1, time * 0.1) * 100 - rectSize;
      float yOff = noise(i * 0.1, j * 0.1, time * 0.2) * 100 - rectSize;
      float r = noise(i * 0.1, j * 0.1, time * 0.3) * 255;
      float g = noise(i * 0.1, j * 0.1, time * 0.4) * 255;
      float b = 150 + noise(i * 0.1, j * 0.1, time * 0.5) * 105;
      
      // Draw the square with calculated color and position
      fill(r, g, b);
      rect(startX + i * rectSize + xOff, startY + j * rectSize + yOff, rectSize, rectSize);
    }
  }

  // Update and display each ripple in the list
  for (int i = ripples.size() - 1; i >= 0; i--) {
    Ripple ripple = ripples.get(i); // Get the current Ripple object
    ripple.update(); // Update the ripple's size and transparency
    ripple.display(); // Draw the ripple to the screen
    if (ripple.isDone()) { // If the ripple is done, remove it from the list
      ripples.remove(i);
    }
  }
}


void mousePressed() {
  ripples.add(new Ripple(mouseX, mouseY)); // Create a new Ripple at the mouse position and add it to the list
}
