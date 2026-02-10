import 'package:flutter_test/flutter_test.dart';
import 'package:travel_planner/features/trips/domain/value_objects/money.dart';

void main() {
  group('Money Value Object', () {
    test('should correctly convert double amount to cents', () {
      final money = Money.usd(123.456);
      expect(money.cents, 12346); // Rounded
    });

    test('should format amount as string with 2 decimals', () {
      final money = Money.usd(123.4);
      expect(money.amountString, '123.40');
    });

    test('should format with currency symbol', () {
      final money = Money.usd(50.0);
      expect(money.formattedAmount, '\$50.00');
    });

    test('comparison operators should work', () {
      final m1 = Money.usd(10.0);
      final m2 = Money.usd(20.0);
      expect(m1 < m2, isTrue);
      expect(m2 > m1, isTrue);
      expect(m1 <= m1, isTrue);
    });
  });
}
