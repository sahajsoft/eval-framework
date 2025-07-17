# Medical Summary Database Schema

## Entity Relationship Diagram

```mermaid
erDiagram
    organizations {
        UUID id PK
        VARCHAR name
        TEXT address
        VARCHAR city
        VARCHAR state
        VARCHAR zip
        DECIMAL lat
        DECIMAL lon
        VARCHAR phone
        DECIMAL revenue
        INTEGER utilization
    }

    providers {
        UUID id PK
        UUID organization FK
        VARCHAR name
        VARCHAR gender
        VARCHAR speciality
        TEXT address
        VARCHAR city
        VARCHAR state
        VARCHAR zip
        DECIMAL lat
        DECIMAL lon
        INTEGER utilization
    }

    payers {
        UUID id PK
        VARCHAR name
        TEXT address
        VARCHAR city
        VARCHAR state_headquartered
        VARCHAR zip
        VARCHAR phone
        DECIMAL amount_covered
        DECIMAL amount_uncovered
        DECIMAL revenue
        INTEGER covered_encounters
        INTEGER uncovered_encounters
        INTEGER covered_medications
        INTEGER uncovered_medications
        INTEGER covered_procedures
        INTEGER uncovered_procedures
        INTEGER covered_immunizations
        INTEGER uncovered_immunizations
        INTEGER unique_customers
        DECIMAL qols_avg
        INTEGER member_months
    }

    patients {
        UUID id PK
        DATE birthdate
        DATE deathdate
        VARCHAR ssn
        VARCHAR drivers
        VARCHAR passport
        VARCHAR prefix
        VARCHAR first
        VARCHAR last
        VARCHAR suffix
        VARCHAR maiden
        VARCHAR marital
        VARCHAR race
        VARCHAR ethnicity
        VARCHAR gender
        TEXT birthplace
        TEXT address
        VARCHAR city
        VARCHAR state
        VARCHAR county
        VARCHAR zip
        DECIMAL lat
        DECIMAL lon
        DECIMAL healthcare_expenses
        DECIMAL healthcare_coverage
    }

    encounters {
        UUID id PK
        TIMESTAMPTZ start
        TIMESTAMPTZ stop
        UUID patient FK
        UUID organization FK
        UUID provider FK
        UUID payer FK
        VARCHAR encounterclass
        VARCHAR code
        TEXT description
        DECIMAL base_encounter_cost
        DECIMAL total_claim_cost
        DECIMAL payer_coverage
        VARCHAR reasoncode
        TEXT reasondescription
    }

    conditions {
        DATE start
        DATE stop
        UUID patient FK
        UUID encounter FK
        VARCHAR code
        TEXT description
    }

    allergies {
        DATE start
        DATE stop
        UUID patient FK
        UUID encounter FK
        VARCHAR code
        VARCHAR system
        TEXT description
        VARCHAR type
        VARCHAR category
        VARCHAR reaction1
        TEXT description1
        VARCHAR severity1
        VARCHAR reaction2
        TEXT description2
        VARCHAR severity2
    }

    medications {
        DATE start
        DATE stop
        UUID patient FK
        UUID payer FK
        UUID encounter FK
        VARCHAR code
        TEXT description
        DECIMAL base_cost
        DECIMAL payer_coverage
        INTEGER dispenses
        DECIMAL totalcost
        VARCHAR reasoncode
        TEXT reasondescription
    }

    careplans {
        UUID id PK
        DATE start
        DATE stop
        UUID patient FK
        UUID encounter FK
        VARCHAR code
        TEXT description
        VARCHAR reasoncode
        TEXT reasondescription
    }

    procedures {
        DATE start
        DATE stop
        UUID patient FK
        UUID encounter FK
        VARCHAR code
        TEXT description
        DECIMAL base_cost
        VARCHAR reasoncode
        TEXT reasondescription
    }

    immunizations {
        DATE date
        UUID patient FK
        UUID encounter FK
        VARCHAR code
        TEXT description
        DECIMAL base_cost
    }

    devices {
        DATE start
        DATE stop
        UUID patient FK
        UUID encounter FK
        VARCHAR code
        TEXT description
        TEXT udi
    }

    observations {
        DATE date
        UUID patient FK
        UUID encounter FK
        VARCHAR category
        VARCHAR code
        TEXT description
        TEXT value
        VARCHAR units
        VARCHAR type
    }

    imaging_studies {
        UUID id PK
        VARCHAR instance_uid PK
        DATE date
        UUID patient FK
        UUID encounter FK
        VARCHAR series_uid
        VARCHAR bodysite_code
        TEXT bodysite_description
        VARCHAR modality_code
        TEXT modality_description
        VARCHAR sop_code
        TEXT sop_description
        VARCHAR procedure_code
    }

    supplies {
        DATE date
        UUID patient FK
        UUID encounter FK
        VARCHAR code
        TEXT description
        INTEGER quantity
    }

    payer_transitions {
        UUID patient FK
        VARCHAR memberid
        TIMESTAMPTZ start_year
        TIMESTAMPTZ end_year
        UUID payer FK
        UUID secondary_payer FK
        VARCHAR ownership
        VARCHAR ownername
    }

    claims {
        UUID id PK
        UUID patientid FK
        UUID providerid FK
        VARCHAR primarypatientinsuranceid
        VARCHAR secondarypatientinsuranceid
        INTEGER departmentid
        INTEGER patientdepartmentid
        VARCHAR diagnosis1
        VARCHAR diagnosis2
        VARCHAR diagnosis3
        VARCHAR diagnosis4
        VARCHAR diagnosis5
        VARCHAR diagnosis6
        VARCHAR diagnosis7
        VARCHAR diagnosis8
        UUID referringproviderid FK
        VARCHAR appointmentid
        DATE currentillnessdate
        DATE servicedate
        UUID supervisingproviderid FK
        VARCHAR status1
        VARCHAR status2
        VARCHAR statusp
        DECIMAL outstanding1
        DECIMAL outstanding2
        DECIMAL outstandingp
        DATE lastbilleddate1
        DATE lastbilleddate2
        DATE lastbilleddatep
        VARCHAR healthcareclaimtypeid1
        VARCHAR healthcareclaimtypeid2
    }

    claims_transactions {
        UUID id PK
        UUID claimid FK
        INTEGER chargeid
        UUID patientid FK
        VARCHAR type
        DECIMAL amount
        VARCHAR method
        DATE fromdate
        DATE todate
        VARCHAR placeofservice
        VARCHAR procedurecode
        VARCHAR modifier1
        VARCHAR modifier2
        INTEGER diagnosisref1
        INTEGER diagnosisref2
        INTEGER diagnosisref3
        INTEGER diagnosisref4
        DECIMAL units
        INTEGER departmentid
        TEXT notes
        DECIMAL unitamount
        VARCHAR transferoutid
        VARCHAR transfertype
        DECIMAL payments
        DECIMAL adjustments
        DECIMAL transfers
        DECIMAL outstanding
        VARCHAR appointmentid
        TEXT linenote
        VARCHAR patientinsuranceid
        VARCHAR feescheduleid
        UUID providerid FK
        UUID supervisingproviderid FK
    }

    %% Relationships
    organizations ||--o{ providers : "employs"
    organizations ||--o{ encounters : "hosts"

    providers ||--o{ encounters : "provides_care"
    providers ||--o{ claims : "primary_provider"
    providers ||--o{ claims : "referring_provider"
    providers ||--o{ claims : "supervising_provider"
    providers ||--o{ claims_transactions : "provider"
    providers ||--o{ claims_transactions : "supervising_provider"

    payers ||--o{ encounters : "covers"
    payers ||--o{ medications : "covers"
    payers ||--o{ payer_transitions : "primary_payer"
    payers ||--o{ payer_transitions : "secondary_payer"

    patients ||--o{ encounters : "receives_care"
    patients ||--o{ conditions : "has_condition"
    patients ||--o{ allergies : "has_allergy"
    patients ||--o{ medications : "takes_medication"
    patients ||--o{ careplans : "follows_careplan"
    patients ||--o{ procedures : "undergoes_procedure"
    patients ||--o{ immunizations : "receives_immunization"
    patients ||--o{ devices : "uses_device"
    patients ||--o{ observations : "has_observation"
    patients ||--o{ imaging_studies : "has_imaging"
    patients ||--o{ supplies : "uses_supply"
    patients ||--o{ payer_transitions : "has_payer_transition"
    patients ||--o{ claims : "patient_claim"
    patients ||--o{ claims_transactions : "patient_transaction"

    encounters ||--o{ conditions : "diagnosed_during"
    encounters ||--o{ allergies : "discovered_during"
    encounters ||--o{ medications : "prescribed_during"
    encounters ||--o{ careplans : "planned_during"
    encounters ||--o{ procedures : "performed_during"
    encounters ||--o{ immunizations : "given_during"
    encounters ||--o{ devices : "prescribed_during"
    encounters ||--o{ observations : "recorded_during"
    encounters ||--o{ imaging_studies : "performed_during"
    encounters ||--o{ supplies : "used_during"

    claims ||--o{ claims_transactions : "has_transactions"
```

## Database Statistics

- **Total Tables**: 18
- **Total Records**: 1,835,567
- **Key Entities**:
  - 1,163 Patients
  - 1,127 Organizations
  - 5,056 Providers
  - 10 Payers
  - 61,459 Encounters

## Key Relationships

1. **Core Healthcare Entities**:
   - Organizations employ Providers
   - Patients receive care through Encounters
   - Payers cover healthcare costs

2. **Clinical Data**:
   - Encounters generate Conditions, Procedures, Medications
   - Patients have Allergies, Devices, Observations
   - Imaging Studies and Supplies are linked to specific encounters

3. **Financial Data**:
   - Claims track billing for patient care
   - Claims Transactions detail financial movements
   - Payer Transitions track insurance changes over time

## Indexes

The database includes performance indexes on:

- Patient names (last, first)
- Encounter patient references
- Encounter date ranges
- Condition, medication, observation, and procedure patient references
- Claims patient references
- Claims transaction claim references
