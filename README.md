# Book Notes using NodeJS & PostgreSQL
# Environment vars
This project uses the following environment variables:

| Name                          | Description                         | Default Value                                  |
| ----------------------------- | ------------------------------------| -----------------------------------------------|
|PG_USER           | User of pgAdmin4            | "postgres"      |
|PG_HOST           | Hostname PostgreSQL database server       | "localhost"      |
|PG_DATABASE           |  Name of the PostgreSQL database       | "book_notes"      |
|PG_PASSWORD           |  Password required when connecting to the PostgreSQL database       | ""      |
|PG_PORT           |  Port number for PostgreSQL database connections      | "5432"      |


# Pre-requisites
- Install [Node.js](https://nodejs.org/en/) version 20.11.1
- Create a PostgreSQL database named "book_notes" and create required tables (See book_notes_database.sql)


# Getting started
- Clone the repository
```
git clone  <git lab template url> <project_name>
```
- Install dependencies
```
cd <project_name>
npm install
```
- Run the project
```
node index.js
```
  Navigate to `http://localhost:3000`
