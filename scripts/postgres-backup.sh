#!/bin/bash

# Set PostgreSQL credentials and backup directory path
PGUSER="postgres"
PGHOST="localhost"
BACKUP_DIR="/tmp/db_backups"

# Create the backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Get list of all non-template databases except 'postgres' and 'repmgr'
# -tA: outputs tuples only, no headers or formatting
DB_LIST=$(psql -U "$PGUSER" -h "$PGHOST" -tA -c "SELECT datname FROM pg_database WHERE datistemplate = false AND datname NOT IN ('postgres') AND datname NOT IN ('repmgr');")

# Loop through each database and dump it
for DB in $DB_LIST; do 
	echo "dumping the db : $DB"

        # Define the output filename for the current database dump
        FILENAME="${BACKUP_DIR}/${DB}.dump"

        # Use pg_dump with custom format (-Fc) to dump the database
	pg_dump -U "$PGUSER" -h "$PGHOST" -Fc "$DB" > "$FILENAME"

	# Check if the pg_dump command was successful
	if [ $? -eq 0 ]; then
		echo " Successfully dumped : $FILENAME"
	else
		echo "Not able to dump this file: $DB"
	fi
done

# Final message when all dumps are completed
echo "🎉 All database dumps completed and stored in: $BACKUP_DIR"