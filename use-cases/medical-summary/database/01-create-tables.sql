-- Medical Summary Database Schema

-- Organizations table
CREATE TABLE organizations (
    id UUID PRIMARY KEY,
    name VARCHAR(255),
    address TEXT,
    city VARCHAR(100),
    state VARCHAR(25),
    zip VARCHAR(10),
    lat DECIMAL(10, 8),
    lon DECIMAL(11, 8),
    phone VARCHAR(30),
    revenue DECIMAL(15, 2),
    utilization INTEGER
);

-- Providers table
CREATE TABLE providers (
    id UUID PRIMARY KEY,
    organization UUID REFERENCES organizations (id),
    name VARCHAR(255),
    gender VARCHAR(10),
    speciality VARCHAR(100),
    address TEXT,
    city VARCHAR(100),
    state VARCHAR(25),
    zip VARCHAR(10),
    lat DECIMAL(10, 8),
    lon DECIMAL(11, 8),
    utilization INTEGER
);

-- Payers table
CREATE TABLE payers (
    id UUID PRIMARY KEY,
    name VARCHAR(255),
    address TEXT,
    city VARCHAR(100),
    state_headquartered VARCHAR(50),
    zip VARCHAR(10),
    phone VARCHAR(30),
    amount_covered DECIMAL(15, 2),
    amount_uncovered DECIMAL(15, 2),
    revenue DECIMAL(15, 2),
    covered_encounters INTEGER,
    uncovered_encounters INTEGER,
    covered_medications INTEGER,
    uncovered_medications INTEGER,
    covered_procedures INTEGER,
    uncovered_procedures INTEGER,
    covered_immunizations INTEGER,
    uncovered_immunizations INTEGER,
    unique_customers INTEGER,
    qols_avg DECIMAL(5, 2),
    member_months INTEGER
);

-- Patients table
CREATE TABLE patients (
    id UUID PRIMARY KEY,
    birthdate DATE,
    deathdate DATE,
    ssn VARCHAR(15),
    drivers VARCHAR(20),
    passport VARCHAR(20),
    prefix VARCHAR(10),
    first VARCHAR(100),
    last VARCHAR(100),
    suffix VARCHAR(10),
    maiden VARCHAR(100),
    marital VARCHAR(20),
    race VARCHAR(50),
    ethnicity VARCHAR(50),
    gender VARCHAR(10),
    birthplace TEXT,
    address TEXT,
    city VARCHAR(100),
    state VARCHAR(25),
    county VARCHAR(100),
    zip VARCHAR(10),
    lat DECIMAL(10, 8),
    lon DECIMAL(11, 8),
    healthcare_expenses DECIMAL(15, 2),
    healthcare_coverage DECIMAL(15, 2)
);

-- Encounters table
CREATE TABLE encounters (
    id UUID PRIMARY KEY,
    start TIMESTAMPTZ,
    stop TIMESTAMPTZ,
    patient UUID REFERENCES patients (id),
    organization UUID REFERENCES organizations (id),
    provider UUID REFERENCES providers (id),
    payer UUID REFERENCES payers (id),
    encounterclass VARCHAR(50),
    code VARCHAR(50),
    description TEXT,
    base_encounter_cost DECIMAL(10, 2),
    total_claim_cost DECIMAL(10, 2),
    payer_coverage DECIMAL(10, 2),
    reasoncode VARCHAR(50),
    reasondescription TEXT
);

-- Conditions table
CREATE TABLE conditions (
    start DATE,
    stop DATE,
    patient UUID REFERENCES patients (id),
    encounter UUID REFERENCES encounters (id),
    code VARCHAR(50),
    description TEXT
);

-- Allergies table
CREATE TABLE allergies (
    start DATE,
    stop DATE,
    patient UUID REFERENCES patients (id),
    encounter UUID REFERENCES encounters (id),
    code VARCHAR(50),
    system VARCHAR(100),
    description TEXT,
    type VARCHAR(50),
    category VARCHAR(50),
    reaction1 VARCHAR(50),
    description1 TEXT,
    severity1 VARCHAR(20),
    reaction2 VARCHAR(50),
    description2 TEXT,
    severity2 VARCHAR(20)
);

-- Medications table
CREATE TABLE medications (
    start DATE,
    stop DATE,
    patient UUID REFERENCES patients (id),
    payer UUID REFERENCES payers (id),
    encounter UUID REFERENCES encounters (id),
    code VARCHAR(50),
    description TEXT,
    base_cost DECIMAL(10, 2),
    payer_coverage DECIMAL(10, 2),
    dispenses INTEGER,
    totalcost DECIMAL(10, 2),
    reasoncode VARCHAR(50),
    reasondescription TEXT
);

-- Careplans table
CREATE TABLE careplans (
    id UUID PRIMARY KEY,
    start DATE,
    stop DATE,
    patient UUID REFERENCES patients (id),
    encounter UUID REFERENCES encounters (id),
    code VARCHAR(50),
    description TEXT,
    reasoncode VARCHAR(50),
    reasondescription TEXT
);

-- Procedures table
CREATE TABLE procedures (
    start DATE,
    stop DATE,
    patient UUID REFERENCES patients (id),
    encounter UUID REFERENCES encounters (id),
    code VARCHAR(50),
    description TEXT,
    base_cost DECIMAL(10, 2),
    reasoncode VARCHAR(50),
    reasondescription TEXT
);

-- Immunizations table
CREATE TABLE immunizations (
    date DATE,
    patient UUID REFERENCES patients (id),
    encounter UUID REFERENCES encounters (id),
    code VARCHAR(50),
    description TEXT,
    base_cost DECIMAL(10, 2)
);

-- Devices table
CREATE TABLE devices (
    start DATE,
    stop DATE,
    patient UUID REFERENCES patients (id),
    encounter UUID REFERENCES encounters (id),
    code VARCHAR(50),
    description TEXT,
    udi TEXT
);

-- Observations table
CREATE TABLE observations (
    date DATE,
    patient UUID REFERENCES patients (id),
    encounter UUID REFERENCES encounters (id),
    category VARCHAR(50),
    code VARCHAR(50),
    description TEXT,
    value TEXT,
    units VARCHAR(50),
    type VARCHAR(50)
);

-- Imaging studies table
CREATE TABLE imaging_studies (
    id UUID,
    date DATE,
    patient UUID REFERENCES patients (id),
    encounter UUID REFERENCES encounters (id),
    series_uid VARCHAR(100),
    bodysite_code VARCHAR(50),
    bodysite_description TEXT,
    modality_code VARCHAR(50),
    modality_description TEXT,
    instance_uid VARCHAR(100),
    sop_code VARCHAR(50),
    sop_description TEXT,
    procedure_code VARCHAR(50),
    PRIMARY KEY (id, instance_uid)
);

-- Supplies table
CREATE TABLE supplies (
    date DATE,
    patient UUID REFERENCES patients (id),
    encounter UUID REFERENCES encounters (id),
    code VARCHAR(50),
    description TEXT,
    quantity INTEGER
);

-- Payer transitions table
CREATE TABLE payer_transitions (
    patient UUID REFERENCES patients (id),
    memberid VARCHAR(50),
    start_year TIMESTAMPTZ,
    end_year TIMESTAMPTZ,
    payer UUID REFERENCES payers (id),
    secondary_payer UUID REFERENCES payers (id),
    ownership VARCHAR(50),
    ownername VARCHAR(255)
);

-- Claims table
CREATE TABLE claims (
    id UUID PRIMARY KEY,
    patientid UUID REFERENCES patients (id),
    providerid UUID REFERENCES providers (id),
    primarypatientinsuranceid VARCHAR(100),
    secondarypatientinsuranceid VARCHAR(100),
    departmentid INTEGER,
    patientdepartmentid INTEGER,
    diagnosis1 VARCHAR(50),
    diagnosis2 VARCHAR(50),
    diagnosis3 VARCHAR(50),
    diagnosis4 VARCHAR(50),
    diagnosis5 VARCHAR(50),
    diagnosis6 VARCHAR(50),
    diagnosis7 VARCHAR(50),
    diagnosis8 VARCHAR(50),
    referringproviderid UUID REFERENCES providers (id),
    appointmentid VARCHAR(100),
    currentillnessdate DATE,
    servicedate DATE,
    supervisingproviderid UUID REFERENCES providers (id),
    status1 VARCHAR(50),
    status2 VARCHAR(50),
    statusp VARCHAR(50),
    outstanding1 DECIMAL(10, 2),
    outstanding2 DECIMAL(10, 2),
    outstandingp DECIMAL(10, 2),
    lastbilleddate1 DATE,
    lastbilleddate2 DATE,
    lastbilleddatep DATE,
    healthcareclaimtypeid1 VARCHAR(50),
    healthcareclaimtypeid2 VARCHAR(50)
);

-- Claims transactions table
CREATE TABLE claims_transactions (
    id UUID PRIMARY KEY,
    claimid UUID REFERENCES claims (id),
    chargeid INTEGER,
    patientid UUID REFERENCES patients (id),
    type VARCHAR(50),
    amount DECIMAL(10, 2),
    method VARCHAR(50),
    fromdate DATE,
    todate DATE,
    placeofservice VARCHAR(100),
    procedurecode VARCHAR(50),
    modifier1 VARCHAR(10),
    modifier2 VARCHAR(10),
    diagnosisref1 INTEGER,
    diagnosisref2 INTEGER,
    diagnosisref3 INTEGER,
    diagnosisref4 INTEGER,
    units DECIMAL(10, 2),
    departmentid INTEGER,
    notes TEXT,
    unitamount DECIMAL(10, 2),
    transferoutid VARCHAR(100),
    transfertype VARCHAR(50),
    payments DECIMAL(10, 2),
    adjustments DECIMAL(10, 2),
    transfers DECIMAL(10, 2),
    outstanding DECIMAL(10, 2),
    appointmentid VARCHAR(100),
    linenote TEXT,
    patientinsuranceid VARCHAR(100),
    feescheduleid VARCHAR(100),
    providerid UUID REFERENCES providers (id),
    supervisingproviderid UUID REFERENCES providers (id)
);

-- Create indexes for better query performance
CREATE INDEX idx_patients_name ON patients (last, first);
CREATE INDEX idx_encounters_patient ON encounters (patient);
CREATE INDEX idx_encounters_dates ON encounters (start, stop);
CREATE INDEX idx_conditions_patient ON conditions (patient);
CREATE INDEX idx_medications_patient ON medications (patient);
CREATE INDEX idx_observations_patient ON observations (patient);
CREATE INDEX idx_procedures_patient ON procedures (patient);
CREATE INDEX idx_claims_patient ON claims (patientid);
CREATE INDEX idx_claims_transactions_claim ON claims_transactions (claimid);
