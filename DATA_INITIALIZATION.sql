-- ========================
-- HOSPITALS
-- ========================
INSERT INTO hospitals (name, location) VALUES
('City General Hospital', 'Istanbul'),
('North Medical Center', 'Ankara'),
('Aegean Health Clinic', 'Izmir');

-- ========================
-- DEPARTMENTS
-- ========================
INSERT INTO departments (name, hospital_id) VALUES
('Cardiology',       1),
('Neurology',        1),
('Orthopedics',      2),
('Pediatrics',       2),
('Radiology',        3),
('General Surgery',  3);

-- ========================
-- USERS
-- ========================
INSERT INTO users (name, email, role) VALUES
-- Admins
('Ali Yilmaz',      'ali.admin@hospital.com',     'admin'),
('Selin Kaya',      'selin.admin@hospital.com',   'admin'),
-- Doctors
('Dr. Mehmet Oz',   'mehmet.oz@hospital.com',     'doctor'),
('Dr. Ayse Demir',  'ayse.demir@hospital.com',    'doctor'),
('Dr. Emre Sahin',  'emre.sahin@hospital.com',    'doctor'),
('Dr. Fatma Celik', 'fatma.celik@hospital.com',   'doctor'),
('Dr. Burak Arslan','burak.arslan@hospital.com',  'doctor'),
-- Patients
('Kemal Yildiz',    'kemal@mail.com',             'patient'),
('Zeynep Koc',      'zeynep@mail.com',            'patient'),
('Hasan Bulut',     'hasan@mail.com',             'patient'),
('Merve Akin',      'merve@mail.com',             'patient'),
('Tolga Erdem',     'tolga@mail.com',             'patient'),
('Narin Polat',     'narin@mail.com',             'patient'),
('Oguz Yurt',       'oguz@mail.com',              'patient'),
('Ceren Tas',       'ceren@mail.com',             'patient');

-- ========================
-- DOCTORS
-- ========================
INSERT INTO doctors (user_id, dept_id, specialty) VALUES
(3, 1, 'Cardiologist'),
(4, 2, 'Neurologist'),
(5, 3, 'Orthopedic Surgeon'),
(6, 4, 'Pediatrician'),
(7, 5, 'Radiologist');

-- ========================
-- PATIENTS
-- ========================
INSERT INTO patients (user_id, medical_history) VALUES
(8,  'Hypertension, Type 2 Diabetes'),
(9,  'Asthma'),
(10, 'No significant history'),
(11, 'Migraine, Anxiety'),
(12, 'Fractured left femur (2022)'),
(13, 'Allergic rhinitis'),
(14, 'Appendectomy (2021)'),
(15, 'No significant history');

-- ========================
-- EQUIPMENT
-- ========================
INSERT INTO equipment (type, location_dept_id, hospital_id) VALUES
('XRAY',      1, 1),
('MRI',       2, 1),
('ULTRASOUND',3, 2),
('XRAY',      5, 3),
('MRI',       5, 3);

-- ========================
-- APPOINTMENTS
-- ========================
INSERT INTO appointments (patient_id, referring_doctor_id, attending_doctor_id, appt_date, status) VALUES
(1, NULL, 1, '2026-01-10 09:00', 'completed'),
(2, 1,    2, '2026-01-15 10:30', 'completed'),
(3, NULL, 3, '2026-02-01 11:00', 'completed'),
(4, 2,    2, '2026-02-14 14:00', 'completed'),
(5, NULL, 3, '2026-03-05 08:30', 'completed'),
(6, NULL, 4, '2026-03-20 13:00', 'completed'),
(7, 3,    1, '2026-04-02 09:30', 'completed'),
(8, NULL, 5, '2026-04-18 15:00', 'completed'),
(1, NULL, 2, '2026-05-01 10:00', 'completed'),
(3, 1,    1, '2026-05-22 11:30', 'scheduled'),
(2, NULL, 4, '2026-06-01 09:00', 'scheduled'),
(4, NULL, 3, '2026-06-10 14:30', 'scheduled');

-- ========================
-- APPOINTMENT DOCTORS (multi-doctor)
-- ========================
INSERT INTO appointment_doctors (appt_id, doctor_id, role) VALUES
(3, 3, 'surgeon'),
(3, 5, 'radiologist'),
(5, 3, 'surgeon'),
(5, 1, 'anesthesiologist'),
(7, 1, 'cardiologist'),
(7, 2, 'neurologist');

-- ========================
-- PRESCRIPTIONS
-- ========================
INSERT INTO prescriptions (appt_id, doctor_id, medication_name, dosage, prescribed_date) VALUES
(1, 1, 'Metoprolol',   '50mg once daily',    '2026-01-10 09:30'),
(2, 2, 'Sumatriptan',  '100mg as needed',    '2026-01-15 11:00'),
(3, 3, 'Ibuprofen',    '400mg 3x daily',     '2026-02-01 11:30'),
(4, 2, 'Amitriptyline','25mg once at night', '2026-02-14 14:30'),
(6, 4, 'Cetirizine',   '10mg once daily',    '2026-03-20 13:30'),
(8, 5, 'Paracetamol',  '500mg as needed',    '2026-04-18 15:30'),
(9, 1, 'Amlodipine',   '5mg once daily',     '2026-05-01 10:30');

-- ========================
-- LAB RESULTS
-- ========================
INSERT INTO lab_results (patient_id, appt_id, test_name, result_value, conducted_date) VALUES
(1, 1, 'Blood Pressure',  '145/95 mmHg',  '2026-01-10 08:45'),
(1, 1, 'Blood Glucose',   '210 mg/dL',    '2026-01-10 08:50'),
(2, 2, 'MRI Brain',       'No anomaly',   '2026-01-15 10:00'),
(3, 3, 'X-Ray Left Knee', 'Mild fracture','2026-02-01 10:30'),
(4, 4, 'EEG',             'Normal',       '2026-02-14 13:30'),
(5, 5, 'X-Ray Hip',       'Healing well', '2026-03-05 08:00'),
(7, 7, 'ECG',             'Normal sinus', '2026-04-02 09:00'),
(8, 8, 'Chest X-Ray',     'Clear',        '2026-04-18 14:30');

-- ========================
-- INVOICES
-- ========================
INSERT INTO invoices (appt_id, total_amount, is_covered_by_insurance, date_issued) VALUES
(1,  450.00, true,  '2026-01-10 10:00'),
(2,  300.00, false, '2026-01-15 12:00'),
(3,  750.00, true,  '2026-02-01 13:00'),
(4,  280.00, true,  '2026-02-14 15:30'),
(5,  900.00, false, '2026-03-05 10:00'),
(6,  150.00, true,  '2026-03-20 14:00'),
(7,  500.00, true,  '2026-04-02 11:00'),
(8,  200.00, false, '2026-04-18 16:00');

-- ========================
-- EQUIPMENT BOOKINGS
-- ========================
INSERT INTO equipment_bookings (doctor_id, equip_id, scheduled_time, status) VALUES
(5, 1, '2026-01-10 08:00', 'completed'),
(2, 2, '2026-01-15 09:30', 'completed'),
(3, 3, '2026-02-01 10:00', 'completed'),
(5, 4, '2026-04-18 14:00', 'completed'),
(1, 2, '2026-05-22 11:00', 'scheduled');

-- ========================
-- WARDS
-- ========================
INSERT INTO wards (hospital_id, name, type) VALUES
(1, 'Cardiac Ward',   'ICU'),
(1, 'Neuro Ward',     'general'),
(2, 'Ortho Ward',     'surgery'),
(2, 'Children Ward',  'pediatrics'),
(3, 'Main Ward',      'general');

-- ========================
-- BEDS
-- ========================
INSERT INTO beds (ward_id, bed_number, status) VALUES
(1, 'A1', 'occupied'),
(1, 'A2', 'available'),
(2, 'B1', 'occupied'),
(3, 'C1', 'available'),
(3, 'C2', 'maintenance'),
(4, 'D1', 'available'),
(5, 'E1', 'occupied');

-- ========================
-- BED ASSIGNMENTS
-- ========================
INSERT INTO bed_assignments (patient_id, bed_id, admitted_by, admitted_at, discharged_at) VALUES
(1, 1, 1, '2026-01-10 10:00', '2026-01-15 09:00'),
(3, 3, 2, '2026-02-01 12:00', '2026-02-05 11:00'),
(7, 7, 1, '2026-04-02 10:00', NULL);  -- still admitted

-- ========================
-- AUDIT LOG
-- ========================
INSERT INTO audit_log (table_name, record_id, changed_by, changed_at, action, old_value, new_value) VALUES
('appointments', 1,  1, '2026-01-10 09:00', 'INSERT', NULL,                              '{"status":"scheduled"}'),
('appointments', 1,  1, '2026-01-11 08:00', 'UPDATE', '{"status":"scheduled"}',          '{"status":"completed"}'),
('beds',         1,  2, '2026-01-10 10:00', 'UPDATE', '{"status":"available"}',          '{"status":"occupied"}'),
('invoices',     5,  1, '2026-03-05 10:00', 'INSERT', NULL,                              '{"total_amount":900.00}'),
('prescriptions',3,  3, '2026-02-01 11:30', 'INSERT', NULL,                              '{"medication":"Ibuprofen"}');