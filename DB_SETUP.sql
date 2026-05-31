-- ========================
-- ENUMS
-- ========================
CREATE TYPE user_role AS ENUM ('patient', 'doctor', 'admin');

-- ========================
-- CORE ENTITIES
-- ========================
CREATE TABLE hospitals (
    hospital_id SERIAL PRIMARY KEY,
    name        VARCHAR(255) NOT NULL,
    location    VARCHAR(255)
);

CREATE TABLE departments (
    dept_id     SERIAL PRIMARY KEY,
    name        VARCHAR(255) NOT NULL,
    hospital_id INTEGER NOT NULL REFERENCES hospitals(hospital_id)
);

-- ========================
-- USERS / EER HIERARCHY
-- ========================
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    name    VARCHAR(255) NOT NULL,
    email   VARCHAR(255) UNIQUE NOT NULL,
    role    user_role NOT NULL
);

CREATE TABLE patients (
    patient_id      SERIAL PRIMARY KEY,
    user_id         INTEGER UNIQUE NOT NULL REFERENCES users(user_id),
    medical_history TEXT
);

CREATE TABLE doctors (
    doctor_id  SERIAL PRIMARY KEY,
    user_id    INTEGER UNIQUE NOT NULL REFERENCES users(user_id),
    dept_id    INTEGER NOT NULL REFERENCES departments(dept_id),
    specialty  VARCHAR(255)
);

-- ========================
-- RESOURCES
-- ========================
CREATE TABLE equipment (
    equip_id         SERIAL PRIMARY KEY,
    type             VARCHAR(50) CHECK (type IN ('XRAY','MRI','ULTRASOUND')),
    location_dept_id INTEGER REFERENCES departments(dept_id),
    hospital_id      INTEGER NOT NULL REFERENCES hospitals(hospital_id)
);

CREATE TABLE equipment_bookings (
    booking_id     SERIAL PRIMARY KEY,
    doctor_id      INTEGER NOT NULL REFERENCES doctors(doctor_id),
    equip_id       INTEGER NOT NULL REFERENCES equipment(equip_id),
    scheduled_time TIMESTAMP NOT NULL,
    status         VARCHAR(20) DEFAULT 'scheduled'
                   CHECK (status IN ('scheduled','in_use','completed','cancelled'))
);

-- ========================
-- APPOINTMENTS
-- ========================
CREATE TABLE appointments (
    appt_id             SERIAL PRIMARY KEY,
    patient_id          INTEGER NOT NULL REFERENCES patients(patient_id),
    referring_doctor_id INTEGER REFERENCES doctors(doctor_id),
    attending_doctor_id INTEGER NOT NULL REFERENCES doctors(doctor_id),
    appt_date           TIMESTAMP NOT NULL,
    status              VARCHAR(50) DEFAULT 'scheduled'
);

CREATE TABLE appointment_doctors (
    id        SERIAL PRIMARY KEY,
    appt_id   INTEGER NOT NULL REFERENCES appointments(appt_id),
    doctor_id INTEGER NOT NULL REFERENCES doctors(doctor_id),
    role      VARCHAR(100),
    UNIQUE (appt_id, doctor_id)
);

CREATE TABLE prescriptions (
    presc_id        SERIAL PRIMARY KEY,
    appt_id         INTEGER NOT NULL REFERENCES appointments(appt_id),
    doctor_id       INTEGER NOT NULL REFERENCES doctors(doctor_id),
    medication_name VARCHAR(255) NOT NULL,
    dosage          VARCHAR(100),
    prescribed_date TIMESTAMP DEFAULT NOW()
);

CREATE TABLE lab_results (
    result_id      SERIAL PRIMARY KEY,
    patient_id     INTEGER NOT NULL REFERENCES patients(patient_id),
    appt_id        INTEGER REFERENCES appointments(appt_id),
    test_name      VARCHAR(255) NOT NULL,
    result_value   VARCHAR(255),
    conducted_date TIMESTAMP DEFAULT NOW()
);

-- ========================
-- BILLING
-- ========================
CREATE TABLE invoices (
    invoice_id            SERIAL PRIMARY KEY,
    appt_id               INTEGER UNIQUE NOT NULL REFERENCES appointments(appt_id),
    total_amount          DECIMAL(10,2) NOT NULL,
    is_covered_by_insurance BOOLEAN DEFAULT FALSE,
    date_issued           TIMESTAMP DEFAULT NOW()
);

-- ========================
-- INPATIENT / BED MANAGEMENT
-- ========================
CREATE TABLE wards (
    ward_id     SERIAL PRIMARY KEY,
    hospital_id INTEGER NOT NULL REFERENCES hospitals(hospital_id),
    name        VARCHAR(255) NOT NULL,
    type        VARCHAR(50) CHECK (type IN ('ICU','general','maternity','surgery','pediatrics'))
);

CREATE TABLE beds (
    bed_id      SERIAL PRIMARY KEY,
    ward_id     INTEGER NOT NULL REFERENCES wards(ward_id),
    bed_number  VARCHAR(20) NOT NULL,
    status      VARCHAR(20) DEFAULT 'available'
                CHECK (status IN ('available','occupied','maintenance')),
    UNIQUE (ward_id, bed_number)
);

CREATE TABLE bed_assignments (
    assignment_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    patient_id    INTEGER NOT NULL REFERENCES patients(patient_id),
    bed_id        INTEGER NOT NULL REFERENCES beds(bed_id),
    admitted_by   INTEGER NOT NULL REFERENCES doctors(doctor_id),
    admitted_at   TIMESTAMP NOT NULL DEFAULT NOW(),
    discharged_at TIMESTAMP  -- NULL = still admitted
);

-- ========================
-- AUDIT
-- ========================
CREATE TABLE audit_log (
    log_id     SERIAL PRIMARY KEY,
    table_name VARCHAR(100) NOT NULL,
    record_id  INTEGER,
    changed_by INTEGER REFERENCES users(user_id),
    changed_at TIMESTAMP DEFAULT NOW(),
    action     VARCHAR(10) CHECK (action IN ('INSERT','UPDATE','DELETE')),
    old_value  TEXT,  -- JSON snapshot
    new_value  TEXT   -- JSON snapshot
);