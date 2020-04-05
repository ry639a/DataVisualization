void processInput()
{
  for(int r=0; r<4;r++) 
  {   
       scaler[r][MIN] = 1000;
       scaler[r][MAX] = 0; 
       
  }
  
  for(int r=1; r<table.getRowCount();r++) 
  {   
    for(int c=0; c<4;c++)
     {
      double value = Math.floor(Float.parseFloat(table.getString(r, c)));
      data[r][c] = (float)value;
      if(value < scaler[c][MIN])
        scaler[c][MIN] = (int)value;
      else if(value > scaler[c][MAX])
        scaler[c][MAX] = (int)value;
     }
      
  }
  
 drawBarGraph(data); 
 drawLineChart(data);
 scatterPlot(data);
 scatterPlotMatrix();
plotParallelCoordinates(data, order, scaler);
 
}

//Function creates bar chart for selected data
void drawBarGraph(float[][] data)
{
  int widthbar = 350,heightbar = 370,originx = 50,originy=400;
  drawAxes(widthbar,heightbar,originx,originy);
   text("SATM", 20, 20);
    text("SATV", originx+widthbar-30,  originy+20);
  for(int i=0;i<data.length;i++)
  {
    float x = data[i][0];
    float y = data[i][1];
    x = map(x,scaler[0][MIN], scaler[0][MAX],originx,originx+widthbar);
    y = map(y,scaler[1][MIN], scaler[1][MAX],originy,originy-heightbar);
    rect(x, originy - (y/2), 3.0, y/2);
  
    float valx = data[index][0];
    float valy = data[index][1];
    
    if(mouseX > x-3 && mouseX < x+3 && mouseY > height - margin - y && mouseY < height- margin)
    {
      stroke(3);
      strokeWeight(2);
      textSize(15);
      text(valx, x, height - 20);
      text(valy, 10, height - margin - y);
    }
  }
}

//function to draw line chart for selected parameters
void drawLineChart(float[][] data)
{
    int widthline = 350,heightline = 370,originx = 450,originy=400;
  drawAxes(widthline,heightline,originx,originy);
    text("SATM", originx+10, 20);
    text("SATV", originx+widthline-30, originy+20);
  
    float prevx = data[0][0];
    float prevy = data[0][1];
    prevx = map(prevx,scaler[0][MIN], scaler[0][MAX],originx,originx+widthline);
    prevy = map(prevy,scaler[1][MIN], scaler[1][MAX],originy,originy-heightline);
  
  for(int i=1;i<data.length;i++)
  {
    float x = data[i][0];
    float y = data[i][1];
    float currx = map(x,scaler[0][MIN], scaler[0][MAX],originx,originx+widthline);
    float curry = map(y,scaler[1][MIN], scaler[1][MAX],originy-heightline,originy);
    
    line(prevx, originy-prevy, currx, originy-curry);
    
    prevx = currx;
    prevy = curry;
    
    if(mouseX > currx-3 && mouseX < currx+3 && mouseY > height - margin - curry -3 && mouseY < height- margin - curry + 3)
    {
      stroke(3);
      strokeWeight(2);
      textSize(15);
      //text(val1, currx, height - 20);
      //text(val2, 10, height - margin - curry);
    }
  }
}

//Function to plot scatterplot for input data parameters
void scatterPlot(float[][] data)
{
  int widthscatter = 320,heightscatter = 370,originx = 850,originy=400;
  drawAxes(widthscatter,heightscatter,originx,originy);
    text("SATM", originx+10, 20);
    text("SATV", originx+widthscatter-30, originy+20);
  
  for(int i=1;i<data.length;i++)
  {
      float x = data[i][0];
      float y = data[i][1];
      x = map(x,scaler[0][MIN], scaler[0][MAX],originx,originx+widthscatter);
      y = map(y,scaler[1][MIN], scaler[1][MAX],originy,originy-heightscatter);
      ellipse(x, originy - y, 5, 5);
    
     float valx = map(data[index][0],scaler[0][MIN], scaler[0][MAX],originx,originx+widthscatter);
     float valy = map(data[index][0],scaler[1][MIN], scaler[1][MAX],originy,originy-heightscatter);
    
    if(mouseX > x-4 && mouseX < x+4 && mouseY > height - margin - y - 4 && mouseY < height- margin - y + 4)
    {

     // text(val1, x, height - 20);
      //text(val2, 10, height - margin - y);
    }
  }
  
}

//function to plot scatterplot matrix for given data
void scatterPlotMatrix()
{
   int widthscatterplot = 320,heightscatterplot = 400,originx = 50,originy=750;
  drawAxes(widthscatterplot,heightscatterplot,originx,originy);
    line(originx, originy-heightscatterplot, originx-widthscatterplot, originy-heightscatterplot);
    line(originx-widthscatterplot, originy-heightscatterplot, originx-widthscatterplot, originy);
    margin =50;
      float xscale = (widthscatterplot)/ 4;
      float yscale = (heightscatterplot - 100)/4;

       text("SATM", 10, yscale+ heightscatterplot);
       text("SATV", 10, yscale*2  + heightscatterplot);
       text("ACT", 10, yscale*3 + heightscatterplot);
       text("GPA", 10, yscale*4  + heightscatterplot);
       text("SATM", xscale, margin - 20+heightscatterplot);
       text("SATV", xscale*2, margin - 20+heightscatterplot);
       text("ACT", xscale*3, margin - 20+heightscatterplot);
       text("GPA", xscale*4, margin - 20+heightscatterplot);
      
    for(int i=1; i<table.getRowCount();i++) 
    {   
       float val1 = Float.parseFloat(table.getString(i, 0));
       float val2 = Float.parseFloat(table.getString(i, 1));
       float val3 = Float.parseFloat(table.getString(i, 2));
       float val4 = Float.parseFloat(table.getString(i, 3));
       float x , y;
       
       x = map(val1, scaler[0][MIN], scaler[0][MAX], margin, margin + xscale); 
       y = map(val1, scaler[0][MIN], scaler[0][MAX], margin, margin + (yscale));
       ellipse(x,margin +  margin + yscale - y + heightscatterplot, 2, 2);
       x = map(val1, scaler[0][MIN], scaler[0][MAX], margin + xscale, margin + (xscale*2)); 
       y = map(val2, scaler[1][MIN], scaler[1][MAX], margin, margin + yscale);
       ellipse(x,margin +  margin + yscale-y + heightscatterplot, 2, 2); 
       x = map(val1, scaler[0][MIN], scaler[0][MAX], margin + (xscale*2), margin + (xscale*3)); 
       y = map(val3, scaler[2][MIN], scaler[2][MAX], margin, margin + yscale);
       ellipse(x,margin +  margin + yscale-y + heightscatterplot, 2, 2);
       x = map(val1, scaler[0][MIN], scaler[0][MAX], margin + (xscale*3), margin + (xscale*4)); 
       y = map(val4, scaler[3][MIN], scaler[3][MAX], margin, margin + yscale);
       ellipse(x,margin +  margin + yscale-y + heightscatterplot, 2, 2);

       x = map(val2, scaler[1][MIN], scaler[1][MAX], margin, margin + xscale); 
       y = map(val1, scaler[0][MIN], scaler[0][MAX], margin + yscale, margin + (yscale*2));
       ellipse(x, (2*margin) + (yscale*3) - y + heightscatterplot, 2, 2);
       x = map(val2, scaler[1][MIN], scaler[1][MAX], margin + (xscale), margin + (xscale*2)); 
       y = map(val2, scaler[1][MIN], scaler[1][MAX], margin + (yscale), margin + (yscale*2));
       ellipse(x, (2*margin) + (yscale*3) - y + heightscatterplot, 2, 2);
       x = map(val2, scaler[1][MIN], scaler[1][MAX], margin + (xscale*2), margin + (xscale*3)); 
       y = map(val3, scaler[2][MIN], scaler[2][MAX], margin + yscale, margin + (yscale*2));
       ellipse(x, (2*margin) + (yscale*3) - y+heightscatterplot, 2, 2);
       x = map(val2, scaler[1][MIN], scaler[1][MAX], margin + (xscale*3), margin + (xscale*4)); 
       y = map(val4, scaler[3][MIN], scaler[3][MAX], margin + yscale, margin + (yscale*2));
       ellipse(x, (2*margin) + (yscale*3) - y+heightscatterplot, 2, 2);


       x = map(val3, scaler[2][MIN], scaler[2][MAX], margin, margin + xscale); 
       y = map(val1, scaler[0][MIN], scaler[0][MAX], margin + (yscale*2), margin + (yscale*3));
       ellipse(x, (2*margin) + (yscale*5) - y+heightscatterplot, 2, 2);
       x = map(val3, scaler[2][MIN], scaler[2][MAX], margin + xscale, margin + (xscale*2)); 
       y = map(val2, scaler[1][MIN], scaler[1][MAX], margin + (yscale*2), margin + (yscale*3));
       ellipse(x, (2*margin) + (yscale*5) - y+heightscatterplot, 2, 2);
       x = map(val3, scaler[2][MIN], scaler[2][MAX], margin + (xscale*2), margin + (xscale*3)); 
       y = map(val3, scaler[2][MIN], scaler[2][MAX], margin + (yscale*2), margin + (yscale*3)); 
       ellipse(x, (2*margin) + (yscale*5) - y+heightscatterplot, 2, 2);  
       x = map(val3, scaler[2][MIN], scaler[2][MAX], margin + (xscale*3), margin + (xscale*4)); 
       y = map(val4, scaler[3][MIN], scaler[3][MAX], margin + (yscale*2), margin + (yscale*3));
       ellipse(x, (2*margin) + (yscale*5) - y+heightscatterplot, 2, 2);
       
       //4th row
       x = map(val4, scaler[3][MIN], scaler[3][MAX], margin, margin + xscale); 
       y = map(val1, scaler[0][MIN], scaler[0][MAX], margin + (yscale*3), margin + (yscale*4));
       ellipse(x, (2*margin) + (yscale*7) - y+heightscatterplot, 2, 2); 
       x = map(val4, scaler[3][MIN], scaler[3][MAX], margin + xscale, margin + (xscale*2)); 
       y = map(val2, scaler[1][MIN], scaler[1][MAX], margin + (yscale*3), margin + (yscale*4));
       ellipse(x, (2*margin) + (yscale*7) - y+heightscatterplot, 2, 2);
       x = map(val4, scaler[3][MIN], scaler[3][MAX], margin + (xscale*2), margin + (xscale*3)); 
       y = map(val3, scaler[2][MIN], scaler[2][MAX], margin + (yscale*3), margin + (yscale*4));
       ellipse(x, (2*margin) + (yscale*7) - y+heightscatterplot, 2, 2);
       x = map(val4, scaler[3][MIN], scaler[3][MAX], margin + (xscale*3), margin + (xscale*4)); 
       y = map(val4, scaler[3][MIN], scaler[3][MAX], margin + (yscale*3), margin + (yscale*4)); 
       ellipse(x, (2*margin) + (yscale*7) - y+heightscatterplot, 2, 2);
       
    }
}

void plotParallelCoordinates(float[][] data, int[] order, int[][] scaler)
{

  float[][] points= new float[4][2];
  int count=0;
  int height_parallel = 400;
  int width_parallel = 450;
  int originx = 450, originy= 750;
  drawAxes(width_parallel,height_parallel,originx,originy);
  text("SATM", originx, originy+20);
  text("SATV", originx+150, originy+20);
  text("ACT", originx+300, originy+20);
  text("GPA", originx+450, originy+20);
  

  for(int rec = 1;rec<table.getRowCount();rec++)
  {
      
      for(int col = 0;col<4;col++)
      {

        int att = order[col];
        float val = data[rec][att];
        float valx = (width_parallel*count);
        points[col][x]= map(valx, 0,1200,width_parallel,2*width_parallel);
        points[col][y] = map(val,scaler[att][MIN],scaler[att][MAX], originy- height_parallel+70,originy);
        count++;
       }
      count = 0;
      for(int p=1;p<4;p++)
      {
        line(points[p-1][x],points[p-1][y],points[p][x],points[p][y]);
      }
      
  }

}