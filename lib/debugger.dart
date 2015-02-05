// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

/// The debugger library.
library debugger;

/**
 * ## How would step-in to Futures / await be implemented?
 *
 * The VM recognizes that the step-in command is being executed at an await
 * keyword. It calls `return new _AsyncCompleter.(f, break: true).future;`.
 * `_AsyncCompleter` uses the `break: true` to indicate that when the
 * micro-task is executed, it should use `invokeAndBreak(f)`. The user can
 * then step through the created closure.
 */

/**
 * How would step-over Futures / await be implemented?
 *
 * When stepping over an await, the Completer could be created with a
 * `breakOnReturn` flag. When invoking the `then()` closure, the library could
 * use the `invokeAndBreak()` functionality.
 */

/**
 * What about step-out from something returning a Future?
 *
 * Perhaps implemented the same as the step-over Future case? You want to break
 * where the value is used; when the result is used from the `then()` or
 * `catchError()` clause.
 */

/* Is a top-level name-space better? */

bool get isDebuggerEnabled => true;

void debugBreak() {
  print('yup, I broke');
}

dynamic invokeAndBreak(Function f) {
  // TODO: Move this break into the beginning of `f`.
  debugBreak();
  return f();
}

/* Or a singleton class? */

//final Debugger debugger = new Debugger._();

class Debugger {
  Debugger._();

  static bool get isEnabled => true;

  static void debugBreak() {
    print('yup, I broke');
  }

  static dynamic invokeAndBreak(Function f) {
    // TODO: Move this break into the beginning of `f`.
    debugBreak();
    return f();
  }
}
