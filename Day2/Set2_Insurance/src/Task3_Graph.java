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

    static class StageGraph {
        private final Map<String, List<String>> adjacency = new LinkedHashMap<>();

        void addStage(String stage) {
            adjacency.computeIfAbsent(stage, key -> new ArrayList<>());
        }

        void addEdge(String from, String to) {
            addStage(from);
            addStage(to);
            adjacency.get(from).add(to);
        }

        List<String> neighbours(String stage) {
            return adjacency.getOrDefault(stage, Collections.emptyList());
        }

        Set<String> stages() {
            return new LinkedHashSet<>(adjacency.keySet());
        }

        List<String> shortestPathBfs(String source, String destination) {
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
                for (String next : neighbours(current)) {
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

        boolean hasLoop() {
            Map<String, Integer> state = new HashMap<>();
            for (String stage : stages()) {
                if (detectLoop(stage, state)) {
                    return true;
                }
            }
            return false;
        }

        private boolean detectLoop(String stage, Map<String, Integer> state) {
            int currentState = state.getOrDefault(stage, 0);
            if (currentState == 1) {
                return true;
            }
            if (currentState == 2) {
                return false;
            }

            state.put(stage, 1);
            for (String next : neighbours(stage)) {
                if (detectLoop(next, state)) {
                    return true;
                }
            }
            state.put(stage, 2);
            return false;
        }
    }

    public static void main(String[] args) {
        StageGraph graph = buildGraph();

        System.out.println("--- Task 3: Claim Approval Stage Graph ---");
        for (String stage : graph.stages()) {
            System.out.println(stage + " -> " + graph.neighbours(stage));
        }
        System.out.println("Shortest path registration -> settlement: "
                + graph.shortestPathBfs("registration", "settlement"));
        System.out.println("Original graph has loop: " + graph.hasLoop());

        StageGraph cyclic = buildGraph();
        cyclic.addEdge("archive", "assessment");
        System.out.println("After adding archive -> assessment, loop detected: " + cyclic.hasLoop());
    }

    static StageGraph buildGraph() {
        StageGraph graph = new StageGraph();
        graph.addEdge("registration", "assessment");
        graph.addEdge("assessment", "surveyor");
        graph.addEdge("assessment", "settlement");
        graph.addEdge("surveyor", "settlement");
        graph.addEdge("settlement", "payment");
        graph.addEdge("payment", "archive");
        return graph;
    }
}
