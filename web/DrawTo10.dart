


import 'DrawFrame.dart';
import 'dart:async';
import 'dart:math' as Math;
class DrawTo10{
  DrawFrame drawFrame;

  var second;
  Timer timer;

  int number;
  int x;
  int y;
  int sum =0;
  int conversion;
  var s;
  var canvas;

  DrawTo10(int conversion , var s ,var canvas){
    drawFrame = new DrawFrame();
    second=new Duration(seconds:1);
    this.conversion =conversion;
    this.s =s;
    this.canvas = canvas;
    number =0;
    x=70;y=70;

  }

  void hello(){
    cal_to_10(conversion,s);
    timer = new Timer.periodic(second,cal_to_10_draw);
  }

  int cal_to_10(int jz, var input) {
    String s1 = input.value;
    int len = s1.length;
    int num10= 0,z=0,m=len-1;
    List<String> bufferList = new List();
    var a = new List<String>();
    for (int i = len - 1;i >= 0;i--){
      if (s1[i] == 'A')a.add('10');
      else if (s1[i] == 'B')a.add('11');
      else if (s1[i] == 'C')a.add('12');
      else if (s1[i] == 'D')a.add('13');
      else if (s1[i] == 'E')a.add('14');
      else if (s1[i] == 'F')a.add('15');
      else a.add(s1[i]);
      num10++;
    }
    for (int i = a.length - 1; i >= 0; i--) {
      bufferList.add(a[i]);
    }    //将字符串顺序转正过来

    drawFrame.setNumbers(bufferList);
    drawFrame.setConversion(jz);

    int num1 = 0;
    for (int i = len - 1;i >= 0;i--) {
      z=int.parse(a[i]);

      num1 = (num1 + Math.pow(jz, i)*z);
    }

    return num1;
  }
  void cal_to_10_draw(Timer _){
    var content = canvas.getContext('2d');
    content.font="bold 24px Times New Roman";
    content.fillStyle="grey";
    var length =drawFrame.getNumbers().length;
    if(number<length){
      content.fillText('+',x-15*2,y);

      sum=sum+int.parse(drawFrame.getNumbers().elementAt(number))*Math.pow(drawFrame.getConversion(),length-1-number);
      content.fillText('${drawFrame.getNumbers().elementAt(number)}',x,y);
      content.fillText('×',x+15*2,y);
      content.fillText('${drawFrame.getConversion()}'+'^'+'${length-1-number}',x+15*4,y);
      content.fillText('——————',x,y+30);
      //content.fillText('${sum}',x+30,y+60);
      y=y+80;
      number++;
    }else
    {
      timer.cancel();
      x=70;y=70;
      number =0;
      sum =0;
    }
  }
}