# tap_completer

A Completer which allows you to tap into it, adding a callback which is called
with a Completer, which completes in a specific condition within the callback.
It can handle multiple taps, so it can handle multiple asynchronous Futures at
once, with only one Completer.  It allows the consolidation of synchronous
Futures into one.  This could be done other ways, but I think this makes it
easier on the developer, especially when dealing with multiple futures, where
everyone has to finish before something can happen.  

## Usage

A simple usage example:

    import 'package:tap_completer/tap_completer.dart';

    main() {
      TapCompleter tapCompleter = new TapCompleter()
        ..tap((complete) => complete.complete())
        ..tap((complete) => complete.complete())
        ;
      tapCompleter.future.then((_) {
        print('finished');
      });
    }

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/terrasea/tap_completer/issues
