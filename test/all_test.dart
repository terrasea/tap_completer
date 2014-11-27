// Copyright (c) 2014, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library tap_completer.test;

import 'package:unittest/unittest.dart';
import 'package:unittest/unittest.dart' as unit;
import 'package:tap_completer/tap_completer.dart';


main() {
  group('Tap Completer', () {
    test('called tap completes', () {
      TapCompleter tapCompleter = new TapCompleter();
      expect(tapCompleter.tap((completer) => completer.complete()), completes);
      tapCompleter.future.timeout(new Duration(milliseconds: 500));
    });

    test('can be tapped twice', () {
      TapCompleter tapCompleter = new TapCompleter()
        ..tap((complete) => complete.complete())
        ..tap((complete) => complete.complete())
        ;
      tapCompleter.future.timeout(new Duration(milliseconds: 500));
      expect(tapCompleter.future, completes);
    });

    test('can complete', () {
      TapCompleter tapCompleter = new TapCompleter()
        ..tap((complete) {})
        ..tap((complete) {})
        ;
      tapCompleter.future.timeout(new Duration(milliseconds: 500));
      tapCompleter.complete();

      expect(tapCompleter.future, completes);
    });

    test('can completeError', () {
      TapCompleter tapCompleter = new TapCompleter()
        ..tap((complete) {})
        ..tap((complete) {})
        ;
      tapCompleter.future
                    .then((_) => fail("Didn't complete with error"))
                    .catchError(expectAsync((error) => expect(error, "Error")), test: (_) => true)
                    .timeout(new Duration(milliseconds: 500));

      tapCompleter.completeError("Error");
    });


    test('isCompleted is true when completed', () {
      TapCompleter tapCompleter = new TapCompleter()
          ..tap((complete) => complete.complete())
          ..tap((complete) => complete.complete())
          ;
        tapCompleter.future.timeout(new Duration(milliseconds: 500));
        expect(tapCompleter.isCompleted, isTrue);
    });


    test('isCompleted is false when not completed', () {
      TapCompleter tapCompleter = new TapCompleter()
          ..tap((complete) {})
          ..tap((complete) {})
          ;
        tapCompleter.future.timeout(new Duration(milliseconds: 500));
        expect(tapCompleter.isCompleted, isFalse);

    });
  });
}
