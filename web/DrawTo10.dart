


import 'DrawFrame.dart';
import 'dart:async';
import 'dart:math' as Math;
import 'dart:html';
class DrawTo10{
  DrawFrame drawFrame;

  var second;
  Timer timer;

  // ImageElement img = new ImageElement();

  int number;
  int x;
  int y;
  int sum =0;
  int conversion;
  var s;
  var canvas;

  DrawTo10(int conversion , var s ,var canvas){
    drawFrame = new DrawFrame();
    second=new Duration(seconds:2);
    this.conversion =conversion;
    this.s =s;
    this.canvas = canvas;
    number =0;
    x=150;y=50;

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
    var width;
    //img.src="num.png";

    // content.drawImage(img,100,100,111,157);
    if(number<length){
      if(number==0){
        var temp=150;//number是整个数组中的第几个成员
        sum=sum+int.parse(drawFrame.getNumbers().elementAt(number))*Math.pow(drawFrame.getConversion(),length-1-number);

        for(var j=0;j<length;j++){
          if(j==number){
            content.fillStyle="blue";
            content.fillText('${drawFrame.getNumbers().elementAt(j)}',temp-100,y);
            temp=temp+15;
          }
          else{
            content.fillStyle="grey";
            content.fillText('${drawFrame.getNumbers().elementAt(j)}',temp-100,y);
            temp=temp+15;
          }
        }
        x=temp;

        content.fillStyle="blue";
        content.fillText('${drawFrame.getNumbers().elementAt(number)}',x,y);
        content.fillStyle="grey";
        content.fillText('×',x+15*2,y);
        content.fillStyle="pink";
        content.fillText('${drawFrame.getConversion()}'+'^'+'${length-1-number}',x+15*4,y);
        y=y+50;
        number++;

      }else{
        if(number<length-1){
          var temp =150;

          for(var j=0;j<length;j++){
            if(j==number){
              content.fillStyle="blue";
              content.fillText('${drawFrame.getNumbers().elementAt(j)}',temp-100,y);
              temp=temp+15;
            }
            else{
              content.fillStyle="grey";
              content.fillText('${drawFrame.getNumbers().elementAt(j)}',temp-100,y);
              temp=temp+15;
            }
          }
          x=temp;

          content.fillText('+',x-15*2,y);

          sum=sum+int.parse(drawFrame.getNumbers().elementAt(number))*Math.pow(drawFrame.getConversion(),length-1-number);
          content.fillStyle="blue";
          content.fillText('${drawFrame.getNumbers().elementAt(number)}',x,y);
          content.fillStyle="grey";
          content.fillText('×',x+15*2,y);
          content.fillStyle="pink";
          content.fillText('${drawFrame.getConversion()}'+'^'+'${length-1-number}',x+15*4,y);
          y=y+50;
          number++;

        }
        else{   //所有值的最后一列
          var temp =150;

          for(var j=0;j<length;j++){
            if(j==number){
              content.fillStyle="blue";
              content.fillText('${drawFrame.getNumbers().elementAt(j)}',temp-100,y);
              temp=temp+15;
            }
            else{
              content.fillStyle="grey";
              content.fillText('${drawFrame.getNumbers().elementAt(j)}',temp-100,y);
              temp=temp+15;
            }
          }
          x=temp;

          content.fillStyle="grey";
          content.fillText('+',x-15*2,y);
          content.fillStyle="blue";
          sum=sum+int.parse(drawFrame.getNumbers().elementAt(number))*Math.pow(drawFrame.getConversion(),length-1-number);
          content.fillText('${drawFrame.getNumbers().elementAt(number)}',x,y);
          content.fillStyle="grey";
          content.fillText('×',x+15*2,y);
          content.fillStyle="pink";
          content.fillText('${drawFrame.getConversion()}'+'^'+'${length-1-number}',x+15*4,y);
          content.fillStyle="grey";
          content.fillText('——————',x-15*2,y+25);
          content.fillStyle="black";
          content.fillText('${sum}',x+60,y+50);
          number++;
        }

      }

    }else
    {
      timer.cancel();
      x=150;y=150;
      number =0;
      sum =0;
    }
  }
}