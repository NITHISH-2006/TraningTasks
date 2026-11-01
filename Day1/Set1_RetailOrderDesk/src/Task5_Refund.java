import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Task5_Refund {

    static class Result {
        final int coinCount;
        final int[] usedCoins;

        Result(int coinCount, int[] usedCoins) {
            this.coinCount = coinCount;
            this.usedCoins = usedCoins;
        }
    }

    public static void main(String[] args) {
        int[] inrDenominations = {2000, 500, 200, 100, 50, 20, 10, 5, 2, 1};
        int[] trickyDenominations = {4, 3, 1};

        System.out.println("--- Task 5: Refund (Greedy vs Dynamic Programming) ---");
        compare(inrDenominations, 2788);
        compare(trickyDenominations, 6);
    }

    static void compare(int[] denominations, int amount) {
        Result greedy = greedy(denominations, amount);
        Result dynamic = dp(denominations, amount);

        System.out.println("Target " + amount + " (Coins: " + Arrays.toString(denominations) + ")");
        System.out.println("  Greedy -> " + greedy.coinCount + " coins " + describeByCoin(denominations, greedy));
        System.out.println("  DP     -> " + dynamic.coinCount + " coins " + describeByCoin(denominations, dynamic));
        if (greedy.coinCount != dynamic.coinCount) {
            System.out.println("  Greedy is NOT optimal for this denomination set; DP finds the minimum.");
        }
    }

    static Result greedy(int[] denominations, int amount) {
        int remaining = amount;
        List<Integer> used = new ArrayList<>();
        for (int coin : denominations) {
            while (remaining >= coin) {
                remaining -= coin;
                used.add(coin);
            }
        }
        if (remaining != 0) {
            throw new IllegalArgumentException("Amount cannot be formed with the given denominations");
        }
        return new Result(used.size(), toArray(used));
    }

    static Result dp(int[] denominations, int amount) {
        int unreachable = Integer.MAX_VALUE / 2;
        int[] minCoins = new int[amount + 1];
        int[] choice = new int[amount + 1];
        Arrays.fill(minCoins, unreachable);
        Arrays.fill(choice, -1);
        minCoins[0] = 0;

        for (int current = 1; current <= amount; current++) {
            for (int coin : denominations) {
                if (coin <= current && minCoins[current - coin] + 1 < minCoins[current]) {
                    minCoins[current] = minCoins[current - coin] + 1;
                    choice[current] = coin;
                }
            }
        }

        if (minCoins[amount] >= unreachable) {
            throw new IllegalArgumentException("Amount cannot be formed with the given denominations");
        }

        List<Integer> used = new ArrayList<>();
        int current = amount;
        while (current > 0) {
            int coin = choice[current];
            used.add(coin);
            current -= coin;
        }
        return new Result(minCoins[amount], toArray(used));
    }

    static String describeByCoin(int[] denominations, Result result) {
        List<String> parts = new ArrayList<>();
        int[] counts = new int[denominations.length];
        for (int used : result.usedCoins) {
            for (int i = 0; i < denominations.length; i++) {
                if (denominations[i] == used) {
                    counts[i]++;
                    break;
                }
            }
        }
        for (int i = 0; i < denominations.length; i++) {
            if (counts[i] > 0) {
                parts.add(denominations[i] + "x" + counts[i]);
            }
        }
        return "(" + String.join(", ", parts) + ")";
    }

    static int[] toArray(List<Integer> values) {
        int[] array = new int[values.size()];
        for (int i = 0; i < values.size(); i++) {
            array[i] = values.get(i);
        }
        return array;
    }
}
