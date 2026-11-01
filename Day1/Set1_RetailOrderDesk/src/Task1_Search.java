import java.util.Locale;
import java.util.Random;

public class Task1_Search {

    static class Order {
        final int id;
        final int customerId;
        final double amount;
        final long createdAt;

        Order(int id, int customerId, double amount, long createdAt) {
            this.id = id;
            this.customerId = customerId;
            this.amount = amount;
            this.createdAt = createdAt;
        }
    }

    public static void main(String[] args) {
        int recordCount = 50_000;
        int iterations = 1_000;

        Order[] orders = generateOrders(recordCount);
        int[] targets = buildTargets(recordCount, iterations);

        for (int i = 0; i < 50; i++) {
            linearSearch(orders, targets[i % targets.length]);
            binarySearch(orders, targets[i % targets.length]);
        }

        long linearStart = System.nanoTime();
        long linearChecksum = 0;
        for (int target : targets) {
            linearChecksum += linearSearch(orders, target);
        }
        long linearNs = System.nanoTime() - linearStart;

        long binaryStart = System.nanoTime();
        long binaryChecksum = 0;
        for (int target : targets) {
            binaryChecksum += binarySearch(orders, target);
        }
        long binaryNs = System.nanoTime() - binaryStart;

        int sampleTarget = targets[0];
        int sampleIndex = binarySearch(orders, sampleTarget);
        Order sample = orders[sampleIndex];

        System.out.println("--- Task 1: Search (" + String.format(Locale.US, "%,d", recordCount) + " records) ---");
        System.out.println("Look-ups performed: " + String.format(Locale.US, "%,d", iterations));
        System.out.println("Sample order found by ID " + sampleTarget + ": index=" + sampleIndex
                + ", customerId=" + sample.customerId
                + ", amount=" + String.format(Locale.US, "%.2f", sample.amount));
        System.out.println(String.format(Locale.US, "%,d Iterations -> Linear Search Time: %.2f ms",
                iterations, linearNs / 1_000_000.0));
        System.out.println(String.format(Locale.US, "%,d Iterations -> Binary Search Time: %.2f ms",
                iterations, binaryNs / 1_000_000.0));
        System.out.println("Checksums (used to prevent dead-code elimination): "
                + linearChecksum + " / " + binaryChecksum);
        System.out.println("Speed-up: "
                + String.format(Locale.US, "%.1fx", (double) linearNs / Math.max(1, binaryNs)));
    }

    static Order[] generateOrders(int count) {
        Random random = new Random(42);
        Order[] orders = new Order[count];
        long baseTime = 1_760_000_000_000L;
        for (int i = 0; i < count; i++) {
            orders[i] = new Order(
                    i + 1,
                    1_000 + random.nextInt(9_000),
                    Math.round(random.nextDouble() * 5_000 * 100.0) / 100.0,
                    baseTime + random.nextInt(86_400) * 1_000L);
        }
        return orders;
    }

    static int[] buildTargets(int recordCount, int iterations) {
        Random random = new Random(7);
        int[] targets = new int[iterations];
        for (int i = 0; i < iterations; i++) {
            if (random.nextInt(10) == 0) {
                targets[i] = recordCount + 1 + random.nextInt(1_000);
            } else {
                targets[i] = 1 + random.nextInt(recordCount);
            }
        }
        return targets;
    }

    static int linearSearch(Order[] orders, int targetId) {
        for (int i = 0; i < orders.length; i++) {
            if (orders[i].id == targetId) {
                return i;
            }
        }
        return -1;
    }

    static int binarySearch(Order[] orders, int targetId) {
        int left = 0;
        int right = orders.length - 1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (orders[mid].id == targetId) {
                return mid;
            }
            if (orders[mid].id < targetId) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return -1;
    }
}
