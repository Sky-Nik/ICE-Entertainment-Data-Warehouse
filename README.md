# MIS774 — ICE Entertainment Data Warehouse

> Enterprise Data Management | Assessment 1 | Deakin University | Trimester 1, 2026

## Overview

This repository contains the design and implementation of a dimensional data warehouse for **ICE Entertainment** — a privately held global entertainment retailer headquartered in Melbourne, Australia, operating 500 stores across 10 countries with a catalogue spanning Music, Films, and Audio Books.

The data warehouse integrates two disconnected source systems — a **Sales System (Informix)** and an **ERP System (Oracle)** — into a unified star schema that enables management to answer critical business questions about sales performance, product profitability, store operations, and customer behaviour.

> *"The objective is to provide a global truth — a single source of data for all managerial reports."*
> — Dhil Rodnut, CEO, ICE Entertainment

---

## Business Problems Addressed

| # | Business Question | Dimension |
|---|---|---|
| Q1 | Who are the most valuable customers? | Customer, Date |
| Q2 | Which products are the most profitable? | Product, Date |
| Q3 | Which store locations are the most profitable? | Store, Date |
| Q4 | Which time periods generate the most revenue? | Date |
| Q5 | Which market segment is the most profitable? | Store (Market), Date |

---

## Repository Structure

```
MIS774-ICE-Entertainment-DW/
│
├── README.md
├── .gitignore
│
├── Dataset/
│   └── source/                        # Original source data files (read-only)
│       ├── Customer.xlsx
│       ├── Order_Header.xlsx
│       ├── Order_Details.xlsx
│       ├── Product.xlsx
│       ├── Store.xlsx
│       ├── Subscription.xlsx
│       └── ... (all reference/lookup tables)
│
├── SQL Scripts/
│   ├── 01_create_database.sql         # Create the dw database
│   ├── 02_dim_date.sql                # Date dimension (provided)
│   ├── 03_dim_customer.sql            # Customer dimension (SCD Type 2)
│   ├── 04_dim_product.sql             # Product dimension
│   ├── 05_dim_store.sql               # Store dimension
│   ├── 06_dim_subscription.sql        # Subscription dimension
│   ├── 07_dim_currency.sql            # Currency dimension
│   ├── 08_fact_sales.sql              # Central fact table
│   └── 09_analytical_queries.sql      # Management insight queries
│
├── Pentaho/                               # Pentaho Data Integration files
│   ├── load_dim_customer.ktr
│   ├── load_dim_product.ktr
│   ├── load_dim_store.ktr
│   ├── load_dim_subscription.ktr
│   ├── load_dim_currency.ktr
│   ├── load_fact_sales.ktr
│   └── master_job.kjb
│
├── Report/
│   ├── MIS774_Assessment1_Report.docx
│   └── screenshots/                   # MySQL Workbench diagrams, Pentaho screenshots
│
└── Docs/
    ├── data_dictionary.md
    └── meeting_notes.md
```

---

## Data Warehouse Design

### Star Schema

The warehouse is built as a **star schema** with one central fact table surrounded by six dimension tables:

| Table | Type | Description |
|---|---|---|
| `fact_sales` | Fact | One row per order line item. Stores qty, revenue, cost, and margin in USD |
| `dim_date` | Dimension | Calendar and fiscal date attributes (FY runs Sep–Aug) |
| `dim_customer` | Dimension | Customer demographics, location, market segment (SCD Type 2) |
| `dim_product` | Dimension | Product catalogue with 3-level hierarchy: Category → Type → Product |
| `dim_store` | Dimension | Store locations with 6-level geographic hierarchy |
| `dim_subscription` | Dimension | Customer subscription packages |
| `dim_currency` | Dimension | Monthly FX rates for USD conversion |

### Key Metrics (stored in fact_sales)

```
Dollar Sales (USD)  = qty × price × exchange_rate
Cost (USD)          = qty × unit_cost × exchange_rate
Margin (USD)        = Dollar Sales (USD) − Cost (USD)
```

### Source Systems

| System | Platform | Tables |
|---|---|---|
| Sales System | Informix | Customer, Order_Header, Order_Details, Store, Subscription |
| ERP System | Oracle | Product, Currency_Rate, Currency, Package |

---

## Technology Stack

| Tool | Purpose |
|---|---|
| **MySQL 8.0** | Data warehouse database |
| **MySQL Workbench** | Schema design and reverse engineering |
| **Pentaho Data Integration (PDI)** | ETL pipeline development |
| **SQL** | Dimensional model implementation and analytical queries |

---

## Team

| Member | Responsibility | Branch |
|---|---|---|
| TBD | SQL schema design | `feature/sql-schema` |
| TBD | Pentaho ETL transformations | `feature/etl-pentaho` |
| TBD | Analytical SQL queries | `feature/sql-queries` |
| TBD | Report write-up | `feature/report-writeup` |

---

## Getting Started

### Prerequisites
- MySQL 8.0+
- MySQL Workbench
- Pentaho Data Integration (Community Edition)
- Git

### Setup

```bash
# 1. Clone the repository
git clone https://github.com/yourteam/MIS774-ICE-Entertainment-DW.git
cd MIS774-ICE-Entertainment-DW

# 2. Create your working branch
git checkout -b feature/your-task

# 3. Run SQL scripts in order
mysql -u root -p < sql/01_create_database.sql
mysql -u root -p < sql/02_dim_date.sql
# ... continue in order
```

### Branch Workflow

```bash
# Before starting work each day
git pull origin dev

# After completing work
git add .
git commit -m "Brief description of what you did"
git push origin feature/your-branch

# Then open a Pull Request on GitHub → merge into dev
```

---

## Submission

**Due:** Thursday 23 April 2026, 8:00 PM AEST
**Format:** Single `.pdf` or `.docx` submitted via CloudDeakin

---

## Assessment Breakdown

| Deliverable | Weight | Description |
|---|---|---|
| Deliverable 1 | 75% | Report: Executive Summary, Data Strategy Canvas, Architecture, Dimensional Model, Business Problem Analysis, Data Dictionary |
| Deliverable 2 | 10% | SQL implementation + Pentaho ETL screenshots |
| Deliverable 3 | 15% | Minimum 5 analytical SQL queries with business insights |

---

> ⚠️ **Note:** The `/data/source/` files are read-only source data. Do not modify them. All transformations happen in the ETL layer.
