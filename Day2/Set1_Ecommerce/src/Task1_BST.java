import java.util.ArrayList;
import java.util.List;

public class Task1_BST {

    static class Node {
        final String key;
        Node left;
        Node right;

        Node(String key) {
            this.key = key;
        }
    }

    static class BinarySearchTree {
        private Node root;

        void insert(String key) {
            root = insert(root, key);
        }

        private Node insert(Node node, String key) {
            if (node == null) {
                return new Node(key);
            }
            int comparison = key.compareTo(node.key);
            if (comparison < 0) {
                node.left = insert(node.left, key);
            } else if (comparison > 0) {
                node.right = insert(node.right, key);
            }
            return node;
        }

        boolean search(String key) {
            Node current = root;
            while (current != null) {
                int comparison = key.compareTo(current.key);
                if (comparison == 0) {
                    return true;
                }
                current = comparison < 0 ? current.left : current.right;
            }
            return false;
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
            result.add(node.key);
            inorder(node.right, result);
        }

        List<String> preorder() {
            List<String> result = new ArrayList<>();
            preorder(root, result);
            return result;
        }

        private void preorder(Node node, List<String> result) {
            if (node == null) {
                return;
            }
            result.add(node.key);
            preorder(node.left, result);
            preorder(node.right, result);
        }

        List<String> postorder() {
            List<String> result = new ArrayList<>();
            postorder(root, result);
            return result;
        }

        private void postorder(Node node, List<String> result) {
            if (node == null) {
                return;
            }
            postorder(node.left, result);
            postorder(node.right, result);
            result.add(node.key);
        }
    }

    public static void main(String[] args) {
        String[] categories = {
                "Electronics", "Fashion", "Home", "Books", "Sports",
                "Beauty", "Toys", "Grocery", "Automotive", "Garden",
                "Appliances", "Furniture", "Jewellery", "Pets", "Office"
        };

        BinarySearchTree tree = new BinarySearchTree();
        for (String category : categories) {
            tree.insert(category);
        }

        System.out.println("--- Task 1: Product Category BST ---");
        System.out.println("Categories inserted: " + categories.length);
        System.out.println("Inorder   : " + tree.inorder());
        System.out.println("Preorder  : " + tree.preorder());
        System.out.println("Postorder : " + tree.postorder());
        System.out.println("Search 'Grocery': " + tree.search("Grocery"));
        System.out.println("Search 'Music'  : " + tree.search("Music"));
        System.out.println("Inorder traversal yields categories in sorted (alphabetical) order.");
    }
}
