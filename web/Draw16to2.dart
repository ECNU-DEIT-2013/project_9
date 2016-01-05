library drawry2;
import 'DrawFrame.dart';
import 'dart:async';
import 'dart:math' as Math;
import 'dart:html';

class Draw16to2{
  DrawFrame drawFrame;
  var second;
  Timer timer;

  int number;
  int x,x1;
  int y,y1;
  int sum =0;
  var s;
  var canvas;

  DivElement div;
  DivElement bigDiv;
  DivElement close;


  Draw16to2(String s,var canvas,DivElement div, DivElement bigDiv, DivElement close,int x,int y) {
    drawFrame = new DrawFrame();
    second=new Duration(seconds:2);

    this.s = s;
    this.canvas = canvas;
    this.div= div;
    this.bigDiv = bigDiv;
    this.close =close;

    number = 0;
   // x = 65;
    this.x =x;
   // y = 100;
    this.y =y;
    //x1 = 50;
    x1=x-15;
   // y1 = 150;
    y1=y+50;
  }

  void hello(){
    cal_10_to(s);
    cal_16_to_2_draw();
  }

  void hello_copy(){
    cal_10_to(s);
    timer = new Timer.periodic(second,cal_16_to_2_draw_copy);
    img_16_to_2();
  }
  void cal_10_to(String s) {
    var x = 10;
    var y = 32;
    List<String> list = new List();
    var len = s.length;
    var a = new List<String>();
    for (var i = 0;i < len;i++) {
      drawFrame.setFormer(s[i]);
    }
    for (int i = 0;i < len;i++) {
      if (s[i].toUpperCase() == 'A')a.add('10');
      else if (s[i].toUpperCase() == 'B')a.add('11');
      else if (s[i].toUpperCase() == 'C')a.add('12');
      else if (s[i].toUpperCase() == 'D')a.add('13');
      else if (s[i].toUpperCase() == 'E')a.add('14');
      else if (s[i].toUpperCase() == 'F')a.add('15');
      else a.add(s[i]);
    }

    for (var i = 0;i < len;i++) {
      int b1 = int.parse(a[i]);
      int s1;
      String s2 = "";
      while (b1 ~/ 2 != 0) {
        s1 = b1 % 2;
        b1 = b1 ~/ 2;
        x = x + 10;
        y = y + 32;
        if (s1 < 10) {
          s2 = s1.toString() + s2;
        }
        else {
          if (s1 == 10) {
            s2 = 'A' + s2;
          }
          else if (s1 == 11) {
            s2 = 'B' + s2;
          }
          else if (s1 == 12) {
            s2 = 'C' + s2;
          }
          else if (s1 == 13) {
            s2 = 'D' + s2;
          }
          else if (s1 == 14) {
            s2 = 'E' + s2;
          }
          else {
            s2 = 'F' + s2;
          }
        }
      }
      if (b1 < 10) {
        s2 = b1.toString() + s2;
      }
      else {
        if (b1 == 10) {
          s2 = 'A' + s2;
        }
        else if (b1 == 11) {
          s2 = 'B' + s2;
        }
        else if (b1 == 12) {
          s2 = 'C' + s2;
        }
        else if (b1 == 13) {
          s2 = 'D' + s2;
        }
        else if (b1 == 14) {
          s2 = 'E' + s2;
        }
        else {
          s2 = 'F' + s2;
        }
      }
      list.add(s2);
    }
    List<String> list2 = new List();
    var len1 = list.length;
    var buffer = new StringBuffer();
    list2.add(list[0]);

    for (var i = 1;i < len1;i++) {
      var len2 = list[i].length;
      if (len2 != 4) {
        for (var i = 0;i < 4 - len2;i++) {
          buffer.write("0");
        }
        buffer.write(list[i]);
      }
      else {
        buffer.write(list[i]);
      }
      list2.add(buffer.toString());
      buffer.clear();
    }
    for (var i = 0;i <list2.length;i++) {
      drawFrame.setResults(list2[i]);
    }
  }

  void cal_16_to_2_draw(){
    var content = canvas.getContext('2d');
    content.font="bold 24px Times New Roman";
    content.fillStyle="white";
    var len=drawFrame.getResults().length;
    for(number=0;number<len;number++) {
      content.fillText(drawFrame.getFormer().elementAt(number),x, y);
      x = x + 75;
      content.fillText(drawFrame.getResults().elementAt(number), x1, y1);
      x1=x1+75;
    }
    x=150;y=150;
    x1=150;y1=150;
    number =0;
    sum =0;
  }

  void cal_16_to_2_draw_copy(Timer _){
    var content = canvas.getContext('2d');
    content.font="bold 24px Times New Roman";
    content.fillStyle="white";
    var len=drawFrame.getResults().length;
    if(number<len) {
      content.fillText(drawFrame.getFormer().elementAt(number),x, y);
      x = x + 75;
      content.fillText(drawFrame.getResults().elementAt(number), x1, y1);
      x1=x1+75;
      number++;
    }
    else{
      timer.cancel();
    }

  }

  void img_16_to_2(){



      ImageElement img = new ImageElement();
      img.src="img/16-2-c.png";
      img.width=200;
      img.height=80;
      div.children.add(img);


      ImageElement imgBig = new ImageElement();
      imgBig.src="img/16-2-c.png";
      imgBig.width=500;
      imgBig.height=200;

      SpanElement span1 =new SpanElement();

      span1
        ..classes.add('title')
        ..style.border="hidden"
        ..text="十六进制转换为二进制原理图";

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

