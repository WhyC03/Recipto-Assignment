# Voucher Purchase Screen

This project implements a voucher purchase flow in Flutter using GetX for state management.

## State Management Used

The app uses **GetX** with a dedicated `VoucherController` to manage UI state and business logic.
Reactive variables (`Rx`) are used for voucher data, amount, quantity, selected payment method, loading, and error states.  
The UI listens to controller changes using `Obx`, so widgets update automatically when state changes.

## State Flow (Repository -> State -> UI)

1. **Repository Layer** (`VoucherRepository`) provides voucher data by parsing the mock JSON into the `Voucher` model.
2. **State Layer** (`VoucherController`) loads repository data, stores reactive state, and computes business values like `discountAmount`, `youPay`, and `savings`.
3. **UI Layer** (`VoucherScreen`) reads controller state via `Obx` and renders the screen reactively (amount summary, method selection, quantity, redeem steps, and pay button).

This keeps business logic out of widgets and maintains a clean data flow.

## Pay Button Enable/Disable Handling

The pay button state is controlled by `controller.isPayEnabled`.
It is enabled only when all conditions are valid:

- voucher is loaded
- not currently loading
- `disablePurchase` is `false`
- entered amount is within `minAmount` and `maxAmount`
- quantity is greater than `0`

If any condition fails, the button is disabled (no tap action and disabled color state).
