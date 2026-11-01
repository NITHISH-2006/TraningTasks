import java.util.Arrays;
import java.util.Comparator;
import java.util.Locale;
import java.util.Random;

public class Task2_Sorting {

    static class Order {
        final int id;
        final double amount;

        Order(int id, double amount) {
            this.id = id;
            this.amount = amount;
        }

        @Override
        public String toString() {
            return String.format(Locale.US, "%.1f", amount);
        }
    }

    public static void main(String[] args) {
        Order[] traceSample = {
                new Order(1, 1200.0),
                new Order(2, 450.0),
                new Order(3, 980.0),
                new Order(4, 300.0),
                new Order(5, 760.0),
                new Order(6, 150.0)
        };

        System.out.println("--- Task 2: Sort by Amount (Descending) ---");
        Order[] traced = traceSample.clone();
        bubbleSortDescending(traced, true, 3);
        System.out.println("Trace sample after first three passes: " + Arrays.toString(traced));

        int recordCount = 10_000;
        Order[] original = generateOrders(recordCount);

        Order[] warmUp = generateOrders(300);
        bubbleSortDescending(warmUp.clone(), false, Integer.MAX_VALUE);
        Arrays.sort(warmUp.clone(), Comparator.comparingDouble((Order o) -> o.amount).reversed());

        Order[] bubbleInput = original.clone();
        long bubbleStart = System.nanoTime();
        bubbleSortDescending(bubbleInput, false, Integer.MAX_VALUE);
        long bubbleNs = System.nanoTime() - bubbleStart;

        Order[] mergeInput = original.clone();
        long mergeStart = System.nanoTime();
        mergeSortDescending(mergeInput, 0, mergeInput.length - 1);
        long mergeNs = System.nanoTime() - mergeStart;

        Order[] builtInInput = original.clone();
        long builtInStart = System.nanoTime();
        Arrays.sort(builtInInput, Comparator.comparingDouble((Order o) -> o.amount).reversed());
        long builtInNs = System.nanoTime() - builtInStart;

        boolean mergeMatchesBuiltIn = sameAmounts(mergeInput, builtInInput);

        System.out.println(String.format(Locale.US,
                "Execution -> Bubble Sort: %.2f ms | Merge Sort: %.2f ms | Built-in (TimSort): %.2f ms",
                bubbleNs / 1_000_000.0,
                mergeNs / 1_000_000.0,
                builtInNs / 1_000_000.0));
        System.out.println("Merge Sort output matches built-in sort: " + mergeMatchesBuiltIn);
        System.out.println("Bubble Sort output matches built-in sort: " + sameAmounts(bubbleInput, builtInInput));
        System.out.println("Top 3 amounts after sorting: "
                + Arrays.toString(Arrays.copyOf(builtInInput, 3)));
    }

    static void bubbleSortDescending(Order[] orders, boolean trace, int maxPasses) {
        int n = orders.length;
        int passes = Math.min(maxPasses, Math.max(0, n - 1));
        for (int i = 0; i < passes; i++) {
            boolean swapped = false;
            for (int j = 0; j < n - 1 - i; j++) {
                if (orders[j].amount < orders[j + 1].amount) {
                    Order temp = orders[j];
                    orders[j] = orders[j + 1];
                    orders[j + 1] = temp;
                    swapped = true;
                }
            }
            if (trace) {
                System.out.println("Pass " + (i + 1) + " Trace: " + Arrays.toString(orders));
            }
            if (!swapped) {
                break;
            }
        }
    }

    static void mergeSortDescending(Order[] orders, int left, int right) {
        if (left >= right) {
            return;
        }
        int mid = left + (right - left) / 2;
        mergeSortDescending(orders, left, mid);
        mergeSortDescending(orders, mid + 1, right);
        mergeDescending(orders, left, mid, right);
    }

    static void mergeDescending(Order[] orders, int left, int mid, int right) {
        Order[] leftPart = Arrays.copyOfRange(orders, left, mid + 1);
        Order[] rightPart = Arrays.copyOfRange(orders, mid + 1, right + 1);

        int i = 0;
        int j = 0;
        int k = left;

        while (i < leftPart.length && j < rightPart.length) {
            if (leftPart[i].amount >= rightPart[j].amount) {
                orders[k++] = leftPart[i++];
            } else {
                orders[k++] = rightPart[j++];
            }
        }
        while (i < leftPart.length) {
            orders[k++] = leftPart[i++];
        }
        while (j < rightPart.length) {
            orders[k++] = rightPart[j++];
        }
    }

    static boolean sameAmounts(Order[] first, Order[] second) {
        if (first.length != second.length) {
            return false;
        }
        for (int i = 0; i < first.length; i++) {
            if (first[i].amount != second[i].amount) {
                return false;
            }
        }
        return true;
    }

    static Order[] generateOrders(int count) {
        Random random = new Random(123);
        Order[] orders = new Order[count];
        for (int i = 0; i < count; i++) {
            orders[i] = new Order(i + 1, Math.round(random.nextDouble() * 10_000 * 100.0) / 100.0);
        }
        return orders;
    }
}
