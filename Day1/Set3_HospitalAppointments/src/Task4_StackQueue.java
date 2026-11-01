import java.util.ArrayDeque;
import java.util.Deque;
import java.util.Locale;

public class Task4_StackQueue {

    static class Node<T> {
        final T value;
        Node<T> next;

        Node(T value) {
            this.value = value;
        }
    }

    static class CustomQueue<T> {
        private Node<T> head;
        private Node<T> tail;
        private int size;

        void enqueue(T value) {
            Node<T> node = new Node<>(value);
            if (tail != null) {
                tail.next = node;
            }
            tail = node;
            if (head == null) {
                head = tail;
            }
            size++;
        }

        T dequeue() {
            if (head == null) {
                throw new IllegalStateException("Queue is empty");
            }
            T value = head.value;
            head = head.next;
            if (head == null) {
                tail = null;
            }
            size--;
            return value;
        }

        boolean isEmpty() {
            return head == null;
        }

        int size() {
            return size;
        }
    }

    static class CustomStack<T> {
        private Node<T> top;
        private int size;

        void push(T value) {
            Node<T> node = new Node<>(value);
            node.next = top;
            top = node;
            size++;
        }

        T pop() {
            if (top == null) {
                throw new IllegalStateException("Stack is empty");
            }
            T value = top.value;
            top = top.next;
            size--;
            return value;
        }

        boolean isEmpty() {
            return top == null;
        }

        int size() {
            return size;
        }
    }

    public static void main(String[] args) {
        System.out.println("--- Task 4: Walk-in Token Queue & Recent-Patients Stack ---");

        CustomQueue<String> tokenLine = new CustomQueue<>();
        tokenLine.enqueue("Token T-01 (Patient 201)");
        tokenLine.enqueue("Token T-02 (Patient 202)");
        tokenLine.enqueue("Token T-03 (Patient 203)");

        System.out.print("Walk-in Queue: ");
        while (!tokenLine.isEmpty()) {
            System.out.print(tokenLine.dequeue());
            if (!tokenLine.isEmpty()) {
                System.out.print(" -> ");
            }
        }
        System.out.println();

        CustomStack<String> recentPatients = new CustomStack<>();
        recentPatients.push("Patient 201 (Cardiology)");
        recentPatients.push("Patient 202 (Orthopaedics)");
        recentPatients.push("Patient 203 (Neurology)");

        System.out.print("Recent Patients (most recent first): ");
        while (!recentPatients.isEmpty()) {
            System.out.print(recentPatients.pop());
            if (!recentPatients.isEmpty()) {
                System.out.print(" -> ");
            }
        }
        System.out.println();

        Deque<String> libraryQueue = new ArrayDeque<>();
        libraryQueue.addLast("Token T-01 (Patient 201)");
        libraryQueue.addLast("Token T-02 (Patient 202)");
        libraryQueue.addLast("Token T-03 (Patient 203)");
        System.out.print("Library Queue (ArrayDeque): ");
        while (!libraryQueue.isEmpty()) {
            System.out.print(libraryQueue.removeFirst());
            if (!libraryQueue.isEmpty()) {
                System.out.print(" -> ");
            }
        }
        System.out.println();

        Deque<String> libraryStack = new ArrayDeque<>();
        libraryStack.push("Patient 201 (Cardiology)");
        libraryStack.push("Patient 202 (Orthopaedics)");
        libraryStack.push("Patient 203 (Neurology)");
        System.out.print("Library Stack (ArrayDeque): ");
        while (!libraryStack.isEmpty()) {
            System.out.print(libraryStack.pop());
            if (!libraryStack.isEmpty()) {
                System.out.print(" -> ");
            }
        }
        System.out.println();

        int operations = 200_000;
        long customStart = System.nanoTime();
        CustomQueue<Integer> customQueue = new CustomQueue<>();
        CustomStack<Integer> customStack = new CustomStack<>();
        for (int i = 0; i < operations; i++) {
            customQueue.enqueue(i);
            customStack.push(i);
        }
        for (int i = 0; i < operations; i++) {
            customQueue.dequeue();
            customStack.pop();
        }
        long customNs = System.nanoTime() - customStart;

        long libraryStart = System.nanoTime();
        Deque<Integer> queue = new ArrayDeque<>();
        Deque<Integer> stack = new ArrayDeque<>();
        for (int i = 0; i < operations; i++) {
            queue.addLast(i);
            stack.push(i);
        }
        for (int i = 0; i < operations; i++) {
            queue.removeFirst();
            stack.pop();
        }
        long libraryNs = System.nanoTime() - libraryStart;

        System.out.println(String.format(Locale.US,
                "200,000 operations -> Custom: %.2f ms | ArrayDeque: %.2f ms",
                customNs / 1_000_000.0, libraryNs / 1_000_000.0));
        System.out.println("Both implementations provide O(1) amortized operations.");
    }
}
