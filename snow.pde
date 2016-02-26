PVector[] snow = new PVector[300];
int newBox = 100; //defined as 'radius' of the square of the generation of new dots
boolean out = false; //PVector out-> stars going out in -> other way
PVector ball;

void setup()
{
  fullScreen();
  noCursor();
  //size(600, 600);
  //frameRate(15);
  for (int i = 0; i < snow.length; i++)
  {
    snow[i] = new PVector(random(width), random(height));
  }
  ball = new PVector(width/2,height/2);
}

void draw()
{
  background(0);
  drawSnow(snow);
  if (out) {
    updateOut(snow);
  } else
  {
    updateIn(snow);
  }

  if (random(500) <1)
  {
    out = !out;
    randomBall(ball);
  }
  //ellipse(ball.x,ball.y,4,4);
  //ball.x = mouseX;
  //ball.y = mouseY;
  if (ball.x > width || ball.x < 0 || ball.y > height || ball.y < 0){
    ball.x = width/2;
    ball.y = height/2;
  }
  if(random(80) < 7)
  {
    randomBall(ball);
  }
}

void randomBall(PVector ball)
{
  ball.x += random(40)-20;
  ball.y += random(40)-20;
}
void updateIn(PVector[] pts)
{
  for (PVector p : pts)
  {
    //make it go inward
    PVector nm = new PVector(-ball.x+p.x, -ball.y+p.y).normalize();
    p.x-= nm.x;
    p.y-= nm.y;
    if (abs(p.x- ball.x) < random(10) && abs(p.y - ball.y) < random(10))
    {
      if (random(2)>1)
      {
        p.x = random(width);
        p.y = (random(2)>1) ? 0:height;
      } else
      {
        p.x = (random(2)>1) ? 0:width;
        p.y = random(height);
      }
    }
  }
}
void updateOut(PVector[] pts)
{
  for (PVector p : pts)
  {
    //make it go outward
    PVector nm = new PVector(-ball.x+p.x, -ball.y+p.y).normalize();
    p.x+= nm.x;
    p.y+= nm.y;
    if (p.x > width || p.x < 0 || p.y > height || p.y < 0)
    {
      p.x = ball.x + random(2*newBox)-newBox;
      p.y = ball.y + random(2*newBox)-newBox;
    }
  }
}

void drawSnow(PVector[] pts)
{
  for (PVector p : pts)
  {
    stroke(random(105)+150);
    point(p.x, p.y);
  }
}
void keyPressed()
{
  if (key == 32)
  {
    out = !out;
  }
}