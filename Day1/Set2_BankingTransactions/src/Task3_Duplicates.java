import java.util.Arrays;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.Random;

public class Task3_Duplicates {

    static class Transaction {
        final String transactionId;
        final String accountId;
        final double amount;
        final String merchant;
        final int timeSeconds;

        Transaction(String transactionId, String accountId, double amount, String merchant, int timeSeconds) {
            this.transactionId = transactionId;
            this.accountId = accountId;
            this.amount = amount;
            this.merchant = merchant;
            this.timeSeconds = timeSeconds;
        }
    }

    public static void main(String[] args) {
        Transaction[] transactions = generateTransactions(10_000);
        Arrays.sort(transactions, Comparator.comparingInt(transaction -> transaction.timeSeconds));

        Map<String, Integer> lastSeen = new HashMap<>();
        int alerts = 0;
        int printed = 0;

        long start = System.nanoTime();
        for (Transaction transaction : transactions) {
            String key = transaction.accountId + "|"
                    + String.format(Locale.US, "%.2f", transaction.amount) + "|"
                    + transaction.merchant;

            Integer previousTime = lastSeen.get(key);
            if (previousTime != null && transaction.timeSeconds - previousTime <= 60) {
                alerts++;
                if (printed < 10) {
                    System.out.println(String.format(Locale.US,
                            "ALERT: %s double-posted within %d seconds (account=%s, amount=%.2f, merchant=%s, first=%s, second=%s)",
                            transaction.transactionId,
                            transaction.timeSeconds - previousTime,
                            transaction.accountId,
                            transaction.amount,
                            transaction.merchant,
                            formatTime(previousTime),
                            formatTime(transaction.timeSeconds)));
                    printed++;
                }
            }
            lastSeen.put(key, transaction.timeSeconds);
        }
        long elapsedNs = System.nanoTime() - start;

        System.out.println("--- Task 3: 60-Second Window Duplicate Detection ---");
        System.out.println("Transactions scanned: " + String.format(Locale.US, "%,d", transactions.length));
        System.out.println("Double-post warnings: " + alerts);
        System.out.println(String.format(Locale.US, "HashMap window scan time: %.2f ms", elapsedNs / 1_000_000.0));
        System.out.println("Time complexity: O(n log n) for the sort + O(n) scan; space O(n).");
    }

    static String formatTime(int secondsOfDay) {
        return String.format(Locale.US, "%02d:%02d:%02d",
                secondsOfDay / 3600, (secondsOfDay / 60) % 60, secondsOfDay % 60);
    }

    static Transaction[] generateTransactions(int count) {
        Random random = new Random(77);
        Transaction[] transactions = new Transaction[count];

        for (int i = 0; i < count; i++) {
            if (i > 10 && i % 700 == 0) {
                Transaction source = transactions[i - 10];
                int duplicatedTime = Math.min(86_399, source.timeSeconds + random.nextInt(60));
                transactions[i] = new Transaction(
                        "TX-" + (80_000 + i),
                        source.accountId,
                        source.amount,
                        source.merchant,
                        duplicatedTime);
            } else {
                transactions[i] = new Transaction(
                        "TX-" + (80_000 + i),
                        "ACC-" + (1_000 + random.nextInt(500)),
                        Math.round(random.nextDouble() * 900 * 100.0) / 100.0,
                        random.nextBoolean() ? "AMAZON" : "SHELL",
                        random.nextInt(86_400));
            }
        }
        return transactions;
    }
}
