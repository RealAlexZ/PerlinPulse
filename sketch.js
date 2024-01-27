let ripples = []; // List to store active ripples

class Ripple {
  constructor(x, y) {
    this.x = x;
    this.y = y;
    this.size = 0; // Current size
    this.growthRate = 2; // How fast the ripple grows
    this.maxDiameter = 200; // Maximum size of the ripple
    this.alpha = 255; // Transparency
  }

  update() {
    this.size += this.growthRate;
    this.alpha -= this.growthRate * 2; // Fade out as it grows
  }

  display() {
    noFill();
    stroke(255, this.alpha);
    ellipse(this.x, this.y, this.size);
  }

  isDone() {
    return this.size > this.maxDiameter || this.alpha <= 0;
  }
}

function setup() {
  createCanvas(windowWidth, windowHeight); // Use full screen mode
  noStroke();
}

function draw() {
  background(255);
  fullscreen();
  let timeMoment = millis() / 1000.0;
  let rectSize = 60;

  // Calculate the total size of the grid
  let gridSize = 10 * rectSize; // 10 rectangles, each rectSize pixels in size

  // Calculate the starting point to center the grid
  let startX = (width - gridSize) / 2;
  let startY = (height - gridSize) / 2;

  for (let i = 0; i < 10; i++) {
    for (let j = 0; j < 10; j++) {
      let xOff = noise(i * 0.1, j * 0.1, timeMoment * 0.1) * 100 - rectSize;
      let yOff = noise(i * 0.1, j * 0.1, timeMoment * 0.2) * 100 - rectSize;
      let r = noise(i * 0.1, j * 0.1, timeMoment * 0.3) * 255;
      let g = noise(i * 0.1, j * 0.1, timeMoment * 0.4) * 255;
      let b = 150 + noise(i * 0.1, j * 0.1, timeMoment * 0.5) * 105;

      // Use the calculated starting points to center the grid
      fill(r, g, b);
      rect(startX + i * rectSize + xOff, startY + j * rectSize + yOff, rectSize, rectSize);
    }
  }

  // Update and display ripples
  for (let i = ripples.length - 1; i >= 0; i--) {
    let ripple = ripples[i];
    ripple.update();
    ripple.display();
    if (ripple.isDone()) {
      ripples.splice(i, 1);
    }
  }
}

function mousePressed() {
  ripples.push(new Ripple(mouseX, mouseY)); // Add a new ripple at the mouse position
}

function windowResized() {
  resizeCanvas(windowWidth, windowHeight);
}
