
library img;

import 'dart:html';

class Img{

  DivElement div;
  DivElement bigDiv;
  DivElement close;

  Img(DivElement div, DivElement bigDiv, DivElement close){

    this.div= div;
    this.bigDiv = bigDiv;
    this.close =close;

  }

  void img_16_to_8(){

   if(div.hasChildNodes()){
     var childList = div.childNodes;
      for(var i=0;i<childList.length;i++){
       if( childList[i].nodeName=="IMG"){
         var nodeObject = div.children[i];
         div.children.remove(nodeObject);
       }
      }
   }

    ImageElement img = new ImageElement();
    img.src="img/16-8-c.png";
    img.width=200;
    img.height=80;

    div.children.add(img);


    ImageElement imgBig = new ImageElement();
    imgBig.src="img/16-8-c.png";
    imgBig.width=500;
    imgBig.height=200;

    SpanElement span1 =new SpanElement();

    span1
      ..classes.add('title')
      ..style.border="hidden"
      ..text="十六进制转换为八进制原理图";

    bigDiv.children.add(span1);

    bigDiv.children.add(imgBig);


    div.onClick.listen(open);

  }
  void img_8_to_16(){



    ImageElement img = new ImageElement();
    img.src="img/8-16-c.png";
    img.width=200;
    img.height=80;
    div.children.add(img);


    ImageElement imgBig = new ImageElement();
    imgBig.src="img/8-16-c.png";
    imgBig.width=500;
    imgBig.height=200;

    SpanElement span1 =new SpanElement();

    span1
      ..classes.add('title')
      ..style.border="hidden"
      ..text="八进制转换为十六进制原理图";

    bigDiv.children.add(span1);

    bigDiv.children.add(imgBig);


    div.onClick.listen(open);

  }

  void open(Event e){

    close.style.display="block";
    close.onClick.listen(shut);
  }

  void shut(Event e){
    close.style.display="none";
  }
}