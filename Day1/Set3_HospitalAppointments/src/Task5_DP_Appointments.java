import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Locale;

public class Task5_DP_Appointments {

    static class Slot {
        final String label;
        final int start;
        final int end;

        Slot(String label, int start, int duration) {
            this.label = label;
            this.start = start;
            this.end = start + duration;
        }

        @Override
        public String toString() {
            return String.format(Locale.US, "[%02d:00-%02d:00] %s", start, end, label);
        }
    }

    public static void main(String[] args) {
        List<Slot> slots = new ArrayList<>(List.of(
                new Slot("Long ward round", 0, 10),
                new Slot("Short consult A", 1, 1),
                new Slot("Short consult B", 2, 1),
                new Slot("Short consult C", 3, 1),
                new Slot("Short consult D", 4, 1),
                new Slot("Short consult E", 5, 1),
                new Slot("Short consult F", 6, 1),
                new Slot("Short consult G", 7, 1),
                new Slot("Follow-up H", 10, 1),
                new Slot("Follow-up I", 11, 1)
        ));

        List<Slot> dpSchedule = maxAppointmentsDP(slots);
        List<Slot> greedySchedule = greedyEarliestStart(slots);

        System.out.println("--- Task 5: Shift Capacity (DP vs Greedy) ---");
        System.out.println("Available overlapping slots: " + slots.size());
        System.out.println("DP Algorithm scheduled Max " + dpSchedule.size() + " appointments: " + dpSchedule);
        System.out.println("Greedy Algorithm (Earliest Start) scheduled only " + greedySchedule.size()
                + ": " + greedySchedule);
        System.out.println("Time complexity: O(n log n) sort + O(n log n) DP with binary search; space O(n).");
    }

    static List<Slot> maxAppointmentsDP(List<Slot> slots) {
        Slot[] sorted = slots.toArray(new Slot[0]);
        Arrays.sort(sorted, Comparator.comparingInt(slot -> slot.end));

        int n = sorted.length;
        int[] previous = new int[n];
        for (int i = 0; i < n; i++) {
            previous[i] = latestNonConflicting(sorted, i);
        }

        int[] dp = new int[n + 1];
        for (int i = 1; i <= n; i++) {
            int include = 1 + dp[previous[i - 1] + 1];
            dp[i] = Math.max(include, dp[i - 1]);
        }

        List<Slot> chosen = new ArrayList<>();
        int i = n;
        while (i > 0) {
            if (dp[i] == dp[i - 1]) {
                i--;
            } else {
                Slot slot = sorted[i - 1];
                chosen.add(slot);
                i = previous[i - 1] + 1;
            }
        }
        Collections.reverse(chosen);
        return chosen;
    }

    static int latestNonConflicting(Slot[] sorted, int index) {
        int low = 0;
        int high = index - 1;
        int result = -1;
        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (sorted[mid].end <= sorted[index].start) {
                result = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        return result;
    }

    static List<Slot> greedyEarliestStart(List<Slot> slots) {
        Slot[] sorted = slots.toArray(new Slot[0]);
        Arrays.sort(sorted, Comparator.comparingInt(slot -> slot.start));

        List<Slot> chosen = new ArrayList<>();
        int lastEnd = Integer.MIN_VALUE;
        for (Slot slot : sorted) {
            if (slot.start >= lastEnd) {
                chosen.add(slot);
                lastEnd = slot.end;
            }
        }
        return chosen;
    }
}
