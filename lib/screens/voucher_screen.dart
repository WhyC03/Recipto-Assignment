import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipto_assignment/controllers/voucher_controller.dart';

import 'package:recipto_assignment/widgets/pay_button.dart';

class VoucherScreen extends StatefulWidget {
  const VoucherScreen({super.key});

  @override
  State<VoucherScreen> createState() => _VoucherScreenState();
}

class _VoucherScreenState extends State<VoucherScreen> {
  final VoucherController controller = Get.find<VoucherController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          final v = controller.voucher.value;
          if (v == null) {
            return Center(
              child: Text(controller.errorMessage.value ?? 'No voucher found'),
            );
          }
          int discountForMethod(String method) {
            for (final discount in v.discounts) {
              if (discount.method.toUpperCase() == method.toUpperCase()) {
                return discount.percent;
              }
            }
            return 0;
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                //Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Refer & Earn
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.share, size: 15),
                            SizedBox(width: 5),
                            Text(
                              "Refer & Earn",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 5),
                            Text(
                              "₹500",
                              style: TextStyle(
                                color: Colors.deepPurple.shade300,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    //Close Button
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.5),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Icon(Icons.close, size: 22),
                    ),
                  ],
                ),

                SizedBox(height: 10),

                //Voucher Logo
                Container(
                  width: double.maxFinite,
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(child: Icon(Icons.image, size: 60)),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    controller.voucher.value?.title ?? 'W',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10),

                //Desired Amount
                Container(
                  padding: EdgeInsets.all(10),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Enter Your desired /bill amount",
                        style: TextStyle(
                          color: Colors.deepPurple.shade300,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextField(
                              onChanged: (value) {
                                controller.setAmountFromText(value);
                              },
                              controller: controller.amountController,
                              decoration: InputDecoration(
                                prefixText: "₹ ",
                                hintText: 'Enter Amount',
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                prefixStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "Max:₹ ${controller.voucher.value?.maxAmount ?? 0}",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),

                //You Pay
                Container(
                  padding: EdgeInsets.all(10),
                  width: double.maxFinite,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    border: Border.all(width: 0.5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "You Pay",
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          ),
                          Text(
                            "₹${controller.youPay.toStringAsFixed(2)}",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Container(width: 1, height: 50, color: Colors.black),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Savings",
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          ),
                          Text(
                            "₹${controller.savings.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                //Payment options and Quantity
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => controller.selectMethod("UPI"),
                        child: _paymentMethodCard(
                          title: "UPI",
                          discountText: "${discountForMethod("UPI")}% OFF",
                          isSelected: controller.selectedMethod.value == "UPI",
                          icon: Icons.account_balance_wallet,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: InkWell(
                        onTap: () => controller.selectMethod("CARD"),
                        child: _paymentMethodCard(
                          title: "Card",
                          discountText: "${discountForMethod("CARD")}% OFF",
                          isSelected: controller.selectedMethod.value == "CARD",
                          icon: Icons.credit_card,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(child: _quantityCard()),
                  ],
                ),
                SizedBox(height: 15),

                Text("HOW TO REDEEM"),

                SizedBox(height: 15),
                ...List.generate(
                  v.redeemSteps.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      '${index + 1}. ${v.redeemSteps[index]}',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          );
        }),
      ),
      bottomNavigationBar: Obx(
        () => Padding(
          padding: EdgeInsets.fromLTRB(15, 8, 15, 16),
          child: PayButton(
            amount: controller.youPay.toStringAsFixed(2),
            enabled: controller.isPayEnabled,
            onTap: controller.isPayEnabled ? () {} : null,
          ),
        ),
      ),
    );
  }

  Widget _paymentMethodCard({
    required String title,
    required String discountText,
    required bool isSelected,
    required IconData icon,
  }) {
    return Container(
      height: 86,
      decoration: BoxDecoration(
        color: isSelected ? Colors.deepPurple.shade50 : Colors.white,
        border: Border.all(
          color: isSelected ? Colors.deepPurple : Colors.grey.shade300,
          width: isSelected ? 1.5 : 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 14, color: Colors.grey.shade700),
              SizedBox(width: 4),
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            discountText,
            style: TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _quantityCard() {
    return Container(
      height: 86,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "QUANTITY",
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: controller.decrementQuantity,
                child: Icon(Icons.remove, color: Colors.deepPurple, size: 18),
              ),
              Text(
                controller.quantity.value.toString(),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: controller.incrementQuantity,
                child: Icon(Icons.add, color: Colors.deepPurple, size: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
