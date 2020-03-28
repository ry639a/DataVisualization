class Node
{
  String node_name;
  int node_num;
  int group_num = 0;
  
  IntList connectnodes = new IntList();
  IntList values = new IntList();
  
  float prevx=0,prevy=0,currx=0,curry=0;
  float rep_forcex,rep_forcey,att_forcex,att_forcey;
  
  float c1 = 100,c2=1,c3=1,c4=0.1,d=0;
 
  Node(int node_num,String node_name, int group_num,float prevx,float prevy)
  {
    this.node_num=node_num;
    this.node_name=node_name;
    this.group_num=group_num;
    this.prevx = prevx;
    this.prevy = prevy;
    this.currx = prevx;
    this.curry = prevy;
  }
  float getDistance(Node node1,Node node2)
  {
    float distance =0;
    float xdiff = pow(node1.currx - node2.currx,2);
    float ydiff = pow(node1.curry - node2.curry,2);
    
    distance = xdiff+ydiff;
    return distance;
  }
   void forceExerted(Node node1)
   {
     /* 
      *force exerted on spring is given by f = c1*log(d/c2)
     */
     
      float fx=0,fy=0;
      for(int i=0;i<connectnodes.size();i++){
        Node node2 = nodeList.get(connectnodes.get(i));
        //get distance between 2 nodes
        float dist = getDistance(node1,node2);
        float xdiff = (node1.currx-node2.curry);
        float ydiff = (node1.curry-node2.curry);
        
        fx += c1*log(xdiff/c2);
        fy += c1*log(ydiff/c2);
      }
      node1.att_forcex = fx;
      node1.att_forcey = fy;
      
   }
   void repelForce(Node node1)
   {
     /* 
      *repel force is given by rf = c3/d^2
     */
     float rfx =0,rfy=0;
      for(int i=0;i<connectnodes.size();i++)
      {
        Node node2 = nodeList.get(connectnodes.get(i));
        //get distance between 2 nodes
        float dist = getDistance(node1,node2);
        float xdiff = (node1.currx-node2.curry);
        float ydiff = (node1.curry-node2.curry);
     
         rfx += c3*xdiff/dist;
         rfy += c3*ydiff/dist;
      }
      node1.rep_forcex = rfx;
      node1.rep_forcey = rfy;
      
   }
   
   void setPosition(Node node1)
   {
      node1.prevx = node1.currx;
      node1.prevy = node1.curry;
      node1.curry = node1.prevx + (c4*(att_forcex+rep_forcex));
      node1.curry = node1.prevy + (c4*(att_forcey+rep_forcey));
      
   }
  
}