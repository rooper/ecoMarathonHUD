//required for BT enabling on startup
import android.content.Intent;
import android.os.Bundle;

import ketai.net.bluetooth.*;
import ketai.ui.*;
import ketai.net.*;

import oscP5.*;

KetaiBluetooth bt;
String info = "";
KetaiList klist;
PVector remoteMouse = new PVector();

ArrayList<String> devicesDiscovered = new ArrayList();
boolean isConfiguring = true;
String UIText;
int counter = 0;
String incoming = "";
String device = "";


Speedometer speedometer;
Timer timer;
AverageSpeed average;
Bar voltage;
Bar current;
color background = color(255);
float speed = 0;
float battery = 0;
float drawn = 0;
int prevSecond = 0;
int timeLeft = 900;
PFont font50, font150;

void setup() {
  size(1280, 720);
  bt.start();
  isConfiguring = true; 
  orientation(LANDSCAPE);
  speedometer = new Speedometer(450, 540, width/2, height/2-20, 30);
  timer = new Timer(width/2, height/2+230);
  average = new AverageSpeed(width/2, height/2+100);
  voltage = new Bar(650, 900, width/2-80, height/2-20, 100, 90, false, "Battery Level");
  current = new Bar(650, 900, width/2+80, height/2-20, 5, 90, true, "Current Draw");
  font50 = loadFont("Montserrat-Regular-50.vlw");
  font150 = loadFont("Montserrat-Regular-150.vlw");
  textAlign(CENTER, CENTER);
  frameRate(60);
  System.out.println("Setup complete.");
}

void draw() {
  if (isConfiguring)

  {
    ArrayList names;

    //create the BtSerial object that will handle the connection
    //with the list of paired devices
    klist = new KetaiList(this, bt.getPairedDeviceNames());

    isConfiguring = false;                         //stop selecting device
    System.out.println("Done configuring.");
    
      //Send something
      String data = "I'm alive!";
      bt.broadcast(data.getBytes());
  }
  
  background(background);  
  
  if (second() != prevSecond){
      timeLeft--;
      prevSecond = second();
  }
  timeLeft = constrain(timeLeft, 0, 3600);
 
  
  voltage.updateMe(battery);  
  current.updateMe(drawn);
  speedometer.updateMe(speed);
  timer.updateMe(timeLeft);
  average.updateMe(speed);
    
    
 textAlign(LEFT, CENTER);
 textFont(font50, 20);
 text("Connected to: "+device, 5, 10);
 text("Received: "+info, 5, 30);
}


//********************************************************************
// The following code is required to enable bluetooth at startup.
//********************************************************************
void onCreate(Bundle savedInstanceState) {
  super.onCreate(savedInstanceState);
  bt = new KetaiBluetooth(this);
}

void onActivityResult(int requestCode, int resultCode, Intent data) {
  bt.onActivityResult(requestCode, resultCode, data);
}

//********************************************************************

void onKetaiListSelection(KetaiList klist)
{
  String selection = klist.getSelection();            //select the device to connect
  bt.connectToDeviceByName(selection);        //connect to the device
  klist = null;                                                      //dispose of bluetooth list for now
  System.out.println("Device connected: " + selection);
  device = selection;
}

void onBluetoothDataEvent(String who, byte[] data) {
 if (isConfiguring)
 return;
 //received
 String d = new String(data);
 
 System.out.println("event happened");
 System.out.println(info);
    
  //Recieve stuff here
  //info = "0.0,0.0,0.0;";
 if (d.equals(";")) {
    System.out.println("command recieved. parsing data.");
    //parse it
    info += ",40.0";
    String[] s = info.split(",");
    //clean it 
    info = null;
    info = "";
    System.out.println("Resetting info");
    
    
    drawn = Float.parseFloat(s[0]);
    speed = Float.parseFloat(s[1]);
    battery = Float.parseFloat(s[2]);
    
 } else {
   info += d;
 }

}
