import java.util.Locale;
import java.util.Random;

public class Task4_SlidingWindow {

    public static void main(String[] args) {
        int[] requestsPerMinute = generateTraffic(24);
        int windowSize = 3;

        int currentSum = 0;
        for (int i = 0; i < windowSize; i++) {
            currentSum += requestsPerMinute[i];
        }

        int bestSum = currentSum;
        int bestStart = 0;
        for (int start = 1; start + windowSize <= requestsPerMinute.length; start++) {
            currentSum += requestsPerMinute[start + windowSize - 1] - requestsPerMinute[start - 1];
            if (currentSum > bestSum) {
                bestSum = currentSum;
                bestStart = start;
            }
        }

        System.out.println("--- Task 4: Busiest 3-Hour Traffic Window ---");
        System.out.println("Hourly requests-per-minute profile: " + java.util.Arrays.toString(requestsPerMinute));
        System.out.println(String.format(Locale.US,
                "Busiest continuous %d-hour window: %02d:00 - %02d:00",
                windowSize, bestStart, bestStart + windowSize));
        System.out.println(String.format(Locale.US,
                "Window total requests: %,d | Average per hour: %.2f",
                bestSum, bestSum / (double) windowSize));
        System.out.println("Time complexity: O(n) with a sliding window; space O(1).");
    }

    static int[] generateTraffic(int hours) {
        Random random = new Random(808);
        int[] traffic = new int[hours];
        for (int hour = 0; hour < hours; hour++) {
            int baseline = 400 + random.nextInt(300);
            if (hour >= 18 && hour <= 21) {
                baseline += 1_200;
            }
            traffic[hour] = baseline;
        }
        return traffic;
    }
}
