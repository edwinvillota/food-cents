# Food Cents

**Version:** 0.0.1-SNAPSHOT  
**Author:** Edwin Villota

## Project Description

Food Cents is a Spring Boot application designed to manage and track food-related expenses. This project leverages various Spring Boot features along with other powerful tools and libraries such as Lombok, JSON Web Tokens (JJWT), Flyway for database migrations, and PostgreSQL for data persistence.

## Prerequisites

To build and run this project, ensure you have the following installed:

- **JDK 21** or later
- **Maven 3.6.3** or later
- **PostgreSQL** (for database)

## Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/yourusername/food-cents.git
   cd food-cents
   ```

2. **Build the project using Maven**
   ```bash
   mvn clean install
   ```

## Configuration

This project requires certain environment variables to be set for connecting to the PostgreSQL database and for other configurations:

```bash
export POSTGRE_DB_URL=jdbc:postgresql://localhost:5432/foodcents
export POSTGRE_DB_USER=fc_user
export POSTGRE_DB_PASSWORD=fc_user_password
## JWT_SECRET_KEY for local environment
export AUTH_JWT_SECRET_KEY=1cce4e63d310f77155508b82a46121e579f8f1aabc5d3fbc6a1480f7a1ea16ca
```

These environment variables are used by the Flyway Maven plugin to manage database migrations.

### Application properties

You can configure additional properties in the `src/main/resources/application.properties` or `application.yml` file. Common settings include server port, database configurations, and application-specific properties.

## Running the Application

You can run the application using Maven:

```bash
./mvnw spring-boot:run
```

Alternatively, you can package the application into a JAR file and run it:

```bash
./mvnw clean package
java -jar target/food-cents-0.0.1-SNAPSHOT.jar
```

### Accessing the Application

- The application will be available at `http://localhost:8080` by default.
- You can modify the port and other configurations in the `application.properties` file.

## Database Migration

The project uses Flyway for database versioning and migrations. Flyway is configured to connect to the PostgreSQL database using the environment variables mentioned above. Migrations are automatically applied on application startup.

To manually run migrations, use the following command:

```bash
  ./mvnw flyway:migrate
```

## Testing

The project includes unit and integration tests. To run the tests, use:

```bash
./mvnw test
```
