# Fupre Info Portal

This is a Rails application for the Fupre Info Portal.

## System Dependencies

* Ruby 3.1.2
* PostgreSQL
* Node.js
* Yarn

## Configuration

1.  **Database Configuration**: The application uses PostgreSQL in production. The database connection is configured using the `DATABASE_URL` environment variable. In development, it uses SQLite3.

2.  **Application Configuration**: The `config/application.yml` file is used for application-specific configuration. This file is managed by the `figaro` gem. You should create this file and add your configuration values. See `config/application.yml.example` for a template.

3.  **Environment Variables**: The following environment variables are required for production:
    *   `DATABASE_URL`: The URL of your PostgreSQL database.
    *   `RAILS_MASTER_KEY`: The master key for decrypting credentials.
    *   `RAILS_SERVE_STATIC_FILES`: Set to `true` to enable serving static files in production.

## Database Creation and Initialization

1.  **Create the database**:
    ```bash
    rails db:create
    ```

2.  **Run migrations**:
    ```bash
    rails db:migrate
    ```

3.  **Seed the database**:
    ```bash
    rails db:seed
    ```

## How to Run the Test Suite

To run the test suite, use the following command:

```bash
rspec
```

## Services

*   **Job Queues**: This application does not currently use a job queue.
*   **Cache Servers**: This application does not currently use a cache server.
*   **Search Engines**: This application uses basic SQL `LIKE` queries for searching.

## Deployment Instructions

1.  **Install dependencies**:
    ```bash
    bundle install
    yarn install
    ```

2.  **Precompile assets**:
    ```bash
    rails assets:precompile
    ```

3.  **Run database migrations**:
    ```bash
    rails db:migrate
    ```

4.  **Start the application server**:
    ```bash
    rails server -e production
    ```

## Admin User Creation

To create an admin user, run the following command:

```bash
rails admin:create
```

You will be prompted to enter an email and password for the new admin user.

## Troubleshooting

*   **"Figaro not found" error**: If you see this error, run `bundle install` to install the `figaro` gem.
*   **"PG::ConnectionBad" error**: This error indicates that the application cannot connect to the PostgreSQL database. Make sure that the `DATABASE_URL` environment variable is set correctly and that the database server is running.

## Backup and Maintenance

*   **Database Backups**: It is recommended to set up regular backups of your PostgreSQL database.
*   **Maintenance Mode**: This application does not have a built-in maintenance mode. You can use a tool like `capistrano-maintenance` to manage maintenance mode.
