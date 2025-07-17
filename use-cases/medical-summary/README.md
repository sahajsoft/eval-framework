# Medical Summary Database

A PostgreSQL database containing synthetic medical data from Synthea, organized for medical summary generation and analysis.

## Project Structure

```
medical-summary/
├── database/                        # Database files
│   ├── 01-create-tables.sql         # Table creation script
│   ├── 02-load-initial-data.sql     # Data loading script
│   └── validate-data.sql            # Data validation queries
├── docs/                            # Documentation
│   └── database-schema-reference.md # Database schema documentation
├── source-data/                     # Compressed CSV data files (18 .csv.gz files)
├── docker-compose.yml               # Docker Compose configuration
└── README.md                        # This file
```

## Quick Start

1. **Start the database:**

   ```bash
   docker compose up -d
   ```

   This automatically:
   - Creates the PostgreSQL database
   - Initializes all tables
   - Decompresses and loads all CSV data (1.9+ million records)

2. **Verify the data:**

   ```bash
   docker exec medical_summary_db psql -U medical_user -d medical_summary -f /tmp/validate-data.sql
   ```

3. **Connect to the database:**
   ```bash
   docker exec -it medical_summary_db psql -U medical_user -d medical_summary
   ```

## Database Details

- **Database:** medical_summary
- **User:** medical_user
- **Password:** medical_pass
- **Port:** 5434 (mapped from container's 5432)

## Data Overview

The database contains 18 tables with synthetic medical data:

- **Core Tables:** patients (1,163), providers (5,056), organizations (1,127)
- **Clinical Data:** encounters (61,459), conditions (38,094), medications (56,430)
- **Administrative:** claims (117,889), payers (10), observations (531,144)
- **Additional:** allergies, careplans, immunizations, procedures, and more

### Data Storage

All CSV data files are stored in compressed format (gzip) to reduce repository size:

- **Original size:** ~539MB
- **Compressed size:** ~56MB (89% reduction)
- **Automatic decompression:** Files are decompressed on-the-fly during database initialization
- **No manual steps required:** Docker setup handles everything automatically

See [docs/database-schema-reference.md](docs/database-schema-reference.md) for detailed schema information.

## Development

### Data Validation

Run validation queries:

```bash
docker exec medical_summary_db psql -U medical_user -d medical_summary -f /tmp/validate-data.sql
```

### Stop the Database

```bash
docker compose down       # Stop containers
docker compose down -v    # Stop and remove volumes (data will be lost)
```

## Configuration

Database credentials are configured in `docker-compose.yml`. The default configuration is suitable for local development.
