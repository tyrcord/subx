import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:subx/subx.dart';
import "package:test/test.dart";

void main() {
  group("SubxMap", () {
    SubxMap subxMap;
    BehaviorSubject source;
    StreamSubscription subscription;
    StreamSubscription subscription2;

    setUp(() {
      subxMap = SubxMap();
      source = BehaviorSubject();
      subscription = source.listen((data) {});
      subscription2 = source.listen((data) {});
    });

    tearDown(() {
      subxMap.cancelAll();
      source.close();
    });

    group("#length", () {
      test("should return the number of tracked subscriptions", () {
        expect(subxMap.length, equals(0));
        subxMap.add('key', subscription);
        expect(subxMap.length, equals(1));
      });
    });

    group("#add()", () {
      test("should add a subscription to the list", () {
        expect(subxMap.length, equals(0));
        subxMap.add('key', subscription);
        expect(subxMap.length, equals(1));
      });

      test(
          "should replace a subscription from the list and cancel it when the key already exist",
          () {
        subxMap.add('key', subscription);
        expect(subxMap.length, equals(1));

        subxMap.add('key', subscription2);
        expect(subxMap.length, equals(1));
      });

      test(
          "should not cancel a subscription when the same subscription is added with the same key",
          () {
        subxMap.add('key', subscription);
        expect(subxMap.length, equals(1));

        subxMap.add('key', subscription);
        expect(subxMap.length, equals(1));
      });

      test("should allow chaining calls", () {
        expect(subxMap.length, equals(0));
        subxMap.add('key', subscription)..add('key2', subscription2);
        expect(subxMap.length, equals(2));
      });
    });

    group("#operator [](int index)", () {
      test("should return a subscription from the list with an index", () {
        subxMap.add('key', subscription);
        expect(subxMap['key'], equals(subscription));
      });
    });

    group("#containsSubscription()", () {
      test("should return true if this list contains the given subscription",
          () {
        subxMap.add('key', subscription);
        expect(subxMap.containsSubscription(subscription), equals(true));
      });

      test(
          "should return false if this list does not contain the given subscription",
          () {
        expect(subxMap.containsSubscription(subscription), equals(false));
      });
    });

    group("#cancelAt()", () {
      test("should cancel a subscription with an index", () async {
        subxMap.add('key', subscription);
        subxMap.add('key2', subscription2);
        expect(subxMap.length, equals(2));

        bool unsubscribed = await subxMap.cancelForKey("key");

        expect(subxMap.length, equals(1));
        expect(unsubscribed, equals(true));
      });

      test("should handle wrong keys", () async {
        subxMap.add('key', subscription);
        expect(subxMap.length, equals(1));

        bool unsubscribed = await subxMap.cancelForKey("key2");

        expect(subxMap.length, equals(1));
        expect(unsubscribed, equals(false));
      });
    });

    group("#cancelAll()", () {
      test("should cancel all subscriptions", () {
        subxMap.add('key', subscription);
        subxMap.add('key2', subscription2);
        expect(subxMap.length, equals(2));

        subxMap.cancelAll();

        expect(subxMap.length, equals(0));
      });
    });
  });
}