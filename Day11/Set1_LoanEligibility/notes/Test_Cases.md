# Test Cases - Day 11 Set 1

Daily approval limit: **3**. The first three valid applicants are approved; later valid records are reported as `NOT_PROCESSED` to show that `break` stopped the batch.

| ID | Age | Income | Score | Employment | Existing EMI | Amount | Term | Expected verdict |
|---|---:|---:|---:|---|---:|---:|---:|---|
| L001 | -5 | 80000 | 780 | SALARIED | 0 | 300000 | 36 | `INVALID` - negative age edge case, skipped with `continue` |
| L002 | 35 | 0 | 720 | SALARIED | 0 | 200000 | 24 | `INVALID` - zero income edge case, skipped with `continue` |
| L003 | 42 | 90000 | 950 | BUSINESS | 5000 | 400000 | 36 | `INVALID` - score out of 300-900 range |
| L004 | 30 | 80000 | 790 | SALARIED | 10000 | 300000 | 36 | `APPROVED` - Excellent band, 8.50%, Prime Personal |
| L005 | 45 | 60000 | 710 | BUSINESS | 8000 | 200000 | 24 | `APPROVED` - Good band, 10.25%, Standard Personal |
| L006 | 28 | 100000 | 650 | SELF_EMPLOYED | 5000 | 500000 | 60 | `APPROVED` - Fair band with long term, 14.25%, Care Extended |
| L007 | 33 | 75000 | 680 | SALARIED | 2000 | 250000 | 36 | `NOT_PROCESSED` - daily limit reached |
| L008 | 62 | 95000 | 820 | SALARIED | 1000 | 100000 | 12 | `NOT_PROCESSED` - also outside age band if evaluated |
| L009 | 27 | 55000 | 590 | UNEMPLOYED | 0 | 150000 | 24 | `NOT_PROCESSED` - would fail credit/employment rules |
| L010 | 31 | 70000 | 740 | SALARIED | 26000 | 350000 | 48 | `NOT_PROCESSED` - existing EMI above 30% of income |

## Rule coverage

1. Age band 21-60 (inclusive) - `finalDecision`
2. Income-to-EMI ratio - EMI must be at most 40% of monthly income
3. Credit-score band - sealed `CreditBand` from score, Poor gets no offer
4. Employment type - only SALARIED, SELF_EMPLOYED and BUSINESS
5. Existing-loan limit - existing EMI at most 30% of income
6. Final decision - `APPROVED` only when all previous rules pass

`var` is used for the applicant list, band, terms, EMI and verdict. `printf` prints the aligned decision table. The enhanced pattern-matching `switch` in `termsFor` maps the sealed credit-band records to rate/product pairs.
