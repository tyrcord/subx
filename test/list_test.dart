import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:test/test.dart';

import 'package:subx/subx.dart';

void main() {
  group('SubxList', () {
    SubxList subxList;
    BehaviorSubject source;
    StreamSubscription subscription;
    StreamSubscription subscription2;

    setUp(() {
      subxList = SubxList();
      source = BehaviorSubject();
      subscription = source.listen((data) {});
      subscription2 = source.listen((data) {});
    });

    tearDown(() {
      subxList.cancelAll();
      source.close();
    });

    group('#length', () {
      test('should return the number of tracked subscriptions', () {
        expect(subxList.length, equals(0));
        subxList.add(subscription);
        expect(subxList.length, equals(1));
      });
    });

    group('#add()', () {
      test('should add a subscription to the list', () {
        expect(subxList.length, equals(0));
        subxList.add(subscription);
        expect(subxList.length, equals(1));
      });
    });

    group('#operator [](int index)', () {
      test('should return a subscription from the list with an index', () {
        subxList.add(subscription);
        expect(subxList[0], equals(subscription));
      });
    });

    group('#cancelAt()', () {
      test('should cancel a subscription with an index', () async {
        subxList.add(subscription);
        subxList.add(subscription2);
        expect(subxList.length, equals(2));

        final unsubscribed = await subxList.cancelAt(0);

        expect(subxList.length, equals(1));
        expect(unsubscribed, equals(true));
      });

      test('should handle wrong indexes', () async {
        subxList.add(subscription);
        expect(subxList.length, equals(1));

        final unsubscribed = await subxList.cancelAt(1);

        expect(subxList.length, equals(1));
        expect(unsubscribed, equals(false));
      });
    });

    group('#cancelAll()', () {
      test('should cancel all subscriptions', () {
        subxList.add(subscription);
        subxList.add(subscription2);
        expect(subxList.length, equals(2));

        subxList.cancelAll();

        expect(subxList.length, equals(0));
      });
    });

    group('#pauseAll()', () {
      test('should pause all subscriptions', () {
        subxList.add(subscription);
        subxList.add(subscription2);
        expect(subxList.length, equals(2));

        subxList.pauseAll();

        expect(subxList[0].isPaused, true);
        expect(subxList[1].isPaused, true);
      });
    });

    group('#resumeAll()', () {
      test('should resume all subscriptions', () {
        subxList.add(subscription);
        subxList.add(subscription2);
        expect(subxList.length, equals(2));

        subxList.pauseAll();

        expect(subxList[0].isPaused, true);
        expect(subxList[1].isPaused, true);

        subxList.resumeAll();

        expect(subxList[0].isPaused, false);
        expect(subxList[1].isPaused, false);
      });
    });
  });
}
