// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'dart:convert';
import 'package:polymer/polymer.dart';
import 'package:dialog/dialog.dart';
import  'dart:math' as Math;
import 'dart:async';
import 'DrawTo10.dart';
import 'Draw10To.dart';
import 'Draw2to8.dart';
import 'Draw8to2.dart';
import 'Draw16to2.dart';
import 'Draw2to16.dart';
import 'Img.dart';
import 'Star.dart';



@CustomTag('hex-conversion')
class HexConversion extends PolymerElement {

  HexConversion.created() : super.created();

  DrawTo10 draw10;
  Draw10To draw10to;
  Draw2to8 draw2to8;
  Draw2to16 draw2to16;
  Draw8to2 draw8to2;
  Draw16to2 draw16to2;
  Img imgIns;
  Star star;



  ButtonElement addButton, clearButton, button2, button8, button10, button16;
  TextAreaElement s2,s8,s10,s16;
  SelectElement select;
  TextInputElement s;
  DivElement div1,div2,div3;
  String rightopt_id;//习题部分正确的选项号
  var que_num=2;//习题部分题号
  HttpRequest request;


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
    var s=$['text'];

    div1=$['left_top'];
    div3=$['scroll-1'];
    div3.style.display="block";
    div2=$['left_beneath'];
    DivElement smallImg=$['clickbox'] ;
    var judge;

    if(smallImg.childNodes.length>3){
      smallImg.lastChild.remove();
    }


    if (select.options[select.selectedIndex].value == "2") {
      judge=findMaxT(s.value,2);

      if(judge){
        div1.style.display="none";
        div2.style.display="block";

        cal2();
      }
      else{
        alert("请输入符合进制的数字！");
        div3.style.display="none";
      }

    }
    else if (select.options[select.selectedIndex].value == "8") {
      judge=findMaxT(s.value,8);

      if(judge){
        div1.style.display="none";
        div2.style.display="block";

        cal8();
      }
      else{
        alert("请输入符合进制的数字！");
        div3.style.display="none";
      }
      //cal8();
    }
    else if (select.options[select.selectedIndex].value == "10") {
      judge=findMaxT(s.value,10);

      if(judge){
        div1.style.display="none";
        div2.style.display="block";

        cal10();
      }
      else{
        alert("请输入符合进制的数字！");
        div3.style.display="none";
      }
    }
    else if (select.options[select.selectedIndex].value == "16") {
      judge=findMaxT(s.value,16);

      if(judge){
        div1.style.display="none";
        div2.style.display="block";

        cal16();
      }
      else{
        alert("请输入符合进制的数字！");
        div3.style.display="none";
      }
    }

  }
  void clear(Event e, var detail, Node target) {
    $['text'].value = "";
    select = $['select'];
    addTempCanvas();
  }

  void rereturn(Event e, var detail, Node target){
    div1=$['left_top'];
    div1.style.display="block";
    div2=$['exercise_block'];
    div2.style.display="none";
    div1=$['left_beneath'];
    div1.style.display="none";
    div3=$['scroll-1'];
    div3.style.display="none";
    div3=$['QaA'];
    div3.style.display="none";
    div3=$['exe_area'];
    div3.style.display="block";
    $['text'].value = "";
    $['textarea2'].value = "";
    $['textarea8'].value = "";
    $['textarea10'].value = "";
    $['textarea16'].value = "";
    drawLittleStar(0);
    addTempCanvas();
    DivElement smallImg=$['clickbox'] ;

    if(smallImg.childNodes.length>3){
      smallImg.lastChild.remove();
    }
  }
  void opentest(Event e, var detail, Node target){//习题功能
    div1=$['left_top'];
    div1.style.display="none";
    div2=$['exercise_block'];
    div2.style.display="block";
  }

  makeRequest(Event e) async {
    //var path = 'https://www.dartlang.org/f/portmanteaux.json';
    div1=$['radio'];
    div1.style.display="block";
    div2=$['check'];
    div2.style.display="block";
    div3=$['QaA'];
    div3.style.display="block";
    div3=$['exe_area'];
    div3.style.display="none";
    var path = 'http://127.0.0.1:8080/first';
    que_num=2;
    try {
      processString(await HttpRequest.getString(path));
    } catch (e) {
      print('Couldn\'t open $path');
      handleError(e);
    }
  }

  processString(String jsonString) {
    List<String> portmanteaux = JSON.decode(jsonString);
    LIElement wordList = $['wordList'];
    FormElement radiolist=$['radio'];
    wordList.children.clear();
    wordList.children.add(new LIElement()..text = portmanteaux[0]);
    rightopt_id=portmanteaux[portmanteaux.length-1];
    for (int i = 1; i < portmanteaux.length-1; i++) {
      String radname='rad'+i.toString();
      LIElement rad1=$[radname];
      rad1.children.clear();
      rad1.children.add(new LIElement()..text=portmanteaux[i]);
    }
  }
  handleError(Object error) {
    LIElement wordList = $['wordList'];
    wordList.children.add(new LIElement()..text = 'Request failed.');
  }


  void check(Event e, var detail, Node target){
    String radname='opt'+rightopt_id;
    InputElement rad=$[radname];
    if(rad.checked){
      LIElement wordList = $['wordList'];
      wordList.children.add(
          new LIElement()..style.color="#88f875"
            ..text = '正确');
    }
    else{
      LIElement wordList = $['wordList'];
      wordList.children.add(new LIElement()..style.color="#ff3916"
        ..text = '错误');
    }
  }

  next (Event e, var detail, Node target){
    var tihao = que_num.toString();
    que_num=que_num+1;
    request = new HttpRequest();
    request.open('POST','http://127.0.0.1:8080/next');
    request.onReadyStateChange.listen(absence);
    request.send(JSON.encode(tihao));
  }

  absence(_) {
    if (request.status == 200) {
      List<String> portmanteaux = JSON.decode(request.responseText);
      LIElement wordList = $['wordList'];
      wordList.children.clear();
      wordList.children.add(new LIElement()..text = portmanteaux[0]);
      rightopt_id=portmanteaux[portmanteaux.length-1];
      for (int i = 1; i < portmanteaux.length-1; i++) {
        String radname='rad'+i.toString();
        LIElement rad1=$[radname];
        rad1.children.clear();
        rad1.children.add(new LIElement()..text=portmanteaux[i]);
      }
    }else{
      //stu_name.text = 'ERROR:${request.status}';
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

      s8.value = s.value; //将8进制转换成自己
      s10.value = cal_to_10(8, s).toString(); //将8进制转换成10进制,这句代码是十进制转换成其他进制的前提
      cal_10_to(2, s10.value, s2); //将8进制转换成2进制
      cal_10_to(16, s10.value, s16); //将8进制转换成16进制

  }

  void cal10() {   //将10进制转换为其他进制
    var s=$['text'];
    var s2=$['textarea2'];
    var s8 =$['textarea8'];
    var s10 = $['textarea10'];
    var s16=$['textarea16'];


     cal_10_to(2, $['text'].value, s2);

     cal_10_to(8, $['text'].value, s8);

     s10.value = cal_to_10(10, s).toString();

     cal_10_to(16, $['text'].value, s16);

  }

  void cal16() {       //将16进制转换为其他进制
    var s=$['text'];
    var s2=$['textarea2'];
    var s8 =$['textarea8'];
    var s10=$['text'];
    var s16=$['textarea16'];

      s16.value = s.value;
      $['textarea10'].value = cal_to_10(16, s10).toString(); //将16进制转换成10进制
      cal_10_to(8, $['textarea10'].value, s8); //将16进制转换成8进制
      cal_10_to(2, $['textarea10'].value, s2); //将16进制转换成2进制

  }

bool findMaxT(String s,int con) {
    List<String> list = new List();
    int max = 0;
    for (var i = 0; i < s.length; i++) {
      list.add(s[i].toUpperCase());
      switch (list[i]) {
        case 'A':
          list[i] = 10.toString();
          break;
        case 'B':
          list[i] = 11.toString();
          break;
        case 'C':
          list[i] = 12.toString();
          break;
        case 'D':
          list[i] = 13.toString();
          break;
        case 'E':
          list[i] = 14.toString();
          break;
        case 'F':
          list[i] = 15.toString();
          break;
        case '0':
        case'1':
        case'2':
        case'3':
        case'4':
        case'5':
        case'6':
        case'7':
        case'8':
        case'9': list[i] =list[i];
        break;
        default:
          list[i]=16.toString();
      }
    }

    for (var i=0;i<list.length;i++){
      if(int.parse(list[i])>max)
        max=int.parse(list[i]);
    }

    if(max>=con){
      return false;
    }
    else
      return true;
  }

  void present2(Event e, var detail, Node target) {
    select = $['select'];
    var s=$['text'];
    DivElement smallImg=$['clickbox'] ;
    DivElement biggerImg =$['box'];
    DivElement close =$['close'];

    var canvasTemp =addTempCanvas();

    drawLittleStar(2);

    if (select.options[select.selectedIndex].value == "2") {    //将2进制转换成8进制
      alert("同一进制数不能转换成自己");
    }
    else if (select.options[select.selectedIndex].value == "8") {
      draw8to2 = new Draw8to2(s.value,canvasTemp,smallImg, biggerImg,close,10,180);
      draw8to2.hello_copy();    //有动画的带_copy.
    }
    else if (select.options[select.selectedIndex].value == "10") {

      draw10to = new Draw10To(2,s,canvasTemp);
      draw10to.hello();
    }
    else if (select.options[select.selectedIndex].value == "16") {

      draw16to2 = new Draw16to2(s.value,canvasTemp,smallImg, biggerImg,close,10,180);
      draw16to2.hello_copy();
    }

  }

  int cal_to_10(int jz, var input) {
    String s1 = input.value;
    int len = s1.length;
    int num10= 0,z=0,m=len-1;
    var a = new List<String>();
    for (int i = len - 1;i >= 0;i--){
      if (s1[i].toUpperCase() == 'A')a.add('10');
      else if (s1[i].toUpperCase() == 'B')a.add('11');
      else if (s1[i].toUpperCase() == 'C')a.add('12');
      else if (s1[i].toUpperCase() == 'D')a.add('13');
      else if (s1[i].toUpperCase() == 'E')a.add('14');
      else if (s1[i].toUpperCase() == 'F')a.add('15');
      else a.add(s1[i]);
      num10++;
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
    DivElement smallImg=$['clickbox'] ;
    DivElement biggerImg =$['box'];
    DivElement close =$['close'];
    drawLittleStar(8);

    var canvasTemp =addTempCanvas();
    if (select.options[select.selectedIndex].value == "2") {    //将2进制转换
      draw2to8 = new Draw2to8(s.value,canvasTemp,smallImg, biggerImg,close,10,180);
      draw2to8.hello();
    }
    else if (select.options[select.selectedIndex].value == "8") {
      alert("同一进制数不能转换成自己");
    }
    else if (select.options[select.selectedIndex].value == "10") {
      draw10to = new Draw10To(8,s,canvasTemp);
      draw10to.hello();
    }
    else if (select.options[select.selectedIndex].value == "16") {

      imgIns = new Img(smallImg,biggerImg,close);
      imgIns.img_16_to_8();
      draw16to2 = new Draw16to2(s.value,canvasTemp,null,null,null,15,100);
      draw16to2.hello();
      draw2to8 = new Draw2to8(s2.value,canvasTemp,null,null,null,10,250);
      draw2to8.hello();
    }

  }

  void present10(Event e, var detail, Node target) {
    select = $['select'];
    var s=$['text'];
    DivElement smallImg=$['clickbox'] ;
    drawLittleStar(10);

    if(smallImg.childNodes.length>3){
      smallImg.lastChild.remove();
    }
    var canvasTemp =addTempCanvas();
    if (select.options[select.selectedIndex].value == "2") {    //将2进制转换成10进制
      draw10 = new DrawTo10(2,s,canvasTemp);
      draw10.hello();
    }
    else if (select.options[select.selectedIndex].value == "8") {
      draw10 = new DrawTo10(8,s,canvasTemp);
      draw10.hello();
    }
    else if (select.options[select.selectedIndex].value == "16") {

      draw10 = new DrawTo10(16,s,canvasTemp);
      draw10.hello();
    }
    else {
      alert("同一进制数不能转换成自己");
    }

  }

  void present16(Event e, var detail, Node target) {
    select = $['select'];
    var s=$['text'];
    var s2=$['textarea2'];

    DivElement smallImg=$['clickbox'] ;
    DivElement biggerImg =$['box'];
    DivElement close =$['close'];
    drawLittleStar(16);

    var canvasTemp =addTempCanvas();
    if (select.options[select.selectedIndex].value == "2") {    //将2进制转换成16进制
      draw2to16 = new Draw2to16(s.value,canvasTemp,smallImg, biggerImg,close,10,180);
      draw2to16.hello();
    }
    else if (select.options[select.selectedIndex].value == "8") {       //将8进制转换成16进制
      imgIns = new Img(smallImg,biggerImg,close);
      imgIns.img_8_to_16();
      draw8to2 = new Draw8to2(s.value,canvasTemp,null,null,null,20,100);
      draw8to2.hello();
      draw2to16 = new Draw2to16(s2.value,canvasTemp,null,null,null,10,250);
      draw2to16.hello();
    }
    else if (select.options[select.selectedIndex].value == "10") {
      draw10to = new Draw10To(16,s,canvasTemp);
      draw10to.hello();
    }
    else if (select.options[select.selectedIndex].value == "16") {
      alert("同一进制数不能转换成自己");
    }

  }

  void drawLittleStar(int con){
    DivElement con10 = $['con10'];
    DivElement con8 = $['con8'];
    DivElement con2 = $['con2'];
    DivElement con16 = $['con16'];

    star = new Star(con,con2,con8,con10,con16);
    star.drawLittleStar();
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

  CanvasElement addTempCanvas(){
    $['scroll-1'].children.clear();
    var canvas = new CanvasElement();
    canvas..width =1000
      ..height=1000
      ..id='canvasTemp';
    $['scroll-1'].children.add(canvas);
    return canvas;
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





}