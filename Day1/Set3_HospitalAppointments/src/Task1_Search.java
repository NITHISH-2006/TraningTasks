import java.util.Locale;
import java.util.Random;

public class Task1_Search {

    static class Patient {
        final int patientId;
        final String name;
        final int age;

        Patient(int patientId, String name, int age) {
            this.patientId = patientId;
            this.name = name;
            this.age = age;
        }
    }

    public static void main(String[] args) {
        int recordCount = 20_000;
        int lookups = 1_000;
        Patient[] patients = generatePatients(recordCount);
        int[] targets = buildTargets(recordCount, lookups);

        for (int i = 0; i < 50; i++) {
            linearSearch(patients, targets[i % targets.length]);
            binarySearch(patients, targets[i % targets.length]);
        }

        long linearStart = System.nanoTime();
        long linearChecksum = 0;
        for (int target : targets) {
            linearChecksum += linearSearch(patients, target);
        }
        long linearNs = System.nanoTime() - linearStart;

        long binaryStart = System.nanoTime();
        long binaryChecksum = 0;
        for (int target : targets) {
            binaryChecksum += binarySearch(patients, target);
        }
        long binaryNs = System.nanoTime() - binaryStart;

        Patient sample = patients[binarySearch(patients, targets[0])];

        System.out.println("--- Task 1: Search 20,000 Patients ---");
        System.out.println("Look-ups performed: " + String.format(Locale.US, "%,d", lookups));
        System.out.println("Sample patient: ID=" + sample.patientId + ", name=" + sample.name
                + ", age=" + sample.age);
        System.out.println(String.format(Locale.US, "1,000 Iterations -> Linear: %.2f ms | Binary: %.2f ms",
                linearNs / 1_000_000.0, binaryNs / 1_000_000.0));
        System.out.println("Checksums: " + linearChecksum + " / " + binaryChecksum);
        System.out.println("Speed-up: "
                + String.format(Locale.US, "%.1fx", (double) linearNs / Math.max(1, binaryNs)));
    }

    static Patient[] generatePatients(int count) {
        Random random = new Random(303);
        Patient[] patients = new Patient[count];
        for (int i = 0; i < count; i++) {
            patients[i] = new Patient(i + 1, "Patient-" + (i + 1), 1 + random.nextInt(90));
        }
        return patients;
    }

    static int[] buildTargets(int recordCount, int iterations) {
        Random random = new Random(17);
        int[] targets = new int[iterations];
        for (int i = 0; i < iterations; i++) {
            if (random.nextInt(10) == 0) {
                targets[i] = recordCount + 1 + random.nextInt(500);
            } else {
                targets[i] = 1 + random.nextInt(recordCount);
            }
        }
        return targets;
    }

    static int linearSearch(Patient[] patients, int patientId) {
        for (int i = 0; i < patients.length; i++) {
            if (patients[i].patientId == patientId) {
                return i;
            }
        }
        return -1;
    }

    static int binarySearch(Patient[] patients, int patientId) {
        int left = 0;
        int right = patients.length - 1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (patients[mid].patientId == patientId) {
                return mid;
            }
            if (patients[mid].patientId < patientId) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return -1;
    }
}
