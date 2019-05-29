import 'dart:async';

class SubxList {
  final List<StreamSubscription> _subscriptionList = [];

  ///
  /// Return the number of StreamSubscriptions
  ///
  int get length => _subscriptionList.length;

  ///
  /// Add a StreamSubscription to the list
  ///
  /// For example:
  ///
  ///     subxList.add(observable.listen(...));
  void add(StreamSubscription<dynamic> value) => _subscriptionList.add(value);

  ///
  /// Return a StreamSubscription from the list with a specified index
  ///
  /// For example:
  ///
  ///     subxList[0];
  StreamSubscription operator [](int index) => _subscriptionList[index];

  ///
  /// Unsubscribe to a StreamSubscription with a specified index and remove it from list
  ///
  /// For example:
  ///
  ///     subxList.cancelAt(0);
  Future<bool> cancelAt(int index) async {
    if (index <= length - 1) {
      StreamSubscription subscription = _subscriptionList.removeAt(index);
      await subscription.cancel();

      return true;
    }

    return false;
  }

  ///
  /// Unsubscribe to all StreamSubscriptions and remove them from the list
  ///
  /// For example:
  ///
  ///     subxList.cancelAll();
  void cancelAll() {
    while (length > 0) {
      cancelAt(0);
    }
  }
}