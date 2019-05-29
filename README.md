# SubX

RxDart Subscriptions management.

Provide Apis to store and manage RxDart subscriptions and provide methods to unsubscribe them all.

## Prerequisites

The project has dependencies that require the Dart SDK 2.0

# SubxList

Object that holds and manages a list of Subscriptions.

### Usage

```dart
import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:subx/subx.dart';
import "package:test/test.dart";

SubxList subxList = SubxList();
BehaviorSubject source = BehaviorSubject();

StreamSubscription subscription = source.listen((data) {...});
StreamSubscription subscription2 = source.listen((data) {...});

subxList.add(subscription);
subxList.add(subscription2);

...

subxList.unsubscribeAll();
```

# SubxMap

Object that holds and manages Key-Subscription pairs.

### Usage

```dart
import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:subx/subx.dart';
import "package:test/test.dart";

SubxList subxList = SubxList();
BehaviorSubject source = BehaviorSubject();

StreamSubscription subscription = source.listen((data) {...});
StreamSubscription subscription2 = source.listen((data) {...});

subxList.set('key1', subscription);
subxList.set('key2', subscription2);

...

subxList.unsubscribeAll();
```

# License
Copyright (c) Tyrcord, Inc. Licensed under the ISC License.

See [LICENSE](LICENSE) file in the project root for details.
