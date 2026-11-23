package day11.set3.insurance;

sealed interface AgeBand permits AgeBand.Young, AgeBand.Adult, AgeBand.Senior {

    record Young() implements AgeBand {}

    record Adult() implements AgeBand {}

    record Senior() implements AgeBand {}

    static AgeBand fromAge(int age) {
        if (age < 35) {
            return new Young();
        }
        if (age < 60) {
            return new Adult();
        }
        return new Senior();
    }
}
