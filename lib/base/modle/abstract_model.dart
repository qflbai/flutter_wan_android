import 'i_modle.dart';

abstract class AbstractModel implements IModel {
  String _tag;

  String get tag => _tag;

  AbstractModel() {
    _tag = '${DateTime.now().millisecondsSinceEpoch}';
  }
}
