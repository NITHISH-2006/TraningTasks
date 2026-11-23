package day11.set1.loan;

record LoanTerms(double interestRatePct, String product) {}

record LoanDecision(
        String applicantId,
        String verdict,
        String reason,
        double emi,
        double interestRatePct,
        String product
) {}
