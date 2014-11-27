// Copyright (c) 2014, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

// TODO: Put public facing types in this file.

library tap_completer.base;

import 'dart:async' show Future, Completer;

class TapCompleter implements Completer {
  final List<Completer> _completers = [];

  TapCompleter();

  Future tap(callback(Completer complete)) {
    var completer = new Completer();
    callback(completer);

    _completers.add(completer);

    return completer.future;
  }

  Future get future => Future.wait(_completers.map((completer) => completer.future));


  @override
  void completeError(Object error, [StackTrace stackTrace]) {
    _completers.forEach((completer) => !completer.isCompleted ? completer.completeError(error, stackTrace) : false);
  }

  @override
  bool get isCompleted => _completers.every((completer) => completer.isCompleted);

  @override
  void complete([value]) {
    _completers.forEach((completer) => completer.complete(value));
  }
}
