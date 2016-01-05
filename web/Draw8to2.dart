library drawry1;
import 'DrawFrame.dart';
import 'dart:async';
import 'dart:math' as Math;

class Draw8to2{
  DrawFrame drawFrame;
  var second;
  Timer timer;

  int number;
  int x,x1;
  int y,y1;
  int sum =0;
  var s;
  var canvas;


  Draw8to2(String s,var canvas) {
    drawFrame = new DrawFrame();
    //second=new Duration(seconds:2);

    this.s = s;
    this.canvas = canvas;
    number = 0;
    x = 60;
    y = 100;
    x1 = 50;
    y1 = 150;
  }

  void hello() {
    cal_10_to(s);
    //timer =  new Timer.periodic(second,cal_8_to_2_draw);
    cal_8_to_2_draw();

  }

  void cal_10_to(String s) {
    var x = 10;
    var y = 32;
    List<String> list = new List();
    var len = s.length;
    for (var i = 0;i < len;i++) {
      drawFrame.setFormer(s[i]);
    }
    for (var i = 0;i < len;i++) {
      int b1 = int.parse(s[i]);
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
      if (len2 != 3) {
        for (var i = 0;i < 3 - len2;i++) {
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

  void cal_8_to_2_draw() {
    var content = canvas.getContext('2d');
    content.font="bold 24px Times New Roman";
    content.fillStyle="white";
    var len=drawFrame.getResults().length;
    for(number=0;number<len;number++) {
      content.fillText(drawFrame.getFormer().elementAt(number),x, y);
      x = x + 80;
      content.fillText(drawFrame.getResults().elementAt(number), x1, y1);
      x1=x1+80;
      //number++;
    }
    //else{
    //timer.cancel();
    x=150;y=150;
    x1=150;y1=150;
    number =100;
    sum =0;
    //}
  }

}