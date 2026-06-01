# Smart Healthcare Management System
### MTM2522 Data Management and File Structures 1 — Yıldız Technical University

A fully normalized relational database system for a multi-hospital healthcare network, 
designed and implemented in PostgreSQL.

## Overview

This project implements a complete database backend for a hospital network supporting 
multi-user access across three roles: patients, doctors, and administrators. The system 
manages clinical operations including appointments, prescriptions, lab results, bed 
assignments, equipment bookings, and billing.

## Database Schema

The schema consists of 16 interrelated tables organized into four functional domains:

- **Identity & Organization** — users, patients, doctors, hospitals, departments
- **Clinical Workflow** — appointments, appointment_doctors, prescriptions, lab_results
- **Resource & Bed Management** — equipment, equipment_bookings, wards, beds, bed_assignments
- **Governance** — invoices, audit_log

## Repository Structure
├── DB_SETUP.sql      # Full schema with constraints, ENUMs, and indexes
├── DATA_INITILAZATION.sql        # Sample dataset (30+ records)
├── ADVANCED_QUERIES.sql            # 10 advanced SQL queries
├── INDEXING.sql           # B+ Tree and Hash index definitions + EXPLAIN ANALYZE
└── Project Report.pdf                 # Full project report

## Technologies

- **Database**: PostgreSQL 16
- **Query Tool**: pgAdmin

## Key Features

- EER inheritance hierarchy — `users` as supertype for `patients`, `doctors`, and `admins`
- Normalized to BCNF across all critical tables
- B+ Tree indexes on high-frequency JOIN columns
- Hash indexes on equality-lookup columns
- Audit log table tracking all INSERT, UPDATE, and DELETE operations
- EXPLAIN ANALYZE performance comparison for indexed vs non-indexed queries

## How to Run

1. Open pgAdmin and connect to your PostgreSQL server
2. Create a new database
3. Run the scripts in order:
```sql
    \i DB_SETUP.sql     
    \i DATA_INITILAZATION.sql   
    \i ADVANCED_QUERIES.sql  
    \i INDEXING.sql      
```

## Course Info

| | |
|---|---|
| Course | MTM2522 Data Management and File Structures 1 |
| Institution | Yıldız Technical University |
| Department | Mathematical Engineering |
| Lecturer | Prof. Dr. İbrahim Emiroğlu |
| Student | Efe Kağan Önem — 21052012 |
