# Task Overview

Utkrusht operates a SaaS platform with multiple client organizations (tenants), each managing its own set of users. Users may have a 'basic', 'pro', or 'enterprise' subscription tier. The engineering team needs a robust backend foundation for CRUD operations on tenants and users, supporting efficient queries and safe async DB access. You are to define the PostgreSQL schema, create DB models, and implement the FastAPI API logic for key CRUD endpoints, wiring everything up with async SQLAlchemy.

## Guidance
- Starter FastAPI structure, Docker/PostgreSQL environment, and file organization are provided.
- See `schema.sql` for where to implement your PostgreSQL schema.
- `app/models.py` is for your SQLAlchemy ORM models.
- Use `run.sh` to bring up Dockerized Postgres/FastAPI and apply your schema.

## Objectives
- Define normalized PostgreSQL tables for tenants, users, and user subscription (use ENUM/constraints for tiers).
- Implement SQLAlchemy models mirroring your schema.
- In `main.py`, implement CRUD async endpoints for tenants and users using dependency-injected DB sessions.
- Ensure all DB operations are non-blocking and manage relationships via SQL and ORM.
- Apply foreign keys and constraints to prevent orphaned records and ensure every user belongs to a tenant.

## How to Verify
- On running `run.sh`, database tables and constraints should exist (check in pgAdmin or psql).
- CRUD operations via API endpoints for tenants and users should work (e.g., POST/GET/PUT/DELETE), including subscription tier assignment.
- Users cannot exist without a valid tenant, and deleting a tenant should remove associated users.
- Use `/docs` on the running API server to experiment and confirm correct relationship behavior.