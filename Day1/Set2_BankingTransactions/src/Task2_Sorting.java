import java.util.Arrays;
import java.util.Locale;
import java.util.Random;

public class Task2_Sorting {

    static class Transaction {
        final int transactionId;
        final String description;
        final int postingMinute;
        final int originalIndex;

        Transaction(int transactionId, String description, int postingMinute, int originalIndex) {
            this.transactionId = transactionId;
            this.description = description;
            this.postingMinute = postingMinute;
            this.originalIndex = originalIndex;
        }

        String timeLabel() {
            return String.format(Locale.US, "%02d:%02d", postingMinute / 60, postingMinute % 60);
        }

        @Override
        public String toString() {
            return "TX" + transactionId + "@" + timeLabel() + "(" + description + ")";
        }
    }

    public static void main(String[] args) {
        Transaction[] sample = {
                new Transaction(3, "Transfer", 9 * 60 + 15, 0),
                new Transaction(1, "Purchase", 9 * 60, 1),
                new Transaction(4, "Deposit", 8 * 60 + 45, 2),
                new Transaction(2, "Refund", 9 * 60, 3)
        };

        Transaction[] insertionSample = sample.clone();
        insertionSort(insertionSample);

        System.out.println("--- Task 2: Stable Sort by Posting Date ---");
        System.out.println("Insertion Sort: " + Arrays.toString(insertionSample));
        System.out.println("Stability Verified: Purchase remains before Refund -> "
                + (indexOf(insertionSample, 1) < indexOf(insertionSample, 2)));

        int recordCount = 20_000;
        Transaction[] original = generateTransactions(recordCount);

        Transaction[] insertionInput = original.clone();
        long insertionStart = System.nanoTime();
        insertionSort(insertionInput);
        long insertionNs = System.nanoTime() - insertionStart;

        Transaction[] mergeInput = original.clone();
        long mergeStart = System.nanoTime();
        mergeSort(mergeInput, 0, mergeInput.length - 1);
        long mergeNs = System.nanoTime() - mergeStart;

        System.out.println(String.format(Locale.US,
                "20,000 records -> Insertion Sort: %.2f ms | Merge Sort: %.2f ms",
                insertionNs / 1_000_000.0, mergeNs / 1_000_000.0));
        System.out.println("Insertion Sort stable: " + isStable(insertionInput));
        System.out.println("Merge Sort stable: " + isStable(mergeInput));
    }

    static void insertionSort(Transaction[] transactions) {
        for (int i = 1; i < transactions.length; i++) {
            Transaction key = transactions[i];
            int j = i - 1;
            while (j >= 0 && transactions[j].postingMinute > key.postingMinute) {
                transactions[j + 1] = transactions[j];
                j--;
            }
            transactions[j + 1] = key;
        }
    }

    static void mergeSort(Transaction[] transactions, int left, int right) {
        if (left >= right) {
            return;
        }
        int mid = left + (right - left) / 2;
        mergeSort(transactions, left, mid);
        mergeSort(transactions, mid + 1, right);
        merge(transactions, left, mid, right);
    }

    static void merge(Transaction[] transactions, int left, int mid, int right) {
        Transaction[] leftPart = Arrays.copyOfRange(transactions, left, mid + 1);
        Transaction[] rightPart = Arrays.copyOfRange(transactions, mid + 1, right + 1);

        int i = 0;
        int j = 0;
        int k = left;
        while (i < leftPart.length && j < rightPart.length) {
            if (leftPart[i].postingMinute <= rightPart[j].postingMinute) {
                transactions[k++] = leftPart[i++];
            } else {
                transactions[k++] = rightPart[j++];
            }
        }
        while (i < leftPart.length) {
            transactions[k++] = leftPart[i++];
        }
        while (j < rightPart.length) {
            transactions[k++] = rightPart[j++];
        }
    }

    static boolean isStable(Transaction[] transactions) {
        for (int i = 1; i < transactions.length; i++) {
            if (transactions[i - 1].postingMinute == transactions[i].postingMinute
                    && transactions[i - 1].originalIndex > transactions[i].originalIndex) {
                return false;
            }
        }
        return true;
    }

    static int indexOf(Transaction[] transactions, int transactionId) {
        for (int i = 0; i < transactions.length; i++) {
            if (transactions[i].transactionId == transactionId) {
                return i;
            }
        }
        return -1;
    }

    static Transaction[] generateTransactions(int count) {
        Random random = new Random(31);
        Transaction[] transactions = new Transaction[count];
        for (int i = 0; i < count; i++) {
            transactions[i] = new Transaction(
                    i + 1,
                    random.nextBoolean() ? "Purchase" : "Refund",
                    random.nextInt(24 * 60),
                    i);
        }
        return transactions;
    }
}
