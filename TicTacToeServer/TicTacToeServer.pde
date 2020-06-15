import processing.net.*;
int[][] grid;

boolean turn = true;
Server myServer;
void setup(){
  size(300, 400);
  grid = new int[3][3];
  strokeWeight(3);
  textAlign(CENTER, CENTER);
  textSize(50);
  
  myServer = new Server(this, 1234);
}

void draw(){
  background(255);
  stroke(0);
  line(0, 100, 300, 100);
  line(0, 200, 300, 200);
  line(100, 0, 100, 300);
  line(200, 0, 200, 300);
  
  for(int i = 0; i < grid.length; i++){
    for(int j = 0; j < grid[0].length; j++){
      drawXO(i, j);
    }
  }
  
  //Client
  Client myClient = myServer.available();
  if(myClient != null){
    String incoming = myClient.readString();
    int r = int(incoming.substring(0, 1));
    int c = int(incoming.substring(2, 3));
    grid[r][c] = 2;
    turn = true;
  }
    
    
  
}

void drawXO(int r, int c){
  pushMatrix();
  translate(r*100, c*100);
  if(grid[r][c] == 1){
    fill(255);
    ellipse(50, 50, 90, 90);
  } else if(grid[r][c] == 2){
    line(10, 10, 90, 90);
    line(90, 10, 10, 90);
  }
  popMatrix(); 
}

void mouseReleased(){
  int row = mouseX/100;
  int col = mouseY/100;
  
  
  try{
    if(grid[row][col] == 0 && turn){
      grid[row][col] = 1;
      myServer.write(row + "," + col );
    }
  } catch(Exception e){
    System.out.println("...");
  }
  turn = false;
  
}
