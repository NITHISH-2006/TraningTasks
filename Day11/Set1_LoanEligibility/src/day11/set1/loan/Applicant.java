package day11.set1.loan;

record Applicant(
        String id,
        int age,
        double monthlyIncome,
        int creditScore,
        String employmentType,
        double existingEmi,
        double requestedAmount,
        int termMonths
) {}
