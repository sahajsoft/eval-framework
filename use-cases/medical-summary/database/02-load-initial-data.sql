-- Load CSV data into PostgreSQL tables
-- This script runs automatically when the PostgreSQL container is first created

-- Note: PostgreSQL COPY expects lowercase column names to match table schema
-- The CSV headers are uppercase, so we specify the column mappings explicitly

-- Load organizations first (referenced by other tables)
COPY organizations (
    id, name, address, city, state, zip, lat, lon, phone, revenue, utilization
)
FROM PROGRAM 'gunzip -c /docker-entrypoint-initdb.d/data/organizations.csv.gz'
WITH (FORMAT csv, HEADER true, DELIMITER ',');

-- Load payers (referenced by other tables)
COPY payers (
    id,
    name,
    address,
    city,
    state_headquartered,
    zip,
    phone,
    amount_covered,
    amount_uncovered,
    revenue,
    covered_encounters,
    uncovered_encounters,
    covered_medications,
    uncovered_medications,
    covered_procedures,
    uncovered_procedures,
    covered_immunizations,
    uncovered_immunizations,
    unique_customers,
    qols_avg,
    member_months
)
FROM PROGRAM 'gunzip -c /docker-entrypoint-initdb.d/data/payers.csv.gz'
WITH (FORMAT csv, HEADER true, DELIMITER ',');

-- Load patients
COPY patients (
    id,
    birthdate,
    deathdate,
    ssn,
    drivers,
    passport,
    prefix,
    first,
    last,
    suffix,
    maiden,
    marital,
    race,
    ethnicity,
    gender,
    birthplace,
    address,
    city,
    state,
    county,
    zip,
    lat,
    lon,
    healthcare_expenses,
    healthcare_coverage
)
FROM PROGRAM 'gunzip -c /docker-entrypoint-initdb.d/data/patients.csv.gz'
WITH (FORMAT csv, HEADER true, DELIMITER ',');

-- Load providers
COPY providers (
    id,
    organization,
    name,
    gender,
    speciality,
    address,
    city,
    state,
    zip,
    lat,
    lon,
    utilization
)
FROM PROGRAM 'gunzip -c /docker-entrypoint-initdb.d/data/providers.csv.gz'
WITH (FORMAT csv, HEADER true, DELIMITER ',');

-- Load encounters
COPY encounters (
    id,
    start,
    stop,
    patient,
    organization,
    provider,
    payer,
    encounterclass,
    code,
    description,
    base_encounter_cost,
    total_claim_cost,
    payer_coverage,
    reasoncode,
    reasondescription
)
FROM PROGRAM 'gunzip -c /docker-entrypoint-initdb.d/data/encounters.csv.gz'
WITH (FORMAT csv, HEADER true, DELIMITER ',');

-- Load conditions
COPY conditions (start, stop, patient, encounter, code, description)
FROM PROGRAM 'gunzip -c /docker-entrypoint-initdb.d/data/conditions.csv.gz'
WITH (FORMAT csv, HEADER true, DELIMITER ',');

-- Load medications
COPY medications (
    start,
    stop,
    patient,
    payer,
    encounter,
    code,
    description,
    base_cost,
    payer_coverage,
    dispenses,
    totalcost,
    reasoncode,
    reasondescription
)
FROM PROGRAM 'gunzip -c /docker-entrypoint-initdb.d/data/medications.csv.gz'
WITH (FORMAT csv, HEADER true, DELIMITER ',');

-- Load procedures
COPY procedures (
    start,
    stop,
    patient,
    encounter,
    code,
    description,
    base_cost,
    reasoncode,
    reasondescription
)
FROM PROGRAM 'gunzip -c /docker-entrypoint-initdb.d/data/procedures.csv.gz'
WITH (FORMAT csv, HEADER true, DELIMITER ',');

-- Load allergies
COPY allergies (
    start,
    stop,
    patient,
    encounter,
    code,
    system,
    description,
    type,
    category,
    reaction1,
    description1,
    severity1,
    reaction2,
    description2,
    severity2
)
FROM PROGRAM 'gunzip -c /docker-entrypoint-initdb.d/data/allergies.csv.gz'
WITH (FORMAT csv, HEADER true, DELIMITER ',');

-- Load careplans
COPY careplans (
    id,
    start,
    stop,
    patient,
    encounter,
    code,
    description,
    reasoncode,
    reasondescription
)
FROM PROGRAM 'gunzip -c /docker-entrypoint-initdb.d/data/careplans.csv.gz'
WITH (FORMAT csv, HEADER true, DELIMITER ',');

-- Load immunizations
COPY immunizations (date, patient, encounter, code, description, base_cost)
FROM PROGRAM 'gunzip -c /docker-entrypoint-initdb.d/data/immunizations.csv.gz'
WITH (FORMAT csv, HEADER true, DELIMITER ',');

-- Load devices
COPY devices (start, stop, patient, encounter, code, description, udi)
FROM PROGRAM 'gunzip -c /docker-entrypoint-initdb.d/data/devices.csv.gz'
WITH (FORMAT csv, HEADER true, DELIMITER ',');

-- Load observations
COPY observations (
    date, patient, encounter, category, code, description, value, units, type
)
FROM PROGRAM 'gunzip -c /docker-entrypoint-initdb.d/data/observations.csv.gz'
WITH (FORMAT csv, HEADER true, DELIMITER ',');

-- Load imaging_studies
COPY imaging_studies (
    id,
    date,
    patient,
    encounter,
    series_uid,
    bodysite_code,
    bodysite_description,
    modality_code,
    modality_description,
    instance_uid,
    sop_code,
    sop_description,
    procedure_code
)
FROM PROGRAM 'gunzip -c /docker-entrypoint-initdb.d/data/imaging_studies.csv.gz'
WITH (FORMAT csv, HEADER true, DELIMITER ',');

-- Load supplies
COPY supplies (date, patient, encounter, code, description, quantity)
FROM PROGRAM 'gunzip -c /docker-entrypoint-initdb.d/data/supplies.csv.gz'
WITH (FORMAT csv, HEADER true, DELIMITER ',');

-- Load payer_transitions
COPY payer_transitions (
    patient,
    memberid,
    start_year,
    end_year,
    payer,
    secondary_payer,
    ownership,
    ownername
)
FROM PROGRAM 'gunzip -c /docker-entrypoint-initdb.d/data/payer_transitions.csv.gz'
WITH (FORMAT csv, HEADER true, DELIMITER ',');

-- Load claims
COPY claims (
    id,
    patientid,
    providerid,
    primarypatientinsuranceid,
    secondarypatientinsuranceid,
    departmentid,
    patientdepartmentid,
    diagnosis1,
    diagnosis2,
    diagnosis3,
    diagnosis4,
    diagnosis5,
    diagnosis6,
    diagnosis7,
    diagnosis8,
    referringproviderid,
    appointmentid,
    currentillnessdate,
    servicedate,
    supervisingproviderid,
    status1,
    status2,
    statusp,
    outstanding1,
    outstanding2,
    outstandingp,
    lastbilleddate1,
    lastbilleddate2,
    lastbilleddatep,
    healthcareclaimtypeid1,
    healthcareclaimtypeid2
)
FROM PROGRAM 'gunzip -c /docker-entrypoint-initdb.d/data/claims.csv.gz'
WITH (FORMAT csv, HEADER true, DELIMITER ',');

-- Load claims_transactions
COPY claims_transactions (
    id,
    claimid,
    chargeid,
    patientid,
    type,
    amount,
    method,
    fromdate,
    todate,
    placeofservice,
    procedurecode,
    modifier1,
    modifier2,
    diagnosisref1,
    diagnosisref2,
    diagnosisref3,
    diagnosisref4,
    units,
    departmentid,
    notes,
    unitamount,
    transferoutid,
    transfertype,
    payments,
    adjustments,
    transfers,
    outstanding,
    appointmentid,
    linenote,
    patientinsuranceid,
    feescheduleid,
    providerid,
    supervisingproviderid
)
FROM PROGRAM 'gunzip -c /docker-entrypoint-initdb.d/data/claims_transactions.csv.gz'
WITH (FORMAT csv, HEADER true, DELIMITER ',');

-- Verify data was loaded
SELECT 'Patients loaded: ' || COUNT(*) FROM patients;
SELECT 'Providers loaded: ' || COUNT(*) FROM providers;
SELECT 'Encounters loaded: ' || COUNT(*) FROM encounters;
SELECT 'Conditions loaded: ' || COUNT(*) FROM conditions;
SELECT 'Medications loaded: ' || COUNT(*) FROM medications;
SELECT 'Procedures loaded: ' || COUNT(*) FROM procedures;
