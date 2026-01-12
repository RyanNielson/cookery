# Repository Guidelines

## Project Structure & Module Organization
- `app/` holds Rails MVC code, mailers, jobs, and assets. Stimulus controllers live in `app/javascript/controllers`, styles in `app/assets` and `app/assets/tailwind`.
- `config/` contains application, environment, and deployment configuration.
- `db/` includes migrations, schema, and seeds.
- `test/` contains Minitest suites and fixtures (`test/fixtures`).
- `public/` serves static files and error pages; `storage/` and `tmp/` are runtime data.

## Build, Test, and Development Commands
- `bin/setup` installs dependencies and prepares the database for local development.
- `bin/dev` starts the development Procfile via Foreman (web, assets, etc.).
- `bin/rails server` runs the app server directly (useful for debugging a single process).
- `bin/rails db:migrate` applies database migrations.
- `bin/rails test` runs the full test suite; pass a path to scope, e.g. `bin/rails test test/models/user_test.rb`.
- `bin/rubocop` and `bin/brakeman` run style and security checks.

## Coding Style & Naming Conventions
- Ruby uses 2-space indentation and Rails conventions; follow RuboCop Rails Omakase rules.
- Files and methods: `snake_case`; classes and modules: `CamelCase`.
- View partials use a leading underscore, e.g. `app/views/shared/_flash.html.erb`.
- Migrations use timestamped names, e.g. `db/migrate/20260111033949_create_users.rb`.

## Testing Guidelines
- Tests are Minitest-based in `test/` with fixtures in `test/fixtures`.
- Name test files `*_test.rb` and keep tests close to their domain (models, controllers, mailers).
- No explicit coverage target is enforced; add tests for new behavior and regressions.

## Commit & Pull Request Guidelines
- Commit messages are short and imperative (e.g., "add authentication").
- PRs should describe the change, list test commands run, and include screenshots for UI changes.
- Link any related issues and call out migrations or config changes explicitly.

## Security & Configuration Notes
- Secrets live in `config/credentials.yml.enc`; avoid committing plaintext secrets.
- Environment-specific settings are in `config/environments/` and `config/database.yml`.

## Implementation guidelines
- When it makes sense and is possible, use rails generators like `bin/rails g scaffold` and `bin/rails generate controller` to ensure that files are organized as closely as possible to Rails best practices.
- Before doing any coding, make a step by step plan covering how the request will be implemented and get approval.