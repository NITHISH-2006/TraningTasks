import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Deque;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class Task3_Graph {

    static class ServiceGraph {
        private final Map<String, List<String>> dependsOn = new LinkedHashMap<>();

        void addService(String service) {
            dependsOn.computeIfAbsent(service, key -> new ArrayList<>());
        }

        void addDependency(String service, String dependency) {
            addService(service);
            addService(dependency);
            dependsOn.get(service).add(dependency);
        }

        List<String> dependenciesOf(String service) {
            return dependsOn.getOrDefault(service, Collections.emptyList());
        }

        Set<String> nodes() {
            return new LinkedHashSet<>(dependsOn.keySet());
        }

        List<String> deploymentOrderDfs() {
            Set<String> visited = new LinkedHashSet<>();
            List<String> order = new ArrayList<>();
            for (String node : nodes()) {
                dfsPostOrder(node, visited, order);
            }
            return order;
        }

        private void dfsPostOrder(String node, Set<String> visited, List<String> order) {
            if (!visited.add(node)) {
                return;
            }
            for (String dependency : dependenciesOf(node)) {
                dfsPostOrder(dependency, visited, order);
            }
            order.add(node);
        }

        List<String> deploymentOrderBfs() {
            Map<String, Integer> dependencyCount = new HashMap<>();
            Map<String, List<String>> dependents = new HashMap<>();
            for (String node : nodes()) {
                dependencyCount.put(node, dependenciesOf(node).size());
                dependents.computeIfAbsent(node, key -> new ArrayList<>());
            }
            for (String node : nodes()) {
                for (String dependency : dependenciesOf(node)) {
                    dependents.get(dependency).add(node);
                }
            }

            Deque<String> ready = new ArrayDeque<>();
            for (String node : nodes()) {
                if (dependencyCount.get(node) == 0) {
                    ready.addLast(node);
                }
            }

            List<String> order = new ArrayList<>();
            while (!ready.isEmpty()) {
                String current = ready.removeFirst();
                order.add(current);
                for (String dependent : dependents.getOrDefault(current, Collections.emptyList())) {
                    int remaining = dependencyCount.merge(dependent, -1, Integer::sum);
                    if (remaining == 0) {
                        ready.addLast(dependent);
                    }
                }
            }

            if (order.size() != nodes().size()) {
                throw new IllegalStateException("Circular dependency detected; deployment order is incomplete");
            }
            return order;
        }

        boolean hasCycle() {
            Map<String, Integer> state = new HashMap<>();
            for (String node : nodes()) {
                if (detectCycle(node, state)) {
                    return true;
                }
            }
            return false;
        }

        private boolean detectCycle(String node, Map<String, Integer> state) {
            int currentState = state.getOrDefault(node, 0);
            if (currentState == 1) {
                return true;
            }
            if (currentState == 2) {
                return false;
            }

            state.put(node, 1);
            for (String dependency : dependenciesOf(node)) {
                if (detectCycle(dependency, state)) {
                    return true;
                }
            }
            state.put(node, 2);
            return false;
        }
    }

    public static void main(String[] args) {
        ServiceGraph graph = buildGraph();

        System.out.println("--- Task 3: Microservice Dependency Graph ---");
        for (String service : graph.nodes()) {
            System.out.println(service + " depends on " + graph.dependenciesOf(service));
        }
        System.out.println("Deployment order (DFS post-order): " + graph.deploymentOrderDfs());
        System.out.println("Deployment order (BFS / Kahn)     : " + graph.deploymentOrderBfs());
        System.out.println("Original graph has cycle: " + graph.hasCycle());

        ServiceGraph cyclic = buildGraph();
        cyclic.addDependency("inventory", "checkout");
        System.out.println("After adding inventory -> checkout, cycle detected: " + cyclic.hasCycle());
    }

    static ServiceGraph buildGraph() {
        ServiceGraph graph = new ServiceGraph();
        graph.addDependency("frontend", "checkout");
        graph.addDependency("frontend", "auth");
        graph.addDependency("checkout", "cart");
        graph.addDependency("checkout", "pricing");
        graph.addDependency("checkout", "payment");
        graph.addDependency("cart", "inventory");
        graph.addDependency("pricing", "inventory");
        graph.addDependency("payment", "inventory");
        graph.addDependency("payment", "auth");
        graph.addDependency("notification", "checkout");
        graph.addService("inventory");
        graph.addService("auth");
        return graph;
    }
}
