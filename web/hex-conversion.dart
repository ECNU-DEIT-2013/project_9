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

  ButtonElement stopButton;
  ButtonElement startButton;
  ButtonElement resetButton;
    
  @override
  void attached() {
    super.attached();
    startButton = $['startButton'];
    stopButton = $['stopButton'];
    resetButton = $['resetButton'];

    stopButton.disabled = true;
    resetButton.disabled = true;
  }
  
  @override
  void detached() {
    super.detached();
  }
  
  void start(Event e, var detail, Node target) {
    startButton.disabled = true;
    stopButton.disabled = false;
    resetButton.disabled = true;
  }
  
  void stop(Event e, var detail, Node target) {
    startButton.disabled = false;
    resetButton.disabled = false;
    stopButton.disabled = true;
  }
  
  void reset(Event e, var detail, Node target) {
    resetButton.disabled = true;
  }


}
