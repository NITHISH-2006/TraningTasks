package day11.set2.billing;

record Bill(
        ConsumerCategory category,
        int units,
        double energyCharges,
        double fixedCharge,
        double surcharge,
        double rebate,
        double totalPayable
) {}
