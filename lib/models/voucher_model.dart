class Voucher {
  final String id;
  final String title;
  final int minAmount;
  final int maxAmount;
  final bool disablePurchase;
  final List<Discount> discounts;
  final List<String> redeemSteps;

  const Voucher({
    required this.id,
    required this.title,
    required this.minAmount,
    required this.maxAmount,
    required this.disablePurchase,
    required this.discounts,
    required this.redeemSteps,
  });

  factory Voucher.fromJson(Map<String, dynamic> json) {
    return Voucher(
      id: json['id'] as String,
      title: json['title'] as String,
      minAmount: json['minAmount'] as int,
      maxAmount: json['maxAmount'] as int,
      disablePurchase: json['disablePurchase'] as bool,
      discounts: (json['discounts'] as List<dynamic>)
          .map((e) => Discount.fromJson(e as Map<String, dynamic>))
          .toList(),
      redeemSteps: (json['redeemSteps'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'minAmount': minAmount,
      'maxAmount': maxAmount,
      'disablePurchase': disablePurchase,
      'discounts': discounts.map((e) => e.toJson()).toList(),
      'redeemSteps': redeemSteps,
    };
  }
}

class Discount {
  final String method;
  final int percent;

  const Discount({
    required this.method,
    required this.percent,
  });

  factory Discount.fromJson(Map<String, dynamic> json) {
    return Discount(
      method: json['method'] as String,
      percent: json['percent'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'method': method,
      'percent': percent,
    };
  }
}
