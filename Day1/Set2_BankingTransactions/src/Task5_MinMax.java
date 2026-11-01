import java.util.Locale;
import java.util.Random;

public class Task5_MinMax {

    static class Result {
        final double min;
        final double max;
        final long comparisons;

        Result(double min, double max, long comparisons) {
            this.min = min;
            this.max = max;
            this.comparisons = comparisons;
        }
    }

    public static void main(String[] args) {
        int recordCount = 100_000;
        double[] amounts = generateAmounts(recordCount);

        long divideStart = System.nanoTime();
        Result divide = tournamentMinMax(amounts);
        long divideNs = System.nanoTime() - divideStart;

        long bruteStart = System.nanoTime();
        Result brute = bruteForce(amounts);
        long bruteNs = System.nanoTime() - bruteStart;

        System.out.println("--- Task 5: Min/Max Divide & Conquer vs Brute Force ---");
        System.out.println(String.format(Locale.US,
                "Divide & Conquer (Tournament) -> Min: $%.2f, Max: $%.2f | Total Comparisons: %,d | Time: %.2f ms",
                divide.min, divide.max, divide.comparisons, divideNs / 1_000_000.0));
        System.out.println(String.format(Locale.US,
                "Brute Force      -> Min: $%.2f, Max: $%.2f | Total Comparisons: %,d | Time: %.2f ms",
                brute.min, brute.max, brute.comparisons, bruteNs / 1_000_000.0));
        System.out.println("Same result: " + (divide.min == brute.min && divide.max == brute.max));
        System.out.println(String.format(Locale.US,
                "Tournament comparison formula 3n/2 - 2 = %,d", (3L * recordCount) / 2 - 2));
    }

    static Result tournamentMinMax(double[] values) {
        int pairs = values.length / 2;
        double[] mins = new double[pairs];
        double[] maxs = new double[pairs];
        long comparisons = 0;

        for (int i = 0; i < pairs; i++) {
            comparisons++;
            if (values[2 * i] <= values[2 * i + 1]) {
                mins[i] = values[2 * i];
                maxs[i] = values[2 * i + 1];
            } else {
                mins[i] = values[2 * i + 1];
                maxs[i] = values[2 * i];
            }
        }

        int size = pairs;
        while (size > 1) {
            int next = 0;
            for (int i = 0; i + 1 < size; i += 2) {
                comparisons += 2;
                mins[next] = Math.min(mins[i], mins[i + 1]);
                maxs[next] = Math.max(maxs[i], maxs[i + 1]);
                next++;
            }
            if (size % 2 == 1) {
                mins[next] = mins[size - 1];
                maxs[next] = maxs[size - 1];
                next++;
            }
            size = next;
        }

        double min = mins[0];
        double max = maxs[0];
        if (values.length % 2 == 1) {
            comparisons += 2;
            min = Math.min(min, values[values.length - 1]);
            max = Math.max(max, values[values.length - 1]);
        }
        return new Result(min, max, comparisons);
    }

    static Result bruteForce(double[] values) {
        double min = values[0];
        double max = values[0];
        long comparisons = 0;
        for (int i = 1; i < values.length; i++) {
            comparisons++;
            if (values[i] < min) {
                min = values[i];
            }
            comparisons++;
            if (values[i] > max) {
                max = values[i];
            }
        }
        return new Result(min, max, comparisons);
    }

    static double[] generateAmounts(int count) {
        Random random = new Random(99);
        double[] amounts = new double[count];
        for (int i = 0; i < count; i++) {
            amounts[i] = Math.round(random.nextDouble() * 10_000 * 100.0) / 100.0;
        }
        return amounts;
    }
}
