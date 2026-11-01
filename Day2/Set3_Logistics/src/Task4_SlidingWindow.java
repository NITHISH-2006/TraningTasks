import java.util.Arrays;
import java.util.Locale;

public class Task4_SlidingWindow {

    public static void main(String[] args) {
        int[] hourlyParcels = {
                120, 95, 80, 70, 65, 90, 180, 310,
                420, 380, 350, 330, 360, 390, 410, 450,
                480, 520, 560, 500, 420, 300, 210, 160
        };
        int windowSize = 4;

        int currentSum = 0;
        for (int i = 0; i < windowSize; i++) {
            currentSum += hourlyParcels[i];
        }

        int bestSum = currentSum;
        int bestStart = 0;
        for (int start = 1; start + windowSize <= hourlyParcels.length; start++) {
            currentSum += hourlyParcels[start + windowSize - 1] - hourlyParcels[start - 1];
            if (currentSum > bestSum) {
                bestSum = currentSum;
                bestStart = start;
            }
        }

        System.out.println("--- Task 4: Highest-Average 4-Hour Parcel Window ---");
        System.out.println("Hourly parcel counts: " + Arrays.toString(hourlyParcels));
        System.out.println(String.format(Locale.US,
                "Best %d-hour window: %02d:00 - %02d:00",
                windowSize, bestStart, bestStart + windowSize));
        System.out.println(String.format(Locale.US,
                "Window total parcels: %,d | Average per hour: %.2f",
                bestSum, bestSum / (double) windowSize));
        System.out.println("Time complexity: O(n) sliding window; space O(1).");
    }
}
