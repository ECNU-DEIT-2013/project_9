// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'dart:async';
import 'package:polymer/polymer.dart';
import  'dart:math' as Math;

@CustomTag('hex-conversion')
class HexConversion extends PolymerElement {

  HexConversion.created() : super.created();

  ButtonElement addButton, clearButton, button2, button8, button10, button16;
  TextAreaElement textarea2, textarea8, textarea10, textarea16;
  SelectElement select;

  @override
  void attached() {
    super.attached();
    addButton = $['add'];
    clearButton = $['clear'];
    button2 = $['button2'];
    button8 = $['button8'];
    button10 = $['button10'];
    button16 = $['button16'];
    textarea2 = $['textarea2'];
    textarea8 = $['textarea8'];
    textarea10 = $['textarea10'];
    textarea16 = $['textarea16'];
    select = $['select'];
  }

  @override
  void detached() {
    super.detached();
  }

  void add(Event e, var detail, Node target) {
    select = $['select'];
    if (select.options[select.selectedIndex].value == "2") {
      cal2();
    }
    else if (select.options[select.selectedIndex].value == "8") {
      cal8();
    }
    else if (select.options[select.selectedIndex].value == "10") {
      cal10();
    }
    else if (select.options[select.selectedIndex].value == "16") {
      cal16();
    }
    else {
      window.alert('Please choose the right number!!');
    }
  }

  void clear(Event e, var detail, Node target) {
    $['text'].value = "";
    $['textarea2'].value = "";
    $['textarea8'].value = "";
    $['textarea10'].value = "";
    $['textarea16'].value = "";

    var canvas = $['canvas'];
    var content = canvas.getContext('2d');
    canvasclear(content);
  }
  void cal2() {       //将2进制转换为其他进制
    var s=$['text'];
    $['textarea10'].value = cal_to_10(2,s).toString();   //将2进制转换成10进制

    cal_10_to(8,cal_to_10(2,s).toString(),$['textarea8']);  //将2进制转成8进制

  }

  void cal8() {    //将8进制转换为其他进制
    var s=$['text'];
    $['textarea10'].value =cal_to_10(8,s).toString();   //将8进制转换成10进制
  }

  void cal10() {   //将10进制转换为其他进制
    var s2 = $['textarea2'];           //将10进制转换为2进制,2是进制，$['text'].value是输入值，s2是输出值
    cal_10_to(2,$['text'].value,s2);

    var s8=$['textarea8'];
    cal_10_to(8,$['text'].value,s8);                       //将10进制转换为8进制

    var s10=$['text'];
    $['textarea10'].value =cal_to_10(10,s10).toString();        //将10进制转换为自身

    var s16=$['textarea16'];      //将10进制转换为16进制
    cal_10_to(16,$['text'].value,s16);

  }

  void cal16() {       //将16进制转换为其他进制
    var s10=$['text'];
    $['textarea10'].value =cal_to_10(16,s10).toString();    //将16进制转换成10进制
  }

  void present2(Event e, var detail, Node target) {



  }
 int cal_to_10(int jz, var input) {
   var canvas = $['canvas'];
   var content = canvas.getContext('2d');
    String s1 = $['text'].value;
    int len = s1.length;
    int num= 0,z=0,m=len-1;
    var a = new List<String>();
    for (int i = len - 1;i >= 0;i--){
       if (s1[i] == 'A')a.add('10');
       else if (s1[i] == 'B')a.add('11');
       else if (s1[i] == 'C')a.add('12');
       else if (s1[i] == 'D')a.add('13');
       else if (s1[i] == 'E')a.add('14');
       else if (s1[i] == 'F')a.add('15');
       else a.add(s1[i]);
      num++;
    }



   int num1 = 0;
    for (int i = len - 1;i >= 0;i--) {
     z=int.parse(a[i]);

     num1 = (num1 + Math.pow(jz, i)*z);
    }
   drawFont3(content,50,50,s1,num1);
    return num1;

  }
  void cal_10_to(int jz,String input,var output)
  {
    var canvas = $['canvas'];
    var content = canvas.getContext('2d');
    //var value = int.parse( $['text'].value);
    var x = 10;
    var y = 32;
    int b1=int.parse(input);
    int s1;
    String s2="";
    while(b1~/jz!=0){
      s1=b1%jz;
      drawRect(content, x, y);
      drawFont(content, x, y, b1,jz,s1);
      b1=b1~/jz;
      x = x + 10;
      y = y + 32;
      if(s1<10){
        s2=s1.toString()+s2;
      }
      else{
        if(s1==10){s2='A'+s2;}
        else if(s1==11){s2='B'+s2;}
        else if(s1==12){s2='C'+s2;}
        else if(s1==13){s2='D'+s2;}
        else if(s1==14){s2='E'+s2;}
        else{s2='F'+s2;}
      }
    }
    if(b1<10){
      s2=b1.toString()+s2;
    }
    else{
      if(b1==10){s2='A'+s2;}
      else if(b1==11){s2='B'+s2;}
      else if(b1==12){s2='C'+s2;}
      else if(b1==13){s2='D'+s2;}
      else if(b1==14){s2='E'+s2;}
      else{s2='F'+s2;}
    }
    drawFont2(content, x, y,b1);
    output.value=s2;
  }
  void present8(Event e, var detail, Node target) {


  }

  void present10(Event e, var detail, Node target) {

  }

  void present16(Event e, var detail, Node target) {

  }

  void drawRect(var content , int x, int y){
    content.strokeStyle ="bule";
    content.lineWidth =2;
    content.strokeRect(10+x,20+y,260-x,30);
    content.fillStyle="white";
    content.fillRect(11+x,19+y,260-x,30);
  }

  void drawFont(var content ,int x, int y, int n,int jz,int yushu){
    //content is the box;x & y is the Coordinates;n is the old number;jz is jinzhi
    content.font="bold 24px Times  New Roman";
    content.fillStyle="grey";
    int zuo;
    if(jz==2 || jz==8){
      zuo=x-5;
    }
    else{
      zuo=x-15;
    }
    content.fillText('$n',130+x/2,43+y);
    content.fillText('$yushu',300,43+y);
    content.fillText('$jz',zuo,43+y);
  }
  void drawFont2(var content ,int x, int y, int n){
    content.font="bold 24px Times  New Roman";
    content.fillStyle="grey";
    content.fillText('$n',130+x/2,43+y);
  }
  void drawFont3(var content, int x, int y, String n,int m){
    content.font="bold 24px Times New Roman";
    content.fillStyle="grey";
    for(var i=0;i<n.length;i++){
      content.fillText('${n[i]}',x,y+10);
      content.fillText('*',x+15,y+10);
      content.fillText('2',x+30,y+10);
      content.fillText('^',x+45,y+10);
      content.fillText('${n.length-i-1}',x+60,y+10);
      if(i<=n.length-2){
        content.fillText('+',x+75,y+10);
      }
      x=x+90;
    }
    content.fillText('=',x-10,y+10);
    content.fillText('${m.toString()}',x+5,y+10);
  }
  void canvasclear(var content){
    content.clearRect(0,0,450,570);
  }

}
