import java.util.Arrays;

public class Task5_TwoPointers {

    public static void main(String[] args) {
        int[] northernOffice = {1012, 1045, 1103, 1288, 1450};
        int[] southernOffice = {1008, 1029, 1180, 1204, 1399, 1602};

        int[] merged = mergeSorted(northernOffice, southernOffice);
        boolean sorted = isSorted(merged);

        System.out.println("--- Task 5: Two-Pointer Merge of Sorted Claim Lists ---");
        System.out.println("Northern office: " + Arrays.toString(northernOffice));
        System.out.println("Southern office: " + Arrays.toString(southernOffice));
        System.out.println("Merged         : " + Arrays.toString(merged));
        System.out.println("Merged list is sorted: " + sorted);
        System.out.println("Time complexity: O(n + m); space O(n + m) for the merged output.");
    }

    static int[] mergeSorted(int[] first, int[] second) {
        int[] merged = new int[first.length + second.length];
        int i = 0;
        int j = 0;
        int k = 0;

        while (i < first.length && j < second.length) {
            if (first[i] <= second[j]) {
                merged[k++] = first[i++];
            } else {
                merged[k++] = second[j++];
            }
        }
        while (i < first.length) {
            merged[k++] = first[i++];
        }
        while (j < second.length) {
            merged[k++] = second[j++];
        }
        return merged;
    }

    static boolean isSorted(int[] values) {
        for (int i = 1; i < values.length; i++) {
            if (values[i - 1] > values[i]) {
                return false;
            }
        }
        return true;
    }
}
