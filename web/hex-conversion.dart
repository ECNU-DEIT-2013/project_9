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
  TextAreaElement s2,s8,s10,s16;
  SelectElement select;
  TextInputElement s;


  @override
  void attached() {
    super.attached();
    addButton = $['add'];
    clearButton = $['clear'];
    button2 = $['button2'];
    button8 = $['button8'];
    button10 = $['button10'];
    button16 = $['button16'];
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

  void cal2() {       //将2进制转换为其他进制
    var s=$['text'];
    var s2=$['textarea2'];
    var s8 =$['textarea8'];
    var s10 = $['textarea10'];
    var  s16=$['textarea16'];
    s2.value=s.value;    //2进制自己转换

    s10.value = cal_to_10(2,s).toString();   //将2进制转换成10进制,这句代码是十进制转换成其他进制的前提

    cal_10_to(8,s10.value,s8);  //将2进制转成8进制，第一个参数是进制，第二个参数是十进制数字，第三个参数是输出的结果应该在的位置

    cal_10_to(16,s10.value,s16);

  }

  void cal8() {    //将8进制转换为其他进制
    var s=$['text'];
    var s2=$['textarea2'];
    var s8 =$['textarea8'];
    var s10 = $['textarea10'];
    var s16=$['textarea16'];
    s8.value=s.value;   //将8进制转换成自己
    s10.value =cal_to_10(8,s).toString();   //将8进制转换成10进制,这句代码是十进制转换成其他进制的前提
    cal_10_to(2,s10.value,s2);   //将8进制转换成2进制
    cal_10_to(16,s10.value,s16);    //将8进制转换成16进制
  }

  void cal10() {   //将10进制转换为其他进制
    var s=$['text'];
    var s2=$['textarea2'];
    var s8 =$['textarea8'];
    var s10 = $['textarea10'];
    var s16=$['textarea16'];

    //将10进制转换为2进制,2是进制，$['text'].value是输入值，s2是输出值
    cal_10_to(2,$['text'].value,s2);

    //将10进制转换为8进制
    cal_10_to(8,$['text'].value,s8);

    //将10进制转换为自身
    s10.value =cal_to_10(10,s).toString();

     //将10进制转换为16进制
    cal_10_to(16,$['text'].value,s16);

  }

  void cal16() {       //将16进制转换为其他进制
    var s=$['text'];
    var s2=$['textarea2'];
    var s8 =$['textarea8'];
    var s10=$['text'];
    var s16=$['textarea16'];
    s16.value=s.value;  //将16进制转换成16进制
    $['textarea10'].value =cal_to_10(16,s10).toString();    //将16进制转换成10进制
    cal_10_to(8,$['textarea10'].value,s8);    //将16进制转换成8进制
    cal_10_to(2,$['textarea10'].value,s2);    //将16进制转换成2进制
  }

  void present2(Event e, var detail, Node target) {
    select = $['select'];
    var s=$['text'];
    var s2=$['textarea2'];
    var s8 =$['textarea8'];
    var s10 = $['textarea10'];
    var s16=$['textarea16'];
    canvasClear();
    if (select.options[select.selectedIndex].value == "2") {    //将2进制转换成8进制

    }
    else if (select.options[select.selectedIndex].value == "8") {
      var ss = cal_to_10(8,s).toString();
      cal_to_10_draw(8,s.value);
      cal_10_to_draw(2,ss);
    }
    else if (select.options[select.selectedIndex].value == "10") {
      cal_10_to_draw(2,s.value);
    }
    else if (select.options[select.selectedIndex].value == "16") {
      var ss = cal_to_10(16,s).toString();
      cal_to_10_draw(16,s.value);
      cal_10_to_draw(2,ss);
    }
    else {
      window.alert('Please choose the right number!!');
    }
  }

 int cal_to_10(int jz, var input) {
    String s1 = input.value;
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

    return num1;
  }

  void cal_10_to(int jz,String input,var output)
  {

    var x = 10;
    var y = 32;
    int b1=int.parse(input);
    int s1;
    String s2="";
    while(b1~/jz!=0){
      s1=b1%jz;
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
    output.value=s2;
  }

  void present8(Event e, var detail, Node target) {   //转换为8进制的集合
    select = $['select'];
    var s=$['text'];
    var s2=$['textarea2'];
    var s8 =$['textarea8'];
    var s10 = $['textarea10'];
    var s16=$['textarea16'];
    canvasClear();
    if (select.options[select.selectedIndex].value == "2") {    //将2进制转换成8进制
      var ss = cal_to_10(2,s).toString();
      cal_to_10_draw(2,s.value);
      cal_10_to_draw(8,ss);
    }
    else if (select.options[select.selectedIndex].value == "8") {
      //null
    }
    else if (select.options[select.selectedIndex].value == "10") {
      cal_10_to_draw(8,s.value);
    }
    else if (select.options[select.selectedIndex].value == "16") {
      var ss = cal_to_10(16,s).toString();
      cal_to_10_draw(16,s.value);
      cal_10_to_draw(8,ss);
    }
    else {
      window.alert('Please choose the right number!!');
    }

  }

  void present10(Event e, var detail, Node target) {
    select = $['select'];
    var s=$['text'];
    var s2=$['textarea2'];
    var s8 =$['textarea8'];
    var s10 = $['textarea10'];
    var s16=$['textarea16'];
    canvasClear();
    if (select.options[select.selectedIndex].value == "2") {    //将2进制转换成10进制
        cal_to_10_draw(2,s);

    }
    else if (select.options[select.selectedIndex].value == "8") {
        cal_to_10_draw(8,s);
    }
    else if (select.options[select.selectedIndex].value == "10") {
      //null
    }
    else if (select.options[select.selectedIndex].value == "16") {
       cal_to_10_draw(16,s);
    }
    else {
      window.alert('Please choose the right number!!');
    }

  }

  void present16(Event e, var detail, Node target) {
    select = $['select'];
    var s=$['text'];
    var s2=$['textarea2'];
    var s8 =$['textarea8'];
    var s10 = $['textarea10'];
    var s16=$['textarea16'];
    canvasClear();
    if (select.options[select.selectedIndex].value == "2") {    //将2进制转换成8进制
      var ss = cal_to_10(2,s).toString();
      cal_to_10_draw(2,s);
      cal_10_to_draw(16,ss);
    }
    else if (select.options[select.selectedIndex].value == "8") {
      var ss = cal_to_10(8,s).toString();
      cal_to_10_draw(8,s.value);
      cal_10_to_draw(16,ss);
    }
    else if (select.options[select.selectedIndex].value == "10") {
      cal_10_to_draw(16,s.value);
    }
    else if (select.options[select.selectedIndex].value == "16") {
    }
    else {
      window.alert('Please choose the right number!!');
    }
  }

  int cal_to_10_draw(int jz, var input) {    //将其他进制转换为10进制的图画画出来
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

  void cal_10_to_draw(int jz,String input)     //将10进制转化为其他进制的图画画出来
  {
    var canvas = $['canvas'];
    var content = canvas.getContext('2d');
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
  }

  void drawRect(var content , int x, int y){
    content.strokeStyle ="blue";
    content.lineWidth =2;
    content.strokeRect(10+x,20+y,260-x,30);
    content.fillStyle="white";
    content.fillRect(11+x,19+y,260-x,30);
  }

  void drawFont(var content ,int x, int y, int n,int jz,int yushu){
    //content is the box;x & y is the Coordinates;n is the old number;jz is 进制
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

  void clear(Event e, var detail, Node target) {
    $['text'].value = "";
    $['textarea2'].value = "";
    $['textarea8'].value = "";
    $['textarea10'].value = "";
    $['textarea16'].value = "";

    canvasClear();
  }

  void canvasClear(){
    var canvas = $['canvas'];
    var content = canvas.getContext('2d');
    content.clearRect(0,0,450,570);
  }

}