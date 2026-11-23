package day11.set1.loan;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Set;

public class LoanEligibilityApp {

    private static final int DAILY_APPROVAL_LIMIT = 3;
    private static final Set<String> ALLOWED_EMPLOYMENT = Set.of("SALARIED", "SELF_EMPLOYED", "BUSINESS");

    public static void main(String[] args) {
        var applicants = List.of(
                new Applicant("L001", -5, 80000, 780, "SALARIED", 0, 300000, 36),
                new Applicant("L002", 35, 0, 720, "SALARIED", 0, 200000, 24),
                new Applicant("L003", 42, 90000, 950, "BUSINESS", 5000, 400000, 36),
                new Applicant("L004", 30, 80000, 790, "SALARIED", 10000, 300000, 36),
                new Applicant("L005", 45, 60000, 710, "BUSINESS", 8000, 200000, 24),
                new Applicant("L006", 28, 100000, 650, "SELF_EMPLOYED", 5000, 500000, 60),
                new Applicant("L007", 33, 75000, 680, "SALARIED", 2000, 250000, 36),
                new Applicant("L008", 62, 95000, 820, "SALARIED", 1000, 100000, 12),
                new Applicant("L009", 27, 55000, 590, "UNEMPLOYED", 0, 150000, 24),
                new Applicant("L010", 31, 70000, 740, "SALARIED", 26000, 350000, 48)
        );

        var decisions = new ArrayList<LoanDecision>();
        var approvals = 0;

        for (var applicant : applicants) {
            var issue = validate(applicant);
            if (issue != null) {
                decisions.add(new LoanDecision(applicant.id(), "INVALID", issue, 0, 0, "-"));
                continue;
            }

            var band = CreditBand.fromScore(applicant.creditScore());
            var terms = termsFor(band, applicant.termMonths());
            var emi = monthlyEmi(applicant.requestedAmount(), terms.interestRatePct(), applicant.termMonths());
            var verdict = finalDecision(applicant, terms, emi);

            decisions.add(new LoanDecision(
                    applicant.id(), verdict.status(), verdict.reason(), emi, terms.interestRatePct(), terms.product()
            ));

            if ("APPROVED".equals(verdict.status())) {
                approvals++;
                if (approvals == DAILY_APPROVAL_LIMIT) {
                    break;
                }
            }
        }

        for (var applicant : applicants) {
            var alreadyReported = decisions.stream()
                    .anyMatch(decision -> decision.applicantId().equals(applicant.id()));
            if (!alreadyReported) {
                decisions.add(new LoanDecision(
                        applicant.id(), "NOT_PROCESSED", "Daily approval limit reached", 0, 0, "-"
                ));
            }
        }

        System.out.println("DAY 11 SET 1 - LOAN ELIGIBILITY DECISION TABLE");
        System.out.printf(Locale.US,
                "%-8s %-14s %-42s %12s %10s %-18s%n",
                "ID", "VERDICT", "REASON", "EMI", "RATE %", "PRODUCT");
        System.out.println("-".repeat(110));
        for (var decision : decisions) {
            System.out.printf(Locale.US,
                    "%-8s %-14s %-42s %12.2f %10.2f %-18s%n",
                    decision.applicantId(), decision.verdict(), decision.reason(),
                    decision.emi(), decision.interestRatePct(), decision.product());
        }
        System.out.printf(Locale.US, "%nApprovals: %d/%d%n", approvals, DAILY_APPROVAL_LIMIT);
    }

    private static String validate(Applicant applicant) {
        if (applicant.age() < 0 || applicant.age() > 100) {
            return "Age must be between 0 and 100";
        }
        if (applicant.monthlyIncome() <= 0) {
            return "Income must be positive";
        }
        if (applicant.creditScore() < 300 || applicant.creditScore() > 900) {
            return "Credit score out of range";
        }
        if (applicant.requestedAmount() <= 0 || applicant.termMonths() <= 0) {
            return "Amount and term must be positive";
        }
        if (applicant.existingEmi() < 0) {
            return "Existing EMI cannot be negative";
        }
        return null;
    }

    private static LoanTerms termsFor(CreditBand band, int termMonths) {
        return switch (band) {
            case CreditBand.Excellent excellent -> new LoanTerms(8.50, "Prime Personal");
            case CreditBand.Good good when termMonths <= 36 -> new LoanTerms(10.25, "Standard Personal");
            case CreditBand.Good good -> new LoanTerms(11.00, "Extended Personal");
            case CreditBand.Fair fair when termMonths <= 24 -> new LoanTerms(13.50, "Care Personal");
            case CreditBand.Fair fair -> new LoanTerms(14.25, "Care Extended");
            case CreditBand.Poor poor -> new LoanTerms(0.00, "Not Offered");
        };
    }

    private static Verdict finalDecision(Applicant applicant, LoanTerms terms, double emi) {
        if (applicant.age() < 21 || applicant.age() > 60) {
            return new Verdict("REJECTED", "Rule 1: age outside 21-60");
        }
        if (emi > applicant.monthlyIncome() * 0.40) {
            return new Verdict("REJECTED", "Rule 2: EMI above 40% income");
        }
        if (terms.interestRatePct() <= 0) {
            return new Verdict("REJECTED", "Rule 3: credit band not eligible");
        }
        if (!ALLOWED_EMPLOYMENT.contains(applicant.employmentType())) {
            return new Verdict("REJECTED", "Rule 4: employment type not accepted");
        }
        if (applicant.existingEmi() > applicant.monthlyIncome() * 0.30) {
            return new Verdict("REJECTED", "Rule 5: existing loans above 30% income");
        }
        return new Verdict("APPROVED", "Rule 6: all rules satisfied");
    }

    private static double monthlyEmi(double principal, double annualRatePct, int termMonths) {
        var monthlyRate = annualRatePct / 1200.0;
        if (monthlyRate == 0) {
            return principal / termMonths;
        }
        var factor = Math.pow(1 + monthlyRate, termMonths);
        return principal * monthlyRate * factor / (factor - 1);
    }

    private record Verdict(String status, String reason) {}
}
