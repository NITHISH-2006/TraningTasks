import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

public class Task2_HashTable {

    static class ChainedHashTable {
        static class Entry {
            final String key;
            double value;
            Entry next;

            Entry(String key, double value, Entry next) {
                this.key = key;
                this.value = value;
                this.next = next;
            }
        }

        private final Entry[] buckets;

        ChainedHashTable(int capacity) {
            buckets = new Entry[capacity];
        }

        private int bucketIndex(String key) {
            return Math.floorMod(key.hashCode(), buckets.length);
        }

        void put(String key, double value) {
            int index = bucketIndex(key);
            Entry current = buckets[index];
            while (current != null) {
                if (current.key.equals(key)) {
                    current.value = value;
                    return;
                }
                current = current.next;
            }
            buckets[index] = new Entry(key, value, buckets[index]);
        }

        Double get(String key) {
            int index = bucketIndex(key);
            Entry current = buckets[index];
            while (current != null) {
                if (current.key.equals(key)) {
                    return current.value;
                }
                current = current.next;
            }
            return null;
        }

        List<String> bucketContents(int index) {
            List<String> keys = new ArrayList<>();
            Entry current = buckets[index];
            while (current != null) {
                keys.add(current.key);
                current = current.next;
            }
            return keys;
        }
    }

    public static void main(String[] args) {
        demonstrateCollision();

        int skuCount = 100_000;
        String[] skus = new String[skuCount];
        double[] prices = new double[skuCount];
        for (int i = 0; i < skuCount; i++) {
            skus[i] = String.format("SKU-%06d", i);
            prices[i] = (i % 5000) + 0.99;
        }

        ChainedHashTable custom = new ChainedHashTable(200_003);
        Map<String, Double> library = new HashMap<>(200_003);
        for (int i = 0; i < skuCount; i++) {
            custom.put(skus[i], prices[i]);
            library.put(skus[i], prices[i]);
        }

        for (int i = 0; i < 1_000; i++) {
            custom.get(skus[i]);
            library.get(skus[i]);
        }

        long customStart = System.nanoTime();
        double customChecksum = 0;
        for (int i = 0; i < skuCount; i++) {
            customChecksum += custom.get(skus[i]);
        }
        long customNs = System.nanoTime() - customStart;

        long libraryStart = System.nanoTime();
        double libraryChecksum = 0;
        for (int i = 0; i < skuCount; i++) {
            libraryChecksum += library.get(skus[i]);
        }
        long libraryNs = System.nanoTime() - libraryStart;

        System.out.println("--- Task 2: Hash Table with Chaining ---");
        System.out.println("100,000 SKU look-ups -> Custom chained table: "
                + String.format(Locale.US, "%.2f ms", customNs / 1_000_000.0)
                + " | java.util.HashMap: "
                + String.format(Locale.US, "%.2f ms", libraryNs / 1_000_000.0));
        System.out.println("Checksums match: " + (Math.abs(customChecksum - libraryChecksum) < 0.0001));
        System.out.println("Expected O(1) average look-up with chaining; O(n) worst case if all keys collide.");
    }

    static void demonstrateCollision() {
        ChainedHashTable table = new ChainedHashTable(5);
        String[] smallSkus = {"SKU-A", "SKU-B", "SKU-C", "SKU-D", "SKU-E", "SKU-F", "SKU-G", "SKU-H"};
        for (int i = 0; i < smallSkus.length; i++) {
            table.put(smallSkus[i], 10.0 + i);
        }

        System.out.println("--- Task 2: Collision Demonstration (capacity = 5) ---");
        for (int bucket = 0; bucket < 5; bucket++) {
            List<String> contents = table.bucketContents(bucket);
            System.out.println("Bucket " + bucket + " (" + contents.size() + " entries): " + contents);
            if (contents.size() > 1) {
                System.out.println("  Collision handled by chaining: " + contents);
            }
        }
    }
}
