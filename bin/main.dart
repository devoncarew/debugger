// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

//import 'package:debugger/debugger.dart' as debugger;

main() async {
  print(Platform.version);

  String contents = await getContents('bin/main.dart');
  print(contents);
}

Future<String> getContents(String path) {
  File file = new File(path);
  return file.readAsString();
}
