import 'package:get/get.dart';

class FilterController extends GetxController {
  final RxBool _onlyMyRegisters = false.obs;
  final RxBool _filterByDateRange = false.obs;
  final Rx<DateTime> _initialDate = DateTime(2024).obs;
  final Rx<DateTime> _finalDate = DateTime.now().obs;

  bool get onlyMyRegisters => _onlyMyRegisters.value;
  bool get filterByDateRange => _filterByDateRange.value;
  DateTime get initialDate => _initialDate.value;
  DateTime get finalDate => _finalDate.value;

  void setOnlyMyRegisters(bool value) {
    _onlyMyRegisters.value = value;
    update();
  }

  void setFilterByDateRange(bool value) {
    _filterByDateRange.value = value;
    update();
  }

  void setInitialDate(DateTime value) {
    _initialDate.value = value;
    update();
  }

  void setFinalDate(DateTime value) {
    _finalDate.value = value;
    update();
  }

  void resetDateRange() {
    _initialDate.value = DateTime(2024);
    _finalDate.value = DateTime.now();
    update();
  }

  void resetFilters() {
    _onlyMyRegisters.value = false;
    _filterByDateRange.value = false;
    _initialDate.value = DateTime(2024);
    _finalDate.value = DateTime.now();
    update();
  }
}
