import java.util.Comparator;
import java.util.Locale;
import java.util.Random;

public class Task2_Sorting {

    static class Appointment {
        final int patientId;
        final int urgency;
        final int arrivalMinute;

        Appointment(int patientId, int urgency, int arrivalMinute) {
            this.patientId = patientId;
            this.urgency = urgency;
            this.arrivalMinute = arrivalMinute;
        }

        String label() {
            return String.format(Locale.US, "P%03d(L%d, %02d:%02d)",
                    patientId, urgency, arrivalMinute / 60, arrivalMinute % 60);
        }
    }

    static final Comparator<Appointment> PRIORITY = (first, second) -> {
        if (first.urgency != second.urgency) {
            return Integer.compare(first.urgency, second.urgency);
        }
        return Integer.compare(first.arrivalMinute, second.arrivalMinute);
    };

    static long quickSwaps;

    public static void main(String[] args) {
        int recordCount = 20_000;
        Appointment[] original = generateAppointments(recordCount);

        Appointment[] selectionInput = original.clone();
        long selectionStart = System.nanoTime();
        long selectionSwaps = selectionSort(selectionInput);
        long selectionNs = System.nanoTime() - selectionStart;

        Appointment[] quickInput = original.clone();
        quickSwaps = 0;
        long quickStart = System.nanoTime();
        quickSort(quickInput, 0, quickInput.length - 1);
        long quickNs = System.nanoTime() - quickStart;

        System.out.println("--- Task 2: Priority Sort (Urgency then Arrival) ---");
        System.out.print("Sorted Queue (first 5): ");
        for (int i = 0; i < Math.min(5, quickInput.length); i++) {
            System.out.print(quickInput[i].label());
            if (i < Math.min(5, quickInput.length) - 1) {
                System.out.print(" -> ");
            }
        }
        System.out.println();
        System.out.println(String.format(Locale.US,
                "QuickSort: %,d Swaps (%.2f ms) | Selection Sort: %,d Swaps (%.2f ms)",
                quickSwaps, quickNs / 1_000_000.0, selectionSwaps, selectionNs / 1_000_000.0));
        System.out.println("QuickSort result sorted: " + isSorted(quickInput));
        System.out.println("Selection Sort result sorted: " + isSorted(selectionInput));
    }

    static long selectionSort(Appointment[] appointments) {
        long swaps = 0;
        for (int i = 0; i < appointments.length - 1; i++) {
            int minIndex = i;
            for (int j = i + 1; j < appointments.length; j++) {
                if (PRIORITY.compare(appointments[j], appointments[minIndex]) < 0) {
                    minIndex = j;
                }
            }
            if (minIndex != i) {
                Appointment temp = appointments[i];
                appointments[i] = appointments[minIndex];
                appointments[minIndex] = temp;
                swaps++;
            }
        }
        return swaps;
    }

    static void quickSort(Appointment[] appointments, int low, int high) {
        if (low >= high) {
            return;
        }
        Appointment pivot = appointments[(low + high) / 2];
        int i = low;
        int j = high;
        while (i <= j) {
            while (PRIORITY.compare(appointments[i], pivot) < 0) {
                i++;
            }
            while (PRIORITY.compare(appointments[j], pivot) > 0) {
                j--;
            }
            if (i <= j) {
                Appointment temp = appointments[i];
                appointments[i] = appointments[j];
                appointments[j] = temp;
                quickSwaps++;
                i++;
                j--;
            }
        }
        quickSort(appointments, low, j);
        quickSort(appointments, i, high);
    }

    static boolean isSorted(Appointment[] appointments) {
        for (int i = 1; i < appointments.length; i++) {
            if (PRIORITY.compare(appointments[i - 1], appointments[i]) > 0) {
                return false;
            }
        }
        return true;
    }

    static Appointment[] generateAppointments(int count) {
        Random random = new Random(404);
        Appointment[] appointments = new Appointment[count];
        for (int i = 0; i < count; i++) {
            appointments[i] = new Appointment(
                    i + 1,
                    1 + random.nextInt(3),
                    random.nextInt(24 * 60));
        }
        return appointments;
    }
}
