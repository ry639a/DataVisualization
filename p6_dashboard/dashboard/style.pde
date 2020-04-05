//Sets the stroke color, weight, color mode and fill color
void setStyle(int bg, int strColor,int strWeight, int red, int blue, int green)
{
    background(bg);
    stroke(strColor);
    strokeWeight(strWeight);
    colorMode(RGB, 200);
    fill(color(red, blue, green));
}

//Function to drawAxes and label the parameters
void drawAxes(int widths,int heights, int x, int y)
{
    line(x, y, x, y-heights);
     line(x, y, x+widths,y);
}

void prepareCanvas()
{
    setStyle(190, 0, 1, 150, 150, 150);
    rectMode(RADIUS);
    int wid = 233;
    for(int i=0;i<4;i++)
    {
      //strokeWeight(1);
      fill(color(30, 170, 180));

      fill(color(20, 20, 20));
      stroke(0);
    }
    
}

void addAxesLabels(String x, String y)
{
    text(x, width - margin - 20, height - 20);
    text(y, margin - 10, margin - 10); 
}