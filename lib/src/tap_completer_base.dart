// Copyright (c) 2014, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

// TODO: Put public facing types in this file.

library tap_completer.base;

import 'dart:async' show Future, Completer;

///TapCompleter is an implementation of a completer, which can be tapped into
///and have other completers added to it.  This particularly allows for easier
///testing of code which has to wait for one or more asynchronous conditions to
///complete before they can be tested.  The TapCompleter can be used as a mixin
///or standalone.
///
/// new TapCompleter()
///    ..tap((completer) => new Timer(TimeToWait500, () {
///      print("1");
///      completer.complete();
///    }))
///    ..tap((completer) => new Timer(TimeToWait2000, () {
///      print("2");
///      completer.complete();
///    }))
///    ..future.then((_) => print('All finished'))
///    ;
class TapCompleter implements Completer {
  final List<Completer> _completers = [];

  ///Taps into the TapCompleter, adding a completer used in the callback it's supplied
  Future tap(callback(Completer complete)) {
    var completer = new Completer();
    callback(completer);

    _completers.add(completer);

    return completer.future;
  }

  ///thu future which only completes when all added taps (completers) are finished
  Future get future => Future.wait(_completers.map((completer) => completer.future));


  ///forces all the completers to complete with an error
  @override
  void completeError(Object error, [StackTrace stackTrace]) {
    _completers.forEach((completer) => !completer.isCompleted ? completer.completeError(error, stackTrace) : false);
  }

  ///have all the completers that have tapped into this completer finished
  @override
  bool get isCompleted => _completers.every((completer) => completer.isCompleted);

  ///force the completion of all added taps (completers), with an optional values if it ois desired all the completers need one
  @override
  void complete([value]) {
    _completers.forEach((completer) => completer.complete(value));
  }
}
