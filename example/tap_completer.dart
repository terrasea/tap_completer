// Copyright (c) 2014, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library tap_completer.example;

import 'dart:async';

import 'package:tap_completer/tap_completer.dart';

const TimeToWait500 = const Duration(milliseconds: 500);
const TimeToWait2000 = const Duration(milliseconds: 2000);

main() {
  new TapCompleter()
    ..tap((completer) => new Timer(TimeToWait500, () {
      print("1");
      completer.complete();
    }))
    ..tap((completer) => new Timer(TimeToWait2000, () {
      print("2");
      completer.complete();
    }))
    ..future.then((_) => print('All finished'))
    ;
}
