package day11.set2.billing;

public final class BillCalculator {

    private static final double LATE_SURCHARGE_RATE = 0.10;
    private static final double ONLINE_REBATE_RATE = 0.02;

    private BillCalculator() {}

    public static Bill calculate(
            ConsumerCategory category,
            int units,
            boolean latePayment,
            boolean onlinePayment
    ) {
        var consumed = Math.max(units, 0);
        var energyCharges = slabCharges(consumed);

        var fixedCharge = switch (category) {
            case DOMESTIC -> 50.0;
            case COMMERCIAL -> 150.0;
            case INDUSTRIAL -> 300.0;
        };

        var subtotal = energyCharges + fixedCharge;
        var surcharge = latePayment ? subtotal * LATE_SURCHARGE_RATE : 0.0;
        var rebate = onlinePayment ? (subtotal + surcharge) * ONLINE_REBATE_RATE : 0.0;

        // Operator precedence: * and / bind tighter than +, and + binds tighter than ?:; parentheses state the intended order.
        var totalPayable = (subtotal + surcharge) - rebate;

        return new Bill(category, consumed, energyCharges, fixedCharge, surcharge, rebate, totalPayable);
    }

    private static double slabCharges(int units) {
        var limits = new int[]{100, 100, 200};
        var rates = new double[]{3.0, 5.0, 7.0};
        var remaining = units;
        var charge = 0.0;

        for (var i = 0; i < limits.length && remaining > 0; i++) {
            var slabUnits = Math.min(remaining, limits[i]);
            charge += slabUnits * rates[i];
            remaining -= slabUnits;
        }

        if (remaining > 0) {
            charge += remaining * 9.0;
        }
        return charge;
    }
}
