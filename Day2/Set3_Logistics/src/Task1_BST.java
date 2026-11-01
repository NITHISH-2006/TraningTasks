import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Task1_BST {

    static class Node {
        final String hubCode;
        Node left;
        Node right;

        Node(String hubCode) {
            this.hubCode = hubCode;
        }
    }

    static class HubTree {
        private Node root;

        void insert(String hubCode) {
            root = insert(root, hubCode);
        }

        private Node insert(Node node, String hubCode) {
            if (node == null) {
                return new Node(hubCode);
            }
            int comparison = hubCode.compareTo(node.hubCode);
            if (comparison < 0) {
                node.left = insert(node.left, hubCode);
            } else if (comparison > 0) {
                node.right = insert(node.right, hubCode);
            }
            return node;
        }

        boolean search(String hubCode) {
            Node current = root;
            while (current != null) {
                int comparison = hubCode.compareTo(current.hubCode);
                if (comparison == 0) {
                    return true;
                }
                current = comparison < 0 ? current.left : current.right;
            }
            return false;
        }

        int height() {
            return height(root);
        }

        private int height(Node node) {
            if (node == null) {
                return -1;
            }
            return 1 + Math.max(height(node.left), height(node.right));
        }

        List<String> inorder() {
            List<String> result = new ArrayList<>();
            inorder(root, result);
            return result;
        }

        private void inorder(Node node, List<String> result) {
            if (node == null) {
                return;
            }
            inorder(node.left, result);
            result.add(node.hubCode);
            inorder(node.right, result);
        }
    }

    public static void main(String[] args) {
        String[] balancedOrder = {
                "HUB-DEL", "HUB-BOM", "HUB-BLR", "HUB-MAA", "HUB-HYD",
                "HUB-CCU", "HUB-PNQ", "HUB-AMD", "HUB-KOC", "HUB-JAI"
        };
        String[] sortedOrder = {
                "HUB-AMD", "HUB-BLR", "HUB-BOM", "HUB-CCU", "HUB-DEL",
                "HUB-HYD", "HUB-JAI", "HUB-KOC", "HUB-MAA", "HUB-PNQ"
        };

        HubTree mixedTree = new HubTree();
        for (String hub : balancedOrder) {
            mixedTree.insert(hub);
        }

        HubTree sortedTree = new HubTree();
        for (String hub : sortedOrder) {
            sortedTree.insert(hub);
        }

        System.out.println("--- Task 1: Hub-Code BST ---");
        System.out.println("Mixed insertion order : " + Arrays.toString(balancedOrder));
        System.out.println("  Height (edges): " + mixedTree.height()
                + " | Levels: " + (mixedTree.height() + 1));
        System.out.println("  Inorder: " + mixedTree.inorder());
        System.out.println("  Search HUB-HYD: " + mixedTree.search("HUB-HYD")
                + " | Search HUB-XXX: " + mixedTree.search("HUB-XXX"));
        System.out.println("Sorted insertion order: " + Arrays.toString(sortedOrder));
        System.out.println("  Height (edges): " + sortedTree.height()
                + " | Levels: " + (sortedTree.height() + 1));
        System.out.println("Sorted input degenerates the BST into a linked list, so search becomes O(n).");
    }
}
