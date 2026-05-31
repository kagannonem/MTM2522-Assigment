-- ========================
-- 1. Doctors with their department and hospital
--    (INNER JOIN across 3 tables)
-- ========================
SELECT u.name AS doctor_name, d.specialty, dep.name AS department, h.name AS hospital
FROM doctors d
JOIN users u ON d.user_id = u.user_id
JOIN departments dep ON d.dept_id = dep.dept_id
JOIN hospitals h ON dep.hospital_id = h.hospital_id;

-- ========================
-- 2. Patients with no appointments
--    (LEFT JOIN + IS NULL)
-- ========================
SELECT u.name AS patient_name, p.medical_history
FROM patients p
JOIN users u ON p.user_id = u.user_id
LEFT JOIN appointments a ON p.patient_id = a.patient_id
WHERE a.appt_id IS NULL;

-- ========================
-- 3. Doctors with more than 1 appointment as attending
--    (GROUP BY + HAVING)
-- ========================
SELECT u.name AS doctor_name, COUNT(a.appt_id) AS total_appointments
FROM doctors d
JOIN users u ON d.user_id = u.user_id
JOIN appointments a ON d.doctor_id = a.attending_doctor_id
GROUP BY u.name
HAVING COUNT(a.appt_id) > 1
ORDER BY total_appointments DESC;

-- ========================
-- 4. Most prescribed medications
--    (GROUP BY + ORDER BY)
-- ========================
SELECT medication_name, COUNT(*) AS times_prescribed
FROM prescriptions
GROUP BY medication_name
ORDER BY times_prescribed DESC;

-- ========================
-- 5. Total revenue per hospital (covered vs not)
--    (JOIN + GROUP BY + SUM)
-- ========================
SELECT h.name AS hospital, 
       SUM(i.total_amount) AS total_revenue,
       SUM(CASE WHEN i.is_covered_by_insurance THEN i.total_amount ELSE 0 END) AS insured_revenue
FROM invoices i
JOIN appointments a ON i.appt_id = a.appt_id
JOIN doctors d ON a.attending_doctor_id = d.doctor_id
JOIN departments dep ON d.dept_id = dep.dept_id
JOIN hospitals h ON dep.hospital_id = h.hospital_id
GROUP BY h.name;

-- ========================
-- 6. Patients currently admitted (no discharge date)
--    (JOIN + IS NULL)
-- ========================
SELECT u.name AS patient_name, b.bed_number, w.name AS ward, h.name AS hospital, ba.admitted_at
FROM bed_assignments ba
JOIN patients p ON ba.patient_id = p.patient_id
JOIN users u ON p.user_id = u.user_id
JOIN beds b ON ba.bed_id = b.bed_id
JOIN wards w ON b.ward_id = w.ward_id
JOIN hospitals h ON w.hospital_id = h.hospital_id
WHERE ba.discharged_at IS NULL;

-- ========================
-- 7. Patients who have both lab results AND prescriptions
--    (Subquery with IN)
-- ========================
SELECT DISTINCT u.name AS patient_name
FROM patients p
JOIN users u ON p.user_id = u.user_id
WHERE p.patient_id IN (SELECT patient_id FROM lab_results)
  AND p.patient_id IN (SELECT DISTINCT a.patient_id 
                       FROM prescriptions pr 
                       JOIN appointments a ON pr.appt_id = a.appt_id);

-- ========================
-- 8. Most common lab test
--    (GROUP BY + ORDER BY + LIMIT)
-- ========================
SELECT test_name, COUNT(*) AS times_conducted
FROM lab_results
GROUP BY test_name
ORDER BY times_conducted DESC
LIMIT 3;

-- ========================
-- 9. Appointments with full detail: patient, attending doctor,
--    diagnosis (lab result), and invoice amount
--    (Multi-table JOIN)
-- ========================
SELECT 
    a.appt_id,
    a.appt_date,
    pu.name AS patient_name,
    du.name AS attending_doctor,
    lr.test_name,
    lr.result_value,
    i.total_amount,
    i.is_covered_by_insurance
FROM appointments a
JOIN patients p ON a.patient_id = p.patient_id
JOIN users pu ON p.user_id = pu.user_id
JOIN doctors d ON a.attending_doctor_id = d.doctor_id
JOIN users du ON d.user_id = du.user_id
LEFT JOIN lab_results lr ON lr.appt_id = a.appt_id
LEFT JOIN invoices i ON i.appt_id = a.appt_id
ORDER BY a.appt_date;

-- ========================
-- 10. Doctors who have never been a referring doctor
--     (NOT IN subquery)
-- ========================
SELECT u.name AS doctor_name, d.specialty
FROM doctors d
JOIN users u ON d.user_id = u.user_id
WHERE d.doctor_id NOT IN (
    SELECT DISTINCT referring_doctor_id 
    FROM appointments 
    WHERE referring_doctor_id IS NOT NULL
);