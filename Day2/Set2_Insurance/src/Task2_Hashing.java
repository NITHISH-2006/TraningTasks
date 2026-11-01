import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class Task2_Hashing {

    static class Claim {
        final String claimId;
        final String policyNumber;
        final String incidentDate;

        Claim(String claimId, String policyNumber, String incidentDate) {
            this.claimId = claimId;
            this.policyNumber = policyNumber;
            this.incidentDate = incidentDate;
        }

        @Override
        public String toString() {
            return claimId + "[" + policyNumber + ", " + incidentDate + "]";
        }
    }

    public static void main(String[] args) {
        List<Claim> claims = List.of(
                new Claim("CLM-1001", "POL-1001", "2026-10-01"),
                new Claim("CLM-1002", "pol-1001", "2026-10-01"),
                new Claim("CLM-1003", " POL 1001 ", "2026-10-01"),
                new Claim("CLM-1004", "POL-1002", "2026-10-02"),
                new Claim("CLM-1005", "POL 1002", "2026-10-03"),
                new Claim("CLM-1006", "POL-1003", "2026-10-04"),
                new Claim("CLM-1007", "pol 1003", "2026-10-04 "),
                new Claim("CLM-1008", "POL-1004", "2026-10-05")
        );

        System.out.println("--- Task 2: Duplicate / Near-Duplicate Claims ---");
        Map<String, List<Claim>> groups = detectDuplicates(claims);
        int duplicateGroups = 0;
        for (Map.Entry<String, List<Claim>> entry : groups.entrySet()) {
            if (entry.getValue().size() > 1) {
                duplicateGroups++;
                System.out.println("Duplicate group " + entry.getKey() + " -> " + entry.getValue());
            }
        }
        System.out.println("Duplicate groups detected: " + duplicateGroups);

        Map<String, List<Claim>> emptyResult = detectDuplicates(List.of());
        System.out.println("Empty input -> duplicate groups: " + emptyResult.size());

        System.out.println("Collisions are handled by HashMap chaining: equal normalized keys share a bucket chain,");
        System.out.println("and equals() identifies the matching entry during look-up.");
    }

    static Map<String, List<Claim>> detectDuplicates(List<Claim> claims) {
        Map<String, List<Claim>> groups = new LinkedHashMap<>();
        for (Claim claim : claims) {
            String key = normalize(claim.policyNumber) + "|" + claim.incidentDate.trim();
            groups.computeIfAbsent(key, ignored -> new ArrayList<>()).add(claim);
        }
        return groups;
    }

    static String normalize(String policyNumber) {
        return policyNumber.toUpperCase().replaceAll("[^A-Z0-9]", "");
    }
}
