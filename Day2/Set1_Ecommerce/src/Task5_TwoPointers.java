import java.util.ArrayList;
import java.util.List;

public class Task5_TwoPointers {

    public static void main(String[] args) {
        int[] orderValues = {150, 300, 450, 600, 750, 900, 1050, 1200};
        int giftCardValue = 1200;

        List<String> pairs = findPairs(orderValues, giftCardValue);

        System.out.println("--- Task 5: Two-Pointer Gift-Card Pairs ---");
        System.out.println("Sorted order values: " + java.util.Arrays.toString(orderValues));
        System.out.println("Gift-card value: " + giftCardValue);
        if (pairs.isEmpty()) {
            System.out.println("No pairs found.");
        } else {
            for (String pair : pairs) {
                System.out.println("Pair found: " + pair);
            }
        }
        System.out.println("Pairs found: " + pairs.size());
        System.out.println("Time complexity: O(n) after sorting; space O(1) excluding the output list.");
    }

    static List<String> findPairs(int[] sortedValues, int target) {
        List<String> pairs = new ArrayList<>();
        int left = 0;
        int right = sortedValues.length - 1;

        while (left < right) {
            int sum = sortedValues[left] + sortedValues[right];
            if (sum == target) {
                pairs.add(sortedValues[left] + " + " + sortedValues[right] + " = " + target);
                left++;
                right--;
                while (left < right && sortedValues[left] == sortedValues[left - 1]) {
                    left++;
                }
                while (left < right && sortedValues[right] == sortedValues[right + 1]) {
                    right--;
                }
            } else if (sum < target) {
                left++;
            } else {
                right--;
            }
        }
        return pairs;
    }
}
