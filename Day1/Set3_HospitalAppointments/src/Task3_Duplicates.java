import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class Task3_Duplicates {

    static class Booking {
        final int patientId;
        final String slotTime;

        Booking(int patientId, String slotTime) {
            this.patientId = patientId;
            this.slotTime = slotTime;
        }
    }

    public static void main(String[] args) {
        List<Booking> bookings = List.of(
                new Booking(105, "09:00"),
                new Booking(105, "09:00"),
                new Booking(105, "09:30"),
                new Booking(106, "09:00"),
                new Booking(107, "10:00"),
                new Booking(107, "10:00"),
                new Booking(107, "10:00"),
                new Booking(108, "10:30"),
                new Booking(109, "11:00"),
                new Booking(110, "11:00"));

        Set<String> ledger = new HashSet<>();
        int confirmed = 0;
        int rejected = 0;

        long start = System.nanoTime();
        for (Booking booking : bookings) {
            String key = booking.patientId + "|" + booking.slotTime;
            if (ledger.add(key)) {
                confirmed++;
                System.out.println("Slot " + booking.slotTime + " -> Patient " + booking.patientId + ": CONFIRMED");
            } else {
                rejected++;
                System.out.println("Slot " + booking.slotTime + " -> Patient " + booking.patientId
                        + ": REJECTED (Double Booking)");
            }
        }
        long elapsedNs = System.nanoTime() - start;

        System.out.println("--- Task 3: Booking Validation ---");
        System.out.println("Bookings processed: " + bookings.size()
                + " | Confirmed: " + confirmed + " | Rejected: " + rejected);
        System.out.println(String.format(java.util.Locale.US,
                "HashSet validation time: %.4f ms", elapsedNs / 1_000_000.0));
        System.out.println("Time complexity: O(1) expected per booking; space O(number of slots).");
    }
}
