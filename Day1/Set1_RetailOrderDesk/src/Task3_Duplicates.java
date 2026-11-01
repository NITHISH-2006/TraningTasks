import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Locale;
import java.util.Random;
import java.util.Set;

public class Task3_Duplicates {

    static class Order {
        final int orderId;
        final int customerId;
        final double amount;
        final LocalDateTime createdAt;

        Order(int orderId, int customerId, double amount, LocalDateTime createdAt) {
            this.orderId = orderId;
            this.customerId = customerId;
            this.amount = amount;
            this.createdAt = createdAt;
        }
    }

    public static void main(String[] args) {
        int recordCount = 50_000;
        Order[] orders = generateOrders(recordCount);

        Set<String> seen = new HashSet<>();
        int duplicates = 0;
        int printedAlerts = 0;

        long start = System.nanoTime();
        for (Order order : orders) {
            String key = buildKey(order);
            if (!seen.add(key)) {
                duplicates++;
                if (printedAlerts < 10) {
                    System.out.println(String.format(Locale.US,
                            "Alert: Duplicate Order detected for Customer %d (Amt: %.2f) at %s "
                                    + "[orderId=%d]",
                            order.customerId,
                            order.amount,
                            order.createdAt.withSecond(0).withNano(0),
                            order.orderId));
                    printedAlerts++;
                }
            }
        }
        long elapsedNs = System.nanoTime() - start;

        System.out.println("--- Task 3: Duplicate Order Detection ---");
        System.out.println("Orders scanned: " + String.format(Locale.US, "%,d", recordCount));
        System.out.println("Duplicates blocked: " + String.format(Locale.US, "%,d", duplicates));
        System.out.println(String.format(Locale.US, "HashSet scan time: %.2f ms", elapsedNs / 1_000_000.0));
        System.out.println("Time complexity: O(n) expected, O(n) space for the seen set.");
    }

    static String buildKey(Order order) {
        LocalDateTime minute = order.createdAt.withSecond(0).withNano(0);
        return order.customerId + "|" + String.format(Locale.US, "%.2f", order.amount) + "|" + minute;
    }

    static Order[] generateOrders(int count) {
        Random random = new Random(2026);
        Order[] orders = new Order[count];
        LocalDateTime base = LocalDateTime.of(2026, 10, 29, 8, 0);

        for (int i = 0; i < count; i++) {
            if (i > 0 && i % 500 == 0) {
                Order source = orders[random.nextInt(i)];
                orders[i] = new Order(i + 1, source.customerId, source.amount, source.createdAt);
            } else {
                orders[i] = new Order(
                        i + 1,
                        1_000 + random.nextInt(9_000),
                        Math.round(random.nextDouble() * 2_000 * 100.0) / 100.0,
                        base.plusMinutes(random.nextInt(24 * 60)).plusSeconds(random.nextInt(60)));
            }
        }
        return orders;
    }
}
