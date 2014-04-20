public class AverageSpeed {
  int myX;
  int myY;
  int myCount;
  float mySum;
  float myAverage;

  AverageSpeed (int x, int y) {
    myX = x;
    myY = y;
    mySum = 0;
    myCount = 0;
    myAverage = 0;
  }

  public void drawMe() {
    textFont(font50, 20);
    text("Average Speed", myX, myY);
    textFont(font50, 50);
    text(String.format("%.1f", myAverage), myX, myY+35);
  }

  public void updateMe(float speed) {
    myCount++;
    mySum+=speed;
    myAverage = mySum/myCount;
    drawMe();
  }
}


