# Example 3: Custom SQL Migration Script

#!/bin/sh

# Custom SQL Database Migration Script

# Set database connection parameters
DB_HOST="db_host"
DB_PORT="5432"
DB_NAME="db_name"
DB_USER="db_user"
DB_PASSWORD="db_password"

# Execute SQL migration scripts
psql postgresql://$DB_USER:$DB_PASSWORD@$DB_HOST:$DB_PORT/$DB_NAME << EOF
BEGIN;

-- Example migration SQL statements
CREATE TABLE example_table (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

INSERT INTO example_table (name) VALUES ('Example 1'), ('Example 2');

COMMIT;
EOF