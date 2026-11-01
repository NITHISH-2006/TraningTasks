import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class Task2_HashMap {

    static class Scan {
        final String trackingNumber;
        final String hubCode;

        Scan(String trackingNumber, String hubCode) {
            this.trackingNumber = trackingNumber;
            this.hubCode = hubCode;
        }
    }

    public static void main(String[] args) {
        List<Scan> scans = List.of(
                new Scan("TRK-1001", "HUB-DEL"),
                new Scan("TRK-1002", "HUB-BOM"),
                new Scan("TRK-1001", "HUB-DEL"),
                new Scan("TRK-1001", "HUB-JAI"),
                new Scan("TRK-1003", "HUB-MAA"),
                new Scan("TRK-1002", "HUB-BOM"),
                new Scan("TRK-1004", "HUB-CCU"),
                new Scan("TRK-1003", "HUB-MAA"),
                new Scan("TRK-1004", "HUB-CCU")
        );

        Map<String, Set<String>> scansByParcel = new LinkedHashMap<>();
        List<String> duplicateScans = new ArrayList<>();

        for (Scan scan : scans) {
            Set<String> hubs = scansByParcel.computeIfAbsent(
                    scan.trackingNumber, ignored -> new LinkedHashSet<>());
            if (!hubs.add(scan.hubCode)) {
                duplicateScans.add(scan.trackingNumber + " scanned twice at " + scan.hubCode);
            }
        }

        System.out.println("--- Task 2: Parcel Tracking HashMap ---");
        for (Map.Entry<String, Set<String>> entry : scansByParcel.entrySet()) {
            System.out.println(entry.getKey() + " scanned at " + entry.getValue());
        }
        System.out.println("Duplicate same-hub scans: " + duplicateScans.size());
        for (String duplicate : duplicateScans) {
            System.out.println("  WARNING: " + duplicate);
        }
        System.out.println("Time complexity: O(number of scans) with O(1) average hash look-ups.");
    }
}
