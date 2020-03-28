File selection;
String param, file;

int MIN=0,MAX=1;
int rows,cols,border=50;
JSONArray nodes,links;
int nodefile=1;
float mass = 10;
int first=1;
ArrayList<Node> nodeList = new ArrayList<Node>();

void setup()
{
    size(800, 800);
    background(250);
    stroke(50);
    strokeWeight(3);
    strokeCap(SQUARE);
    selectInput("Select a nodes file to process:", "fileSelected", selection);
    selectInput("Select a links file to process:", "fileSelected", selection);
}

void fileSelected(File selection) 
{
    if (selection == null) {
        println("Window was closed or the user hit cancel.");
    } 
    else {
        println("User selected " + selection.getAbsolutePath());
        file = selection.getAbsolutePath();
        if(nodefile==1)
        {
        nodes = loadJSONArray(file);
        nodefile=0;
        }
        else
          links = loadJSONArray(file);
    }
}

void draw() //<>//
{
  //background(40);
  textSize(20);
  fill(230,150,150);
 text("Force Directed Graph",300,100);
  if(links!=null && nodes!=null)
  {
    rows = links.size();
    println("links:",rows,"nodes:",nodes.size());
    
    //Creating instance for setup
     processInput pi = new processInput();
     //if(first==1)
     int loop=100;
   // while(loop>0)
    //{
        pi.drawNode();
        pi.drawGraph();
        loop--;
    //}
    //noLoop();
  } 
}