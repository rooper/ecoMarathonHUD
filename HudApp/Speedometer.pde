public class Speedometer {
  int myInnerD;  
  int myOuterD;
  int myX;
  int myY;
  float mySpeed;
  int myMax;
  color myC1 = color(120);
  color myC2 = color(50);

  Speedometer(int InnerD, int OuterD, int x, int y, int max) {
    myInnerD = InnerD;
    myOuterD = OuterD;
    myX = x;
    myY = y;
    myMax = max;
  }

  public void drawMe() {
    noStroke();
    fill(myC1);
    arc(myX, myY, myOuterD, myOuterD, radians(145), radians(395));
    fill(myC2);
    float angle = map(mySpeed, 0, 30, 150, 390);
    arc(myX, myY, myOuterD, myOuterD, radians(angle-5), radians(angle+5));
    fill(background);
    ellipse(myX, myY, myInnerD, myInnerD);
    fill(myC2);    
    textFont(font50, 30);
    int count = 0;
    for (int i = 210; i >= -30; i-=(390-150)/15) {
      text(count, myX+(myInnerD/2 - 25)*cos(radians(i)), myY-(myInnerD/2 - 25)*sin(radians(i)));
      count+=myMax/15;
    }
    textFont(font50, 24);
    text("mph", myX, myY+60);
    textFont(font150, 150);
    text(round(mySpeed), myX, myY-20);
  }

  public void updateMe(float newSpeed) {
    mySpeed = constrain(newSpeed, 0, myMax);
    drawMe();
  }
}

