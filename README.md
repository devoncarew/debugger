# debugger

## Some background:

The async await behavior is implemented by rewriting the user's source code. It
takes code that looks like it's all synchronous and linear, and rewrites it to
be a series of chained Futures. 

```dart
void main() async {
  String contents = await getContents('bin/main.dart');
  print(contents);
}

Future<String> getContents(String path) {
  File file = new File(path);
  return file.readAsString();
}
```

So, setting a breakpoint on line 2 above will break on the `String contents`
line. In synchronous code, you'd expect hitting 'step over' to stop on the next
line, `print`. With the call to `await` however, what the VM's doing is
converting await to something like `return new Completer(stuff).future;`. So a
step over will actually just leave the method. It'll break next in some Futures
code, and stepping more will leave you wandering around the microtask queue.

Stepping in instead will step into the constructor to the `new Completer()`, not
to the call to getContents, as the user might expect. We're trying to abstract
all this async stuff away, but the abstraction layer disappears as soon as you
try and debug the code.

Breakpoints work fine, but stepping breaks down as soon as you hit a line with
`await` in it.

