import java.util.Arrays;

public class Task4_SlidingWindow {

    public static void main(String[] args) {
        int[] dailyClaims = {
                85, 120, 135, 150, 90, 160, 175, 190, 210, 80,
                110, 105, 130, 140, 125, 95, 200, 220, 240, 260,
                280, 300, 70, 115, 120, 130, 140, 150, 160, 170
        };
        int threshold = 100;

        int left = 0;
        int bestStart = 0;
        int bestLength = 0;

        for (int right = 0; right < dailyClaims.length; right++) {
            if (dailyClaims[right] <= threshold) {
                left = right + 1;
            } else if (right - left + 1 > bestLength) {
                bestLength = right - left + 1;
                bestStart = left;
            }
        }

        System.out.println("--- Task 4: Longest Run of Days with Claims > 100 ---");
        System.out.println("Daily claims: " + Arrays.toString(dailyClaims));
        System.out.println("Longest run: " + bestLength + " consecutive days (Day "
                + (bestStart + 1) + " to Day " + (bestStart + bestLength) + ")");
        if (bestLength > 0) {
            System.out.println("Claims in run: " + Arrays.toString(
                    Arrays.copyOfRange(dailyClaims, bestStart, bestStart + bestLength)));
        }
        System.out.println("Time complexity: O(n) single pass; space O(1).");
    }
}
