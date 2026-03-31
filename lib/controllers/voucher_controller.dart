import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipto_assignment/data/voucher_repository.dart';
import 'package:recipto_assignment/models/voucher_model.dart';

class VoucherController extends GetxController {
  VoucherController({required this.repository});

  final VoucherRepository repository;

  final isLoading = false.obs;
  final errorMessage = RxnString();
  final voucher = Rxn<Voucher>();

  final amount = 100.obs;
  final quantity = 1.obs;
  final selectedMethod = 'UPI'.obs;
  final amountController = TextEditingController(text: '100');

  @override
  void onInit() {
    super.onInit();
    loadVoucher();
  }

  @override
  void onClose() {
    amountController.dispose();
    super.onClose();
  }

  Future<void> loadVoucher() async {
    isLoading.value = true;
    errorMessage.value = null;

    try {
      final data = await repository.fetchVoucher();
      voucher.value = data;

      amount.value = data.minAmount;
      quantity.value = 1;
      selectedMethod.value = data.discounts.first.method;
      amountController.text = data.minAmount.toString();
    } catch (_) {
      errorMessage.value = 'Failed to load voucher.';
    } finally {
      isLoading.value = false;
    }
  }

  void setAmountFromText(String value) {
    final parsed = int.tryParse(value.replaceAll(RegExp(r'[^0-9]'), ''));
    amount.value = parsed ?? 0;
  }

  void selectMethod(String method) {
    selectedMethod.value = method;
  }

  void incrementQuantity() {
    quantity.value = quantity.value + 1;
  }

  void decrementQuantity() {
    if (quantity.value > 1) {
      quantity.value = quantity.value - 1;
    }
  }

  Discount? get selectedDiscount {
    final v = voucher.value;
    if (v == null) return null;

    for (final discount in v.discounts) {
      if (discount.method.toUpperCase() == selectedMethod.value.toUpperCase()) {
        return discount;
      }
    }
    return null;
  }

  double get discountPercent => (selectedDiscount?.percent ?? 0).toDouble();

  double get discountAmount => amount.value * discountPercent / 100;

  double get youPay => (amount.value - discountAmount) * quantity.value;

  double get savings => discountAmount * quantity.value;

  bool get isAmountValid {
    final v = voucher.value;
    if (v == null) return false;
    return amount.value >= v.minAmount && amount.value <= v.maxAmount;
  }

  bool get isPayEnabled {
    final v = voucher.value;
    if (v == null) return false;
    if (isLoading.value) return false;
    if (v.disablePurchase) return false;
    if (!isAmountValid) return false;
    if (quantity.value <= 0) return false;
    return true;
  }
}
