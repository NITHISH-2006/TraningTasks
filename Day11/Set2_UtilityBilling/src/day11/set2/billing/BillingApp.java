package day11.set2.billing;

import java.util.Locale;
import java.util.Scanner;

public class BillingApp {

    public static void main(String[] args) {
        System.out.println("DAY 11 SET 2 - UTILITY BILLING CALCULATOR");

        printBoundaryTests();
        printAnnualStatement();
        readMeterReadings();
        CastingDemo.print();
    }

    private static void printBoundaryTests() {
        var boundaries = new int[]{100, 101, 200, 201, 400, 401};
        System.out.println();
        System.out.println("BOUNDARY TESTS - DOMESTIC, no surcharge/rebate");
        System.out.printf(Locale.US, "%8s %14s %12s %12s%n", "UNITS", "ENERGY", "FIXED", "TOTAL");
        for (var units : boundaries) {
            var bill = BillCalculator.calculate(ConsumerCategory.DOMESTIC, units, false, false);
            System.out.printf(Locale.US, "%8d %14.2f %12.2f %12.2f%n",
                    bill.units(), bill.energyCharges(), bill.fixedCharge(), bill.totalPayable());
        }
    }

    private static void printAnnualStatement() {
        var monthlyUnits = new int[]{120, 135, 110, 98, 150, 180, 210, 205, 160, 140, 125, 175};
        System.out.println();
        System.out.println("12-MONTH STATEMENT - COMMERCIAL, online payment");
        System.out.printf(Locale.US, "%6s %8s %12s %10s %10s %12s%n",
                "MONTH", "UNITS", "ENERGY", "SURCHARGE", "REBATE", "PAYABLE");
        for (var i = 0; i < monthlyUnits.length; i++) {
            var bill = BillCalculator.calculate(ConsumerCategory.COMMERCIAL, monthlyUnits[i], false, true);
            System.out.printf(Locale.US, "%6d %8d %12.2f %10.2f %10.2f %12.2f%n",
                    i + 1, bill.units(), bill.energyCharges(), bill.surcharge(), bill.rebate(), bill.totalPayable());
        }
    }

    private static void readMeterReadings() {
        System.out.println();
        System.out.println("METER READINGS - enter previous then current reading; previous 0 stops");
        try (var scanner = new Scanner(System.in)) {
            var previousReading = 0;
            do {
                System.out.print("Previous reading (0 to stop): ");
                if (!scanner.hasNextInt()) {
                    break;
                }
                previousReading = scanner.nextInt();
                if (previousReading == 0) {
                    break;
                }
                System.out.print("Current reading: ");
                var currentReading = scanner.nextInt();
                var units = currentReading - previousReading;

                var bill = BillCalculator.calculate(ConsumerCategory.DOMESTIC, units, true, true);
                System.out.printf(Locale.US,
                        "  Units=%d Energy=%.2f Fixed=%.2f Surcharge=%.2f Rebate=%.2f Payable=%.2f%n",
                        bill.units(), bill.energyCharges(), bill.fixedCharge(),
                        bill.surcharge(), bill.rebate(), bill.totalPayable());
            } while (previousReading != 0);
        }
    }
}
