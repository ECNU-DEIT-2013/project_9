library star;

import 'dart:html';

class Star{

  DivElement con2;
  DivElement con8;
  DivElement con10;
  DivElement con16;
  int con;
  Star(int con,DivElement con2,DivElement con8,DivElement con10,DivElement con16){
    this.con2= con2;
    this.con8= con8;
    this.con10 = con10;
    this.con16 = con16;
    this.con=con;
  }


  void drawLittleStar(){

    starRemove();

    ImageElement img = new ImageElement();
    img.src="pic/littleStar.gif";
    img.width=32;
    img.height=32;
    if(con==2)
      con2.children.add(img);
    else if(con==10)
      con10.children.add(img);
    else if(con==8)
      con8.children.add(img);
    else if(con==16)
      con16.children.add(img);
  }

  void starRemove(){
      con2.children.clear();
      con8.children.clear();
      con10.children.clear();
      con16.children.clear();
  }


}