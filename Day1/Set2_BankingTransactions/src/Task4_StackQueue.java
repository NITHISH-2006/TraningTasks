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
        System.out.println("--- Task 4: Manual-Review Queue & Adjustment Stack ---");

        CustomQueue<String> reviewBacklog = new CustomQueue<>();
        reviewBacklog.enqueue("CASE-201 (Fraud review)");
        reviewBacklog.enqueue("CASE-202 (Limit increase)");
        reviewBacklog.enqueue("CASE-203 (Chargeback)");

        System.out.print("Manual-review Queue: ");
        while (!reviewBacklog.isEmpty()) {
            System.out.print("Reviewed " + reviewBacklog.dequeue());
            if (!reviewBacklog.isEmpty()) {
                System.out.print(" -> ");
            }
        }
        System.out.println();

        CustomStack<String> adjustments = new CustomStack<>();
        adjustments.push("Fee Reversal +25.00");
        adjustments.push("Interest Credit +4.20");
        adjustments.push("Cashback +12.50");

        System.out.print("Adjustment Stack: ");
        while (!adjustments.isEmpty()) {
            System.out.print("Reversed '" + adjustments.pop() + "'");
            if (!adjustments.isEmpty()) {
                System.out.print(", ");
            }
        }
        System.out.println();

        Deque<String> libraryQueue = new ArrayDeque<>();
        libraryQueue.addLast("CASE-201 (Fraud review)");
        libraryQueue.addLast("CASE-202 (Limit increase)");
        libraryQueue.addLast("CASE-203 (Chargeback)");
        System.out.print("Library Queue (ArrayDeque): ");
        while (!libraryQueue.isEmpty()) {
            System.out.print("Reviewed " + libraryQueue.removeFirst());
            if (!libraryQueue.isEmpty()) {
                System.out.print(" -> ");
            }
        }
        System.out.println();

        Deque<String> libraryStack = new ArrayDeque<>();
        libraryStack.push("Fee Reversal +25.00");
        libraryStack.push("Interest Credit +4.20");
        libraryStack.push("Cashback +12.50");
        System.out.print("Library Stack (ArrayDeque): ");
        while (!libraryStack.isEmpty()) {
            System.out.print("Reversed '" + libraryStack.pop() + "'");
            if (!libraryStack.isEmpty()) {
                System.out.print(", ");
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
        System.out.println("Both implementations provide O(1) amortized enqueue/dequeue and push/pop.");
    }
}
