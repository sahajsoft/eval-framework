-- Data Validation Queries for Medical Summary Database

-- 1. Check record counts for all tables
SELECT
    'organizations' AS table_name,
    COUNT(*) AS record_count
FROM organizations
UNION ALL
SELECT
    'payers',
    COUNT(*)
FROM payers
UNION ALL
SELECT
    'patients',
    COUNT(*)
FROM patients
UNION ALL
SELECT
    'providers',
    COUNT(*)
FROM providers
UNION ALL
SELECT
    'encounters',
    COUNT(*)
FROM encounters
UNION ALL
SELECT
    'conditions',
    COUNT(*)
FROM conditions
UNION ALL
SELECT
    'allergies',
    COUNT(*)
FROM allergies
UNION ALL
SELECT
    'medications',
    COUNT(*)
FROM medications
UNION ALL
SELECT
    'careplans',
    COUNT(*)
FROM careplans
UNION ALL
SELECT
    'procedures',
    COUNT(*)
FROM procedures
UNION ALL
SELECT
    'immunizations',
    COUNT(*)
FROM immunizations
UNION ALL
SELECT
    'devices',
    COUNT(*)
FROM devices
UNION ALL
SELECT
    'observations',
    COUNT(*)
FROM observations
UNION ALL
SELECT
    'imaging_studies',
    COUNT(*)
FROM imaging_studies
UNION ALL
SELECT
    'supplies',
    COUNT(*)
FROM supplies
UNION ALL
SELECT
    'payer_transitions',
    COUNT(*)
FROM payer_transitions
UNION ALL
SELECT
    'claims',
    COUNT(*)
FROM claims
UNION ALL
SELECT
    'claims_transactions',
    COUNT(*)
FROM claims_transactions
ORDER BY table_name;

-- 2. Check for orphaned records (foreign key integrity)
-- Encounters without valid patients
SELECT COUNT(*) AS orphaned_encounters
FROM encounters AS e
LEFT JOIN patients AS p ON e.patient = p.id
WHERE p.id IS NULL;

-- Encounters without valid organizations
SELECT COUNT(*) AS encounters_without_org
FROM encounters AS e
LEFT JOIN organizations AS o ON e.organization = o.id
WHERE o.id IS NULL;

-- Encounters without valid providers
SELECT COUNT(*) AS encounters_without_provider
FROM encounters AS e
LEFT JOIN providers AS pr ON e.provider = pr.id
WHERE pr.id IS NULL;

-- 3. Data quality checks
-- Check for patients with invalid dates
SELECT COUNT(*) AS patients_with_invalid_dates
FROM patients
WHERE deathdate IS NOT NULL AND deathdate < birthdate;

-- Check for encounters with invalid time ranges
SELECT COUNT(*) AS invalid_encounters
FROM encounters
WHERE stop < start;

-- 4. Sample data verification
-- Top 5 organizations by utilization
SELECT
    name,
    utilization,
    revenue
FROM organizations
ORDER BY utilization DESC NULLS LAST
LIMIT 5;

-- Patient demographics summary
SELECT
    gender,
    COUNT(*) AS count,
    AVG(EXTRACT(YEAR FROM AGE(COALESCE(deathdate, CURRENT_DATE), birthdate)))
        AS avg_age
FROM patients
GROUP BY gender;

-- Most common conditions
SELECT
    description,
    COUNT(*) AS frequency
FROM conditions
GROUP BY description
ORDER BY frequency DESC
LIMIT 10;

-- 5. Financial data summary
SELECT
    'Total Healthcare Expenses' AS metric,
    SUM(healthcare_expenses) AS amount
FROM patients
UNION ALL
SELECT
    'Total Healthcare Coverage',
    SUM(healthcare_coverage)
FROM patients
UNION ALL
SELECT
    'Total Payer Coverage',
    SUM(amount_covered)
FROM payers
UNION ALL
SELECT
    'Total Claims Outstanding',
    SUM(outstanding1 + COALESCE(outstanding2, 0) + COALESCE(outstandingp, 0))
FROM claims;

-- 6. Encounter statistics by class
SELECT
    encounterclass,
    COUNT(*) AS count,
    AVG(total_claim_cost) AS avg_cost,
    SUM(total_claim_cost) AS total_cost
FROM encounters
GROUP BY encounterclass
ORDER BY count DESC;
