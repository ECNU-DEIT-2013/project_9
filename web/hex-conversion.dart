// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'dart:async';
import 'package:polymer/polymer.dart';

@CustomTag('hex-conversion')
class HexConversion extends PolymerElement {
  @observable String counter = '00:00';

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
    //text=$['text'];
    select = $['select'];
  }

  @override
  void detached() {
    super.detached();
  }

  void add(Event e, var detail, Node target) {
    select = $['select'];
    if (select.options[select.selectedIndex].value == "2") {
      var s=$['text'];
      $['textarea10'].value = zhuanshi(2,s);
      //  var s=$['textarea8'];
      // zhuanhuan(8,s);

    }
    else if (select.options[select.selectedIndex].value == "8") {
      var s=$['text'];
      $['textarea8'].value = zhuanshi(8,s);
    }
    else if (select.options[select.selectedIndex].value == "10") {
      $['textarea10'].value = "10";
    }
    else if (select.options[select.selectedIndex].value == "16") {
      $['textarea16'].value = "16";
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
  }

  void present2(Event e, var detail, Node target) {

    var canvas = $['canvas'];
    var content = canvas.getContext('2d');
    //var value = int.parse( $['text'].value);
    var x = 10;
    var y = 32;
    for (var i = 0;i <= 20;i++) {
      drawRect(content, x, y);
      drawFont(content, x, y, i);
      x = x + 10;
      y = y + 32;
    }
    var s = $['textarea2'];
    zhuanhuan(2, s);

  }
  void zhuanshi(int jz, var input) {
    int b1 = int.parse($['text'].value);
    String s1 = b1.toString();
    int len = s1.length();
    print(len);
    int num,m = 0;
    var a = new List<String>();
    a.add(s1);
    for (int i = len - 1;i >= 0;i--){
      a[m]= s1.substring(i,i-1);
      m++;
    }

    print(a);

    assert(a is String);
    for (int i = len - 1;i >= 0;i--) {
      if (a[i] != '0' && a[i] != '1') {
        //System.out.println("input?wrong!!");
        num = 0;
        break;
      }
      num = (int)(num + Math.pow(2, (len - 1) - i));
    }
    input.value=num;
    return num;
  }
  void zhuanhuan(int jz,var input)
  {
    int b1=int.parse($['text'].value);
    int s1;
    String s2="";
    while(b1~/jz!=0){
      s1=b1%jz;
      b1=b1~/jz;
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
    input.value=s2;
  }
  void present8(Event e, var detail, Node target) {
    //$['text'].value="hello";
    var s=$['textarea8'];
    zhuanhuan(8,s);
  }
  void present10(Event e, var detail, Node target) {
    //$['text'].value="hello";
    var s=$['textarea10'];
    zhuanhuan(10,s);
  }
  void present16(Event e, var detail, Node target) {
    //$['text'].value="hello16";
    var s=$['textarea16'];
    zhuanhuan(16,s);
  }
  void drawRect(var content , int x, int y){
    content.strokeStyle ="bule";
    content.lineWidth =2;
    content.strokeRect(10+x,20+y,260-x,30);
    content.fillStyle="white";
    content.fillRect(11+x,19+y,260-x,30);
  }

  void drawFont(var content ,int x, int y, int n){
    content.font="bold 24px Times  New Roman";
    content.fillStyle="grey";
    content.fillText('$n',130+x/2,43+y);
    content.fillText('2',x-5,43+y);
  }


}
