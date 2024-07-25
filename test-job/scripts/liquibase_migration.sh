# Example 2: Using Liquibase for Database Migration

#!/bin/sh

# Set the Liquibase configuration
LIQUIBASE_URL="jdbc:postgresql://db_host:5432/db_name"
LIQUIBASE_USERNAME="db_user"
LIQUIBASE_PASSWORD="db_password"
CHANGELOG_FILE="db/changelog.xml"

# Run Liquibase migration
liquibase --url="$LIQUIBASE_URL" --username="$LIQUIBASE_USERNAME" --password="$LIQUIBASE_PASSWORD" --changeLogFile="$CHANGELOG_FILE" update
