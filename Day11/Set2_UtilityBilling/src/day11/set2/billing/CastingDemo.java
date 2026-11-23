package day11.set2.billing;

import java.util.Locale;

public final class CastingDemo {

    private CastingDemo() {}

    public static void print() {
        var numerator = 7;
        var denominator = 2;
        System.out.println("PRIMITIVE CASTING / PRECISION DEMOS");
        System.out.printf(Locale.US, "  int division: %d / %d = %d; correct decimal = %.2f%n",
                numerator, denominator, numerator / denominator, (double) numerator / denominator);

        var maxInt = Integer.MAX_VALUE;
        var overflowed = maxInt + 1;
        var widened = (long) maxInt + 1;
        System.out.printf(Locale.US, "  overflow: Integer.MAX_VALUE + 1 = %d; with long = %d%n", overflowed, widened);

        var exactAmount = 99.99;
        var truncated = (int) exactAmount;
        var rounded = (int) Math.round(exactAmount);
        System.out.printf(Locale.US, "  double to int: (int)%.2f = %d; (int)Math.round(...) = %d%n",
                exactAmount, truncated, rounded);
    }
}
