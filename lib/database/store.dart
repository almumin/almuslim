import 'package:almuslim/objectbox.g.dart'; // created by `flutter pub run build_runner build`

class ObjectBox {
  final Store store;

  ObjectBox._create(this.store) {
    // Add any additional setup code, e.g. build queries.
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    final store = await openStore();
    return ObjectBox._create(store);
  }
}