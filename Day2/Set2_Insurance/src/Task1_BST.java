import java.util.ArrayList;
import java.util.List;

public class Task1_BST {

    static class Node {
        final int claimId;
        Node left;
        Node right;

        Node(int claimId) {
            this.claimId = claimId;
        }
    }

    static class ClaimTree {
        private Node root;

        void insert(int claimId) {
            root = insert(root, claimId);
        }

        private Node insert(Node node, int claimId) {
            if (node == null) {
                return new Node(claimId);
            }
            if (claimId < node.claimId) {
                node.left = insert(node.left, claimId);
            } else if (claimId > node.claimId) {
                node.right = insert(node.right, claimId);
            }
            return node;
        }

        boolean search(int claimId) {
            Node current = root;
            while (current != null) {
                if (claimId == current.claimId) {
                    return true;
                }
                current = claimId < current.claimId ? current.left : current.right;
            }
            return false;
        }

        List<Integer> inorder() {
            List<Integer> result = new ArrayList<>();
            inorder(root, result);
            return result;
        }

        private void inorder(Node node, List<Integer> result) {
            if (node == null) {
                return;
            }
            inorder(node.left, result);
            result.add(node.claimId);
            inorder(node.right, result);
        }

        List<Integer> preorder() {
            List<Integer> result = new ArrayList<>();
            preorder(root, result);
            return result;
        }

        private void preorder(Node node, List<Integer> result) {
            if (node == null) {
                return;
            }
            result.add(node.claimId);
            preorder(node.left, result);
            preorder(node.right, result);
        }

        List<Integer> postorder() {
            List<Integer> result = new ArrayList<>();
            postorder(root, result);
            return result;
        }

        private void postorder(Node node, List<Integer> result) {
            if (node == null) {
                return;
            }
            postorder(node.left, result);
            postorder(node.right, result);
            result.add(node.claimId);
        }
    }

    public static void main(String[] args) {
        int[] claimIds = {5402, 1187, 8830, 3245, 6719, 2098, 7456, 4321, 9903, 1560, 5874, 8121, 2650, 7038, 4685};

        ClaimTree tree = new ClaimTree();
        for (int claimId : claimIds) {
            tree.insert(claimId);
        }

        System.out.println("--- Task 1: Claim ID BST ---");
        System.out.println("Claims inserted: " + claimIds.length);
        System.out.println("Inorder   : " + tree.inorder());
        System.out.println("Preorder  : " + tree.preorder());
        System.out.println("Postorder : " + tree.postorder());
        System.out.println("Search claim 7456: " + tree.search(7456));
        System.out.println("Search claim 9999: " + tree.search(9999));
        System.out.println("Inorder traversal gives claim IDs in ascending sorted order.");
    }
}
