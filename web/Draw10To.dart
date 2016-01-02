
library art;

import 'DrawFrame.dart';
import 'dart:async';
class Draw10To{
  DrawFrame drawFrame;
  DrawFrame drawFrame2;
  var second;
  Timer timer;
  int number;
  int x;
  int y;
  int sum =0;
  int conversion;//目标进制
  var s;//text框
  var canvas;
  var a1=[],c1=[],b1=[];
  var old_number;

  Draw10To(int conversion , var s ,var canvas){
    drawFrame = new DrawFrame();
    drawFrame2=new DrawFrame();
    second=new Duration(seconds:1);
    this.conversion =conversion;
    this.s =s;
    this.canvas = canvas;
    number =0;
    x=50;y=50;

  }

  void hello(){
    cal_10_to(conversion,s);
    timer = new Timer.periodic(second,cal_10_to_draw);
  }


  void cal_10_to(int jz, var input) {

    old_number=input.value;
    int a =int.parse(input.value);
    int b,c;
    c1.add(a.toString());
    while(a!=0){
      b=a%jz;
      c=a~/jz;
      b1.add(b.toString());//b1数组存放余数,以String形式
      c1.add(c.toString());//c1数组存放商
      a=c;
    }
    c1.add('0');
    for (int i = b1.length - 1; i >= 0; i--) {
      a1.add(b1[i]);

    }    //将字符串顺序转正过来
    drawFrame.setNumbers(b1);
    drawFrame.setConversion(jz);

    drawFrame2.setNumbers(c1);
    drawFrame2.setConversion(jz);
  }

  void cal_10_to_draw(Timer _){
    var content = canvas.getContext('2d');
    content.font="bold 24px Times New Roman";
    content.fillStyle="pink";
    var length =drawFrame.getNumbers().length;
    if(number<length){
      content.fillText('$conversion',x-15,y);
      content.fillStyle="white";
      content.fillText('${drawFrame2.getNumbers().elementAt(number)}',x+length*5,y);
      content.fillText('${drawFrame.getNumbers().elementAt(number)}',length*20+140,y);
      content.moveTo(x,y-30);
      content.lineTo(x,y+10);
      content.lineTo(length*20+130,y+10);
      content.stroke();
      x=x+20;
      y=y+40;
      number++;
    }else if(number==length){
      content.fillStyle="white";
      content.fillText('${drawFrame2.getNumbers().elementAt(number)}',x+length*5-20,y);
      content.fillStyle="yellow";
      content.fillText('所以($old_number)',x-length*20,y+40);
      x=x+15*old_number.length+60-length*20;
      content.font="bold 16px Times New Roman";
      content.fillText('10',x,y+40);
      x=x+20;
      content.font="bold 24px Times New Roman";
      content.fillText('= (',x,y+40);
      x=x+30;
      for(int i=0;i<a1.length;i++){
        content.fillText('${a1[i]}',x,y+40);
        x=x+12;
      }
      content.fillText(')',x,y+40);
      x=x+10;
      content.font="bold 16px Times New Roman";
      content.fillText('$conversion',x,y+40);
      number++;
    }else
    {
      timer.cancel();
      x=50;y=50;
      number =0;
      sum =0;
    }
  }
}