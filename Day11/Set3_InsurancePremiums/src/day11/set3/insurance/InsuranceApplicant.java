package day11.set3.insurance;

record InsuranceApplicant(
        String id,
        String name,
        int age,
        boolean smoker,
        double heightMeters,
        double weightKg,
        int termYears
) {}

record BmiInfo(String category, int loadingPct) {}

record PremiumResult(
        String id,
        String name,
        double bmi,
        String bmiCategory,
        int loadingPct,
        double basePremium,
        double finalPremium,
        String status,
        String reason
) {}
