SELECT 'CREATE DATABASE foodcents'
WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'foodcents')\gexec