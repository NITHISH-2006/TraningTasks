package day11.set3.insurance;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

public class PremiumApp {

    public static void main(String[] args) {
        var applicants = List.of(
                new InsuranceApplicant("I001", "Anil", 29, false, 1.75, 70.0, 10),
                new InsuranceApplicant("I002", "Bina", 41, true, 1.60, 58.0, 20),
                new InsuranceApplicant("I003", "Chandra", 55, false, 1.80, 92.0, 15),
                new InsuranceApplicant("I004", "Deepa", 33, false, 1.65, 49.0, 25),
                new InsuranceApplicant("I005", "Eshan", 75, false, 1.70, 72.0, 10),
                new InsuranceApplicant("I006", "Farhan", 38, true, 1.78, 85.0, 12),
                new InsuranceApplicant("I007", "Gita", 62, false, 1.55, 60.0, 8),
                new InsuranceApplicant("I008", "Hari", 47, false, 1.72, 76.0, 30)
        );

        var results = new ArrayList<PremiumResult>();

        batchValidation:
        for (var applicant : applicants) {
            var bmi = calculateBmi(applicant.weightKg(), applicant.heightMeters());
            var bmiInfo = classifyBmi(bmi);

            if (!isEligible(applicant, bmi)) {
                results.add(new PremiumResult(
                        applicant.id(), applicant.name(), bmi, bmiInfo.category(), 0, 0, 0,
                        "INELIGIBLE", eligibilityReason(applicant, bmi)
                ));
                break batchValidation;
            }

            var band = AgeBand.fromAge(applicant.age());
            var basePremium = basePremium(band, applicant.termYears());
            var smokerLoading = applicant.smoker() ? 30 : 0;
            var totalLoading = bmiInfo.loadingPct() + smokerLoading;
            var finalPremium = Math.round(basePremium * (1 + totalLoading / 100.0) * 100.0) / 100.0;

            results.add(new PremiumResult(
                    applicant.id(), applicant.name(), bmi, bmiInfo.category(), totalLoading,
                    basePremium, finalPremium, "APPROVED", "All checks passed"
            ));
        }

        for (var applicant : applicants) {
            var alreadyReported = results.stream().anyMatch(result -> result.id().equals(applicant.id()));
            if (!alreadyReported) {
                results.add(new PremiumResult(
                        applicant.id(), applicant.name(), 0, "-", 0, 0, 0,
                        "NOT_VALIDATED", "Batch stopped at first ineligible applicant"
                ));
            }
        }

        System.out.println("DAY 11 SET 3 - INSURANCE PREMIUM BANDS");
        System.out.printf(Locale.US,
                "%-6s %-9s %7s %-13s %8s %12s %12s %-13s %s%n",
                "ID", "NAME", "BMI", "BMI CATEGORY", "LOADING", "BASE", "FINAL", "STATUS", "REASON");
        System.out.println("-".repeat(112));
        for (var result : results) {
            System.out.printf(Locale.US,
                    "%-6s %-9s %7.2f %-13s %7d%% %12.2f %12.2f %-13s %s%n",
                    result.id(), result.name(), result.bmi(), result.bmiCategory(), result.loadingPct(),
                    result.basePremium(), result.finalPremium(), result.status(), result.reason());
        }
    }

    private static double calculateBmi(double weightKg, double heightMeters) {
        return weightKg / (heightMeters * heightMeters);
    }

    private static BmiInfo classifyBmi(double bmi) {
        if (bmi < 18.5) {
            return new BmiInfo("UNDERWEIGHT", 25);
        } else {
            if (bmi < 25.0) {
                return new BmiInfo("NORMAL", 0);
            } else {
                if (bmi < 30.0) {
                    return new BmiInfo("OVERWEIGHT", 15);
                } else {
                    return new BmiInfo("OBESE", 35);
                }
            }
        }
    }

    private static double basePremium(AgeBand band, int termYears) {
        return switch (band) {
            case AgeBand.Young young when termYears <= 10 -> 3000.0;
            case AgeBand.Young young -> 3600.0;
            case AgeBand.Adult adult when termYears >= 20 -> 5200.0;
            case AgeBand.Adult adult -> 4500.0;
            case AgeBand.Senior senior when termYears <= 10 -> 7200.0;
            case AgeBand.Senior senior -> 8800.0;
        };
    }

    private static boolean isEligible(InsuranceApplicant applicant, double bmi) {
        return applicant.age() >= 18 && applicant.age() <= 70
                && bmi > 0 && bmi <= 45
                && applicant.termYears() >= 5 && applicant.termYears() <= 30;
    }

    private static String eligibilityReason(InsuranceApplicant applicant, double bmi) {
        if (applicant.age() < 18 || applicant.age() > 70) {
            return "Age outside 18-70";
        }
        if (bmi <= 0 || bmi > 45) {
            return "BMI outside accepted range";
        }
        return "Policy term outside 5-30 years";
    }
}
