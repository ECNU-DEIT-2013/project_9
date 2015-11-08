// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'dart:async';
import 'package:polymer/polymer.dart';

@CustomTag('hex-conversion')
class HexConversion extends PolymerElement {
  @observable String counter='00:00';

  HexConversion.created() : super.created();

  ButtonElement addButton,clearButton,button2,button8,button10,button16;
  TextAreaElement textarea2,textarea8,textarea10,textarea16;
  SelectElement select;

  @override
  void attached() {
    super.attached();
    addButton=$['add'];
    clearButton=$['clear'];
    button2=$['button2'];
    button8=$['button8'];
    button10=$['button10'];
    button16=$['button16'];
    textarea2=$['textarea2'];
    textarea8=$['textarea8'];
    textarea10=$['textarea10'];
    textarea16=$['textarea16'];
    //text=$['text'];
    select=$['select'];
  }

  @override
  void detached() {
    super.detached();
  }

  void add(Event e, var detail, Node target) {
    select=$['select'];
    if(select.options[select.selectedIndex].value=="2"){
      $['textarea2'].value="hello";
    }
    else if(select.options[select.selectedIndex].value=="8")
    {
      $['textarea8'].value="8";
    }
    else if(select.options[select.selectedIndex].value=="10")
    {
      $['textarea10'].value="10";
    }
    else if(select.options[select.selectedIndex].value=="16")
    {
      $['textarea16'].value="16";
    }
    else{
      window.alert('Please choose the right number!!');
    }
  }

  void clear(Event e, var detail, Node target) {
    $['text'].value="";
    $['textarea2'].value="";
    $['textarea8'].value="";
    $['textarea10'].value="";
    $['textarea16'].value="";
  }

  void present2(Event e, var detail, Node target){
    var canvas =$['canvas'];
    var content= canvas.getContext('2d');
    //var value = int.parse( $['text'].value);
    var x=10;
    var y=32;
    for(var i=0;i<=20;i++){
      drawRect(content,x,y);
      drawFont(content,x,y,i);
      x=x+10;
      y=y+32;
    }

  }
  void present8(Event e, var detail, Node target) {
    $['text'].value="hello";
  }
  void present10(Event e, var detail, Node target) {
    $['text'].value="hello";
  }
  void present16(Event e, var detail, Node target) {
    $['text'].value="hello";
  }
  void drawRect(var content , int x, int y){
    content.strokeStyle ="bule";
    content.lineWidth =2;
    content.strokeRect(10+x,20+y,60,30);
    content.fillStyle="white";
    content.fillRect(11+x,19+y,60,30);
  }

  void drawFont(var content ,int x, int y, int n){
    content.font="bold 24px Times New Roman";
    content.fillStyle="grey";
    content.fillText('$n',30+x,43+y);
  }

}
