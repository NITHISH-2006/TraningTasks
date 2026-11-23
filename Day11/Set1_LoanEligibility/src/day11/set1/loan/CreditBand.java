package day11.set1.loan;

sealed interface CreditBand permits CreditBand.Excellent, CreditBand.Good, CreditBand.Fair, CreditBand.Poor {

    record Excellent() implements CreditBand {}

    record Good() implements CreditBand {}

    record Fair() implements CreditBand {}

    record Poor() implements CreditBand {}

    static CreditBand fromScore(int score) {
        if (score >= 780) {
            return new Excellent();
        }
        if (score >= 700) {
            return new Good();
        }
        if (score >= 600) {
            return new Fair();
        }
        return new Poor();
    }
}
