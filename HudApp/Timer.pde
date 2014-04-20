public class Timer {
  int myX;
  int myY;
  int myTime;

  Timer(int x, int y) {
    myX = x;
    myY = y;
  }

  public void drawMe() {
    textFont(font150, 80);
    String value = myTime/60+":";
    if (myTime%60<10)
      value+="0";
    value+=myTime%60;
    text(value, myX, myY);
  }

  public void updateMe(int time) {
    myTime = time;
    timer.drawMe();
  }
}

