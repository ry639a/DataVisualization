
//Class setup: prepares the input screen, reads values, calculates correlation between attributes and initializes all the variables needed for the program.
//Also initializaes class Correlation and Class Histogram.
class processInput
{
//constructor that prepares input screen for the sketch
  processInput()
  {
    setStyle(250, 0, 1, 230, 80, 80); 
    text("Force Directed Graph", 1000, 520);      
    fill(120,150,230);
    float posx=10,posy=10;
    for (int i = 0; i < nodes.size(); i++) 
    {
      JSONObject nodesObj = nodes.getJSONObject(i); 
      String id = nodesObj.getString("id");
      int group = nodesObj.getInt("group");
      posx=random(100,700);
      //posx+10;
      posy=random(100,700);
      //posy+10;      
      Node nd = new Node(i,id,group,posx,posy);

      nodeList.add(nd);
      //println(id + ", " + group + ", ");
    }
    for(int j=0;j < nodeList.size();j++)
    {
    for (int i = 0; i < links.size(); i++) 
    {
      JSONObject linksObj = links.getJSONObject(i); 
      Node nd = nodeList.get(j);
      String source = linksObj.getString("source");
      String target = linksObj.getString("target");
      int value = linksObj.getInt("value");
      String edge;
      if(nd.node_name.equals(source))
      { 
         edge = target;
         int ind = getNum(target);
         
         nd.connectnodes.append(ind);
         nd.values.append(value);
      }
      else if(nd.node_name.equals(target))
      {
         edge = source;
         int ind = getNum(target);          
         nd.connectnodes.append(ind);
         nd.values.append(value);
      }

    } 
    }
    
    for(int i=0;i<nodeList.size();i++)
    {
      Node nd = nodeList.get(i);
      
      print("node_name:",nd.node_name);
      print(" node_num:",nd.node_num);
      print(" group_num:",nd.group_num);
      print("adj_nodes:");
      for(int j=0;j<nd.connectnodes.size();j++)
      {
      print(" ",nd.connectnodes.get(j));
      print(" ",nd.values.get(j));
      
      }
      println();
    }
  }
  int getNum(String name)
  {
     for(int i=0;i<nodeList.size();i++)
     {
        if(nodeList.get(i).node_name.equals(name))
        {
          
           println("name:",name);
           println("index:",i);
          return i;

        }
     }
     return -1;
  }
  void drawNode()
  {
     for(int i=0;i<nodeList.size();i++)
     {
       Node nd = nodeList.get(i);
        float x = nd.currx;
        float y = nd.curry;
        int group1 = nd.group_num;
        strokeWeight(0);
          if(group1==1){
      pushMatrix();
      fill(255,0,0); 
      popMatrix();
    }else if(group1==2){
      pushMatrix();
      fill(130,160,34);
      popMatrix();
    }else if(group1==3){
      pushMatrix();
      fill(250,160,0);
      popMatrix();
    }else if(group1==4){
      pushMatrix();
      fill(0,160,250);
      popMatrix();
    }else if(group1==5){
      pushMatrix();
      fill(34,160,130);
      popMatrix();
    }else if(group1==6){
      pushMatrix();
      fill(20,250,180);
      popMatrix();
    }else if(group1==7){
      pushMatrix();
      fill(30,0,100);
      popMatrix();
    }else if(group1==8){
      pushMatrix();
      fill(0,250,10);
      popMatrix();
    }else if(group1==9){
      pushMatrix();
      fill(100,90,0);
      popMatrix();
    }else if(group1==10){
      pushMatrix();
      fill(50,100,250);
      popMatrix();
    }  
        
        ellipse(x,y,15,15);
        for(int j=0;j<nd.connectnodes.size();j++)
        {
          int ed = nd.connectnodes.get(j);
          Node nd2 = nodeList.get(ed);
          line(nd.currx,nd.curry,nd2.currx,nd2.curry);
        }
        first=0;
     }
  }
   
   void drawGraph()
   {
     /*
     *place vertices in random locations
     *repeat M times usually 100
       *Calculate force on each vertex
       *move the vertex to c4*force
     *draw graph on plotter
     */
     
     for(int i=0;i<nodeList.size();i++)
     {
       Node nd = nodeList.get(i);
       nd.forceExerted(nd);
       nd.repelForce(nd);
       nd.setPosition(nd);
       drawNode();
     }
     
   }
 
}
  
  //Sets the stroke color, weight, color mode and fill color
  void setStyle(int bg, int strColor,int strWeight, int red, int blue, int green)
  {
      background(bg);
      stroke(strColor);
      strokeWeight(strWeight);
      colorMode(RGB, 255,255,255);
      fill(color(red, blue, green));
      textSize(14);
  }