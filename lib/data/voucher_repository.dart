import 'package:recipto_assignment/models/voucher_model.dart';

class VoucherRepository {
  Future<Voucher> fetchVoucher() async {
    await Future.delayed(const Duration(milliseconds: 250));

    const Map<String, dynamic> mockJson = {
      "id": "zepto-100",
      "title": "Zepto Instant Voucher",
      "minAmount": 50,
      "maxAmount": 10000,
      "disablePurchase": false,
      "discounts": [
        {"method": "UPI", "percent": 4},
        {"method": "CARD", "percent": 4},
      ],
      "redeemSteps": [
        "Login to Zepto Platform",
        "Click on My profile / Settings",
        "Go to Zepto Cash & Gift Card",
        "Click on Add Card option",
      ],
    };

    return Voucher.fromJson(mockJson);
  }
}
