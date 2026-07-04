# Superstore Sales Performance & Profitability Analysis

An end-to-end data analysis project exploring sales performance and profitability using **Python**, **SQL**, and **Power BI**.

## 📊 Dashboard

![Superstore Dashboard](images/dashboard_screenshot.png)

## 🔧 Tools Used
- **Python** (Pandas) — data cleaning and exploratory visualization
- **MySQL** — relational data modeling and analysis
- **Power BI** — interactive dashboard and reporting

## 🗂️ Project Structure
```
├── data/
│   ├── raw/                 # Original Excel file (products, orders, sales, customers)
│   └── cleaned/              # Cleaned CSVs, ready for SQL
├── python/
│   └── data_cleaning.ipynb   # Data cleaning + exploratory charts
├── sql/
│   └── queries.sql           # 9 analytical queries (joins, aggregation, subqueries, window functions, CASE)
├── powerbi/
│   └── superstore_dashboard.pbix
└── images/
    └── dashboard_screenshot.png
```

## 🧹 Data Cleaning (Python)
Working across 4 related tables (products, orders, sales, customers):
- Removed 200 duplicate records from the sales table
- Handled missing values with context-driven decisions — median imputation for numeric fields (`quantity`, `discount`), transparent "Unknown" labeling for categorical fields (`sub_category`, `ship_mode`, `customer_name`)
- Validated data integrity — checked for negative sales/profit anomalies, inconsistent text formatting, and mismatched keys before merging
- Verified referential integrity across all 4 tables before exporting cleaned CSVs

## 🗃️ SQL Analysis
Loaded the cleaned data into MySQL and wrote 9 queries covering:
- Multi-table joins (2-table and 3-table)
- Aggregation with `GROUP BY`, filtering aggregates with `HAVING`
- Date-based trend analysis (`DATE_FORMAT`)
- Scalar subqueries (profit share of total)
- Window functions (`RANK() OVER PARTITION BY`) for top products per category
- `CASE` statements for profit-tier bucketing

See [`sql/queries.sql`](sql/queries.sql) for the full set.

## 📈 Key Findings
- **Technology drives the highest sales ($3.3M)** but shows a proportionally weaker profit margin compared to Furniture and Office Supplies
- **The West region leads in both sales ($1.5M) and profit ($0.25M)**, making it the strongest-performing region
- **The South region lags behind** all other regions in both sales and profit, suggesting an area worth investigating further
- Discount levels show a noticeable relationship with profit — heavier discounting tends to correspond with lower profit margins across categories

## 📌 Dashboard Features
- KPI cards: Total Sales, Total Profit, Profit Margin %, Total Orders
- Sales & Profit breakdown by Category and Region
- Monthly sales trend over time
- Top 10 products by sales
- Interactive slicers (Category, Region, Segment) for dynamic filtering

---
*Built as a portfolio project to demonstrate the full analytics pipeline: data cleaning → SQL analysis → dashboard reporting.*
