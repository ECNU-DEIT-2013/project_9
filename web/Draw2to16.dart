library drawry;
import 'DrawFrame.dart';
import 'dart:async';
import 'dart:math' as Math;

class Draw2to16{

  DrawFrame drawFrame;

  var second;
  Timer timer;

  int number;
  int x,x1;
  int y,y1;
  int sum =0;
  var s;
  var canvas;

  Draw2to16(String s,var canvas){
    drawFrame = new DrawFrame();
    second=new Duration(seconds:2);
    this.s =s;
    this.canvas = canvas;
    number =0;
    x=150;y=50;
    x1=154;y1=150;
  }

  void hello(){
    cal_2_to_16(s);
    timer = new Timer.periodic(second,cal_2_to_16_draw);
  }


  void cal_2_to_16(String s){

    var str;
    var buffer = new StringBuffer();
    var bufferTra = new StringBuffer();
    var len= s.length;

    if(len%4!=0) {
      for (var i = 0;i < 4 - len %4;i++) {
        buffer.write("0");
      }
    }
    buffer.write(s);   //将buffer的字符位数添加到4的整数倍

    str =buffer.toString();
    var strLen=str.length;

    for(var i=0;i<strLen;i++){
      bufferTra.write(str[i]);
      if((i+1)%4==0){
        drawFrame.setResults(bufferTra.toString());
        bufferTra.clear();
      }
    }             //将buffer中字符每三个一位添加到数组里面


    int num,z;
    List<String> list = new List();

    var len1=drawFrame.getResults().length;
    for(int i=0;i<len1;i++){
      String c=drawFrame.getResults().elementAt(i);
      num=0;z=0;
      for (int j =0;j<4;j++){
        z = int.parse(c[j]);
        num= num+ Math.pow(2, (3-j)) * z;
      }
      if (num == 10)list.add('A');
      else if (num== 11)list.add('B');
      else if (num== 12)list.add('C');
      else if (num == 13)list.add('D');
      else if (num== 14)list.add('E');
      else if (num == 15)list.add('F');
      else if(num<10) list.add(num.toString());
    }
    drawFrame.setNumbers(list);
  }

  void cal_2_to_16_draw(Timer _){
    var content = canvas.getContext('2d');
    content.font="bold 24px Times New Roman";
    content.fillStyle="white";
    var len=drawFrame.getResults().length;
    if(number<len) {
      content.fillText(drawFrame.getResults().elementAt(number), x, y);
      x = x + 72;
      content.fillText(drawFrame.getNumbers().elementAt(number), x1, y1);
      x1=x1+79;
      number++;
    }
    else{
      timer.cancel();
      x=150;y=150;
      x1=150;y1=150;
      number =0;
      sum =0;
    }


  }



}





