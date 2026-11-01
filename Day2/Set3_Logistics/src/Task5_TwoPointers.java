import java.util.Arrays;

public class Task5_TwoPointers {

    public static void main(String[] args) {
        String[] routes = {
                "DEL-BOM-BLR-BOM-DEL",
                "del bom blr bom del",
                "DEL-BOM-BLR-DEL",
                "DEL/BOM/BLR/BOM/DEL",
                "HYD-CCU-HYD"
        };

        System.out.println("--- Task 5: Palindrome Route Check (Two Pointers) ---");
        for (String route : routes) {
            String[] hubCodes = tokenize(route);
            System.out.println("\"" + route + "\" -> hub codes " + Arrays.toString(hubCodes)
                    + " -> palindrome: " + isPalindrome(hubCodes));
        }
        System.out.println("Time complexity: O(n) two-pointer scan over the hub-code tokens; space O(n) for the tokens.");
    }

    static String[] tokenize(String route) {
        String trimmed = route.trim();
        if (trimmed.isEmpty()) {
            return new String[0];
        }
        return trimmed.toUpperCase().split("[^A-Z0-9]+");
    }

    static boolean isPalindrome(String[] hubCodes) {
        int left = 0;
        int right = hubCodes.length - 1;
        while (left < right) {
            if (!hubCodes[left].equals(hubCodes[right])) {
                return false;
            }
            left++;
            right--;
        }
        return true;
    }
}
