import 'package:flutter/material.dart';

class PayButton extends StatelessWidget {
  final String amount;
  final bool enabled;
  final VoidCallback? onTap;
  const PayButton({
    super.key,
    required this.amount,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enabled ? onTap : null,
      child: Container(
        width: double.maxFinite,
        height: 50,
        decoration: BoxDecoration(
          color: enabled ? Colors.deepPurple : Colors.grey.shade400,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: Text(
            "Pay ₹ $amount  ✨",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
