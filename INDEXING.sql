-- ========================
-- B+ TREE INDEXES (default in PostgreSQL)
-- ========================
CREATE INDEX idx_appointments_patient ON appointments(patient_id);
CREATE INDEX idx_appointments_doctor  ON appointments(attending_doctor_id);
CREATE INDEX idx_prescriptions_doctor ON prescriptions(doctor_id);
CREATE INDEX idx_lab_results_patient  ON lab_results(patient_id);

-- ========================
-- HASH INDEXES
-- ========================
CREATE INDEX idx_users_email_hash  ON users USING HASH (email);
CREATE INDEX idx_appointments_status_hash ON appointments USING HASH (status);

-- ========================
-- PERFORMANCE COMPARISON
-- Test WITHOUT index first, then WITH
-- ========================

-- Drop index temporarily to test without
DROP INDEX idx_appointments_patient;

EXPLAIN ANALYZE
SELECT * FROM appointments WHERE patient_id = 1;

-- Recreate and test with index
CREATE INDEX idx_appointments_patient ON appointments(patient_id);

EXPLAIN ANALYZE
SELECT * FROM appointments WHERE patient_id = 1;