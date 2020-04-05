Table table;
File selection;
String param, file;
double value1, value2, value3, value4;
int margin = 50, countparam = 0,  first=1, p1 = 0, p2 = 1;

int MIN=0,MAX=1;
int x=0,y=1;
int[] order = {0,1,2,3};
float[][] data = new float[272][4];  
int[][] scaler = new int[4][2]; 
boolean enterplot = true;

int index=0;

void setup()
{
    size(1200, 800);
    background(200);
    stroke(50);
    strokeWeight(3);
    strokeCap(SQUARE);
    selectInput("Select a file to process:", "fileSelected", selection);
}

void fileSelected(File selection) 
{
    if (selection == null) {
        println("Window was closed or the user hit cancel.");
    } 
    else {
        println("User selected " + selection.getAbsolutePath());
        file = selection.getAbsolutePath();
        table = loadTable(file);
    }
}

void draw()
{
  background(40);
  if(table!=null)
  {
      prepareCanvas();
      processInput();    
  } 
}