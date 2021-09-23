import 'package:get/state_manager.dart';

class PokeDetailsController extends GetxController {
  final RxInt _index = 0.obs;

  int get index => _index.value;

  set index(int value) => _index.value = value;
}
