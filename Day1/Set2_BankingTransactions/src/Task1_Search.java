import java.util.Locale;
import java.util.Random;

public class Task1_Search {

    public static void main(String[] args) {
        int recordCount = 100_000;
        int[] transactionIds = new int[recordCount];
        for (int i = 0; i < recordCount; i++) {
            transactionIds[i] = 100_000 + i;
        }

        int best = Integer.MAX_VALUE;
        int worst = 0;
        long total = 0;
        for (int target : transactionIds) {
            int comparisons = binarySearchComparisons(transactionIds, target);
            best = Math.min(best, comparisons);
            worst = Math.max(worst, comparisons);
            total += comparisons;
        }
        double average = (double) total / recordCount;

        Random random = new Random(11);
        int sampleSize = 500;
        int[] sampleTargets = new int[sampleSize];
        sampleTargets[0] = transactionIds[0];
        sampleTargets[1] = transactionIds[recordCount - 1];
        for (int i = 2; i < sampleSize; i++) {
            sampleTargets[i] = transactionIds[random.nextInt(recordCount)];
        }

        int linearBest = Integer.MAX_VALUE;
        int linearWorst = 0;
        long linearTotal = 0;
        for (int target : sampleTargets) {
            int comparisons = linearSearchComparisons(transactionIds, target);
            linearBest = Math.min(linearBest, comparisons);
            linearWorst = Math.max(linearWorst, comparisons);
            linearTotal += comparisons;
        }
        double linearAverage = (double) linearTotal / sampleSize;

        System.out.println("--- Task 1: Search Comparisons (n = " + String.format(Locale.US, "%,d", recordCount) + ") ---");
        System.out.println(String.format(Locale.US,
                "Binary Search -> Best: %d, Avg: %.2f, Worst: %d comparisons",
                best, average, worst));
        System.out.println(String.format(Locale.US,
                "Linear Search -> Best: %d, Avg: %.2f, Worst: %d comparisons (sample of %d targets)",
                linearBest, linearAverage, linearWorst, sampleSize));
        System.out.println(String.format(Locale.US,
                "Theoretical linear average (n+1)/2 = %.0f; binary worst-case cap = %d",
                (recordCount + 1) / 2.0,
                (int) Math.ceil(Math.log(recordCount) / Math.log(2))));
    }

    static int linearSearchComparisons(int[] values, int target) {
        int comparisons = 0;
        for (int value : values) {
            comparisons++;
            if (value == target) {
                return comparisons;
            }
        }
        return comparisons;
    }

    static int binarySearchComparisons(int[] values, int target) {
        int comparisons = 0;
        int left = 0;
        int right = values.length - 1;
        while (left <= right) {
            comparisons++;
            int mid = left + (right - left) / 2;
            if (values[mid] == target) {
                return comparisons;
            }
            if (values[mid] < target) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return comparisons;
    }
}
