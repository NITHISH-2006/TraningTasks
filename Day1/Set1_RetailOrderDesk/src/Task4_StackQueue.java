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

    public static void main(String[] args) {
        System.out.println("--- Task 4: Stack & Queue ---");

        CustomStack<String> undoStack = new CustomStack<>();
        undoStack.push("Apply Promo");
        undoStack.push("Address Change");
        undoStack.push("Change Quantity");

        System.out.print("Stack (Undo): ");
        while (!undoStack.isEmpty()) {
            System.out.print("Reverted '" + undoStack.pop() + "'");
            if (!undoStack.isEmpty()) {
                System.out.print(", ");
            }
        }
        System.out.println();

        CustomQueue<Integer> dispatchQueue = new CustomQueue<>();
        for (int orderId = 101; orderId <= 105; orderId++) {
            dispatchQueue.enqueue(orderId);
        }

        System.out.print("Queue (Dispatch): ");
        while (!dispatchQueue.isEmpty()) {
            System.out.print("Order #" + dispatchQueue.dequeue() + " Processed");
            if (!dispatchQueue.isEmpty()) {
                System.out.print(", ");
            }
        }
        System.out.println();

        Deque<String> builtInStack = new ArrayDeque<>();
        builtInStack.push("Apply Promo");
        builtInStack.push("Address Change");
        builtInStack.push("Change Quantity");
        System.out.print("Library Stack (ArrayDeque): ");
        while (!builtInStack.isEmpty()) {
            System.out.print("Reverted '" + builtInStack.pop() + "'");
            if (!builtInStack.isEmpty()) {
                System.out.print(", ");
            }
        }
        System.out.println();

        Deque<Integer> builtInQueue = new ArrayDeque<>();
        for (int orderId = 101; orderId <= 105; orderId++) {
            builtInQueue.addLast(orderId);
        }
        System.out.print("Library Queue (ArrayDeque): ");
        while (!builtInQueue.isEmpty()) {
            System.out.print("Order #" + builtInQueue.removeFirst() + " Processed");
            if (!builtInQueue.isEmpty()) {
                System.out.print(", ");
            }
        }
        System.out.println();

        int operations = 200_000;
        long customStart = System.nanoTime();
        CustomStack<Integer> customStack = new CustomStack<>();
        CustomQueue<Integer> customQueue = new CustomQueue<>();
        for (int i = 0; i < operations; i++) {
            customStack.push(i);
            customQueue.enqueue(i);
        }
        for (int i = 0; i < operations; i++) {
            customStack.pop();
            customQueue.dequeue();
        }
        long customNs = System.nanoTime() - customStart;

        long builtInStart = System.nanoTime();
        Deque<Integer> libraryStack = new ArrayDeque<>();
        Deque<Integer> libraryQueue = new ArrayDeque<>();
        for (int i = 0; i < operations; i++) {
            libraryStack.push(i);
            libraryQueue.addLast(i);
        }
        for (int i = 0; i < operations; i++) {
            libraryStack.pop();
            libraryQueue.removeFirst();
        }
        long builtInNs = System.nanoTime() - builtInStart;

        System.out.println(String.format(Locale.US,
                "200,000 push/pop + enqueue/dequeue -> Custom: %.2f ms | ArrayDeque: %.2f ms",
                customNs / 1_000_000.0, builtInNs / 1_000_000.0));
        System.out.println("All custom and library operations are O(1) per operation.");
    }
}
