# Normalisation - Hospital Patient Records (Set 3)

## Original wide sheet
`(patient, address, doctor, department, visit date, diagnosis, prescription, bill amount)`

## Step-by-step decomposition
1. **1NF:** Ensure atomic values (single diagnosis/prescription per row or normalized further; here treated as visit-level attributes), unique visit rows identified.
2. **Identify dependencies:** patient -> address/phone/dob; doctor -> department; (patient, doctor, visit_date, ...) -> diagnosis/prescription; visit -> bill_amount/status.
3. **2NF:** Separate repeating patient and doctor/department details from visit facts.
4. **3NF:** Remove transitive dependencies: `doctor` determines `department` so move department to `departments` and reference from `doctors`; move patient demographics to `patients`; keep visit facts in `visits`; move billing facts to `billing` (1:1 with visit) to isolate financial/status attributes.

## Final tables
- `departments(department_id PK, dept_name UNIQUE)`
- `doctors(doctor_id PK, doctor_name, department_id FK, phone)`
- `patients(patient_id PK, full_name, address, phone, dob)`
- `visits(visit_id PK, patient_id FK, doctor_id FK, visit_date, diagnosis, prescription, CHECK valid date range)`
- `billing(bill_id PK, visit_id FK UNIQUE, bill_amount, bill_status DEFAULT 'OPEN', CHECK amount>=0)`
