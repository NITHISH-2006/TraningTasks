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

    static class HubNetwork {
        private final Map<String, List<String>> adjacency = new LinkedHashMap<>();

        void addHub(String hub) {
            adjacency.computeIfAbsent(hub, key -> new ArrayList<>());
        }

        void addRoute(String first, String second) {
            addHub(first);
            addHub(second);
            adjacency.get(first).add(second);
            adjacency.get(second).add(first);
        }

        List<String> routesFrom(String hub) {
            return adjacency.getOrDefault(hub, Collections.emptyList());
        }

        Set<String> hubs() {
            return new LinkedHashSet<>(adjacency.keySet());
        }

        List<String> fewestHops(String source, String destination) {
            Map<String, String> previous = new HashMap<>();
            Set<String> visited = new LinkedHashSet<>();
            Deque<String> queue = new ArrayDeque<>();

            visited.add(source);
            queue.addLast(source);
            while (!queue.isEmpty()) {
                String current = queue.removeFirst();
                if (current.equals(destination)) {
                    break;
                }
                for (String next : routesFrom(current)) {
                    if (visited.add(next)) {
                        previous.put(next, current);
                        queue.addLast(next);
                    }
                }
            }

            if (!visited.contains(destination)) {
                return Collections.emptyList();
            }

            List<String> path = new ArrayList<>();
            for (String step = destination; step != null; step = previous.get(step)) {
                path.add(step);
            }
            Collections.reverse(path);
            return path;
        }

        List<String> reachableFrom(String source) {
            Set<String> visited = new LinkedHashSet<>();
            dfs(source, visited);
            return new ArrayList<>(visited);
        }

        private void dfs(String hub, Set<String> visited) {
            if (!visited.add(hub)) {
                return;
            }
            for (String next : routesFrom(hub)) {
                dfs(next, visited);
            }
        }
    }

    public static void main(String[] args) {
        HubNetwork network = buildNetwork();
        List<String> path = network.fewestHops("HUB-DEL", "HUB-CCU");
        List<String> reachable = network.reachableFrom("HUB-DEL");

        System.out.println("--- Task 3: Hub Network (Adjacency List) ---");
        for (String hub : network.hubs()) {
            System.out.println(hub + " -> " + network.routesFrom(hub));
        }
        System.out.println("Fewest hops HUB-DEL -> HUB-CCU (" + Math.max(0, path.size() - 1) + " hops): " + path);
        System.out.println("Reachable from central depot HUB-DEL (DFS): " + reachable);
        System.out.println("Hubs reachable: " + reachable.size() + " of " + network.hubs().size());
    }

    static HubNetwork buildNetwork() {
        HubNetwork network = new HubNetwork();
        network.addRoute("HUB-DEL", "HUB-BOM");
        network.addRoute("HUB-DEL", "HUB-JAI");
        network.addRoute("HUB-DEL", "HUB-AMD");
        network.addRoute("HUB-BOM", "HUB-PNQ");
        network.addRoute("HUB-BOM", "HUB-BLR");
        network.addRoute("HUB-BLR", "HUB-MAA");
        network.addRoute("HUB-BLR", "HUB-HYD");
        network.addRoute("HUB-MAA", "HUB-KOC");
        network.addRoute("HUB-HYD", "HUB-CCU");
        return network;
    }
}
