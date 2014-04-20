public class Bar {
  int myInnerD;  
  int myOuterD;
  int myX;
  int myY;
  int myAngleChange;
  float myValue;
  int myMax;
  color myC1 = color(120);
  color myC2 = color(50);
  boolean myFlip;
  String myName;

  Bar(int InnerD, int OuterD, int x, int y, int max, int angleChange, boolean flip, String name) {
    myInnerD = InnerD;
    myOuterD = OuterD;
    myX = x;
    myY = y;
    myMax = max;
    myAngleChange = angleChange;
    myFlip = flip;
    myName = name;
  }

  public void drawMe() {
    noStroke();
    fill(myC1);
    int angle = 180;
    if (myFlip)
      angle = 360;
    arc(myX, myY, myOuterD, myOuterD, radians(angle-myAngleChange/2), radians(angle+myAngleChange/2));

    fill(myC2);
    float displayAngle = 0;

    if (!myFlip) {
      displayAngle = map(myValue, 0, myMax, radians(angle-myAngleChange/2), radians(angle+myAngleChange/2));
      arc(myX, myY, myOuterD, myOuterD, radians(angle-myAngleChange/2), displayAngle);
    }
    else {
      displayAngle = map(myValue, 0, myMax, radians(angle+myAngleChange/2), radians(angle-myAngleChange/2));
      arc(myX, myY, myOuterD, myOuterD, displayAngle, radians(angle+myAngleChange/2));
    }

    fill(background);
    ellipse(myX, myY, myInnerD, myInnerD);
    fill(myC2);
    int count = 0;
    textFont(font50, 24);


    if (myFlip) {
      for (int i = angle-myAngleChange/2; i <= angle+myAngleChange/2 ; i+=(myAngleChange)/5) {
        text(count, myX+(myInnerD/2 - 35)*cos(radians(i)), myY-(myInnerD/2 - 20)*sin(radians(i)));
        count+=myMax/5;
      }
    }
    else {
      for (int i = angle+myAngleChange/2; i >= angle-myAngleChange/2 ; i-=(myAngleChange)/5) {
        text(count, myX+(myInnerD/2 - 35)*cos(radians(i)), myY-(myInnerD/2 - 20)*sin(radians(i)));
        count+=myMax/5;
      }
    }
    textAlign(CENTER, CENTER);
    if (myFlip)
      text(myName, myX-myOuterD/2-10, myY + myInnerD/2 + 10);
    else    
      text(myName, myX+myOuterD/2+10, myY + myInnerD/2 + 10);
  }

  public void updateMe(float value) {
    myValue = constrain(value, 0, myMax);
    drawMe();
  }
}

