# Report Build Specification

## Page 1 — Executive Overview

**Purpose:** fast market and portfolio-level summary.

### Slicers
- Ticker — `Companies[Ticker]`
- Sector — `Companies[Sector]`
- Date — `'Price History'[Date]`

### KPI cards
- Latest Close — `[Latest Close]`
- Daily Return — `[Daily Return %]`
- Period Return — `[Period Return %]`
- Average Volume — `[Average Volume]`

### Charts
- Line chart: Axis = `'Price History'[Date]`; Values = `'Price History'[Close]`; Legend optional = `Companies[Ticker]`.
- Bar chart: Axis = `Companies[Sector]`; Values = `[Average Company Period Return %]`.
- Table: `Companies[Ticker]`, `Companies[Company]`, `[Latest Close]`, `[Period Return %]`.

## Page 2 — Sector Analysis

**Purpose:** compare performance across sectors and companies.

### Visuals
- Ranked bar chart: `Companies[Sector]` by `[Average Company Period Return %]`.
- Matrix: Rows = Sector, Company; Values = Latest Close, Period Return %, Average Volume.
- Line chart: Date by Average Close, filtered by Sector.
- Company comparison table: Ticker, Company, Period Return %, Max Close, Min Close.

## Page 3 — Company Drill-Down

**Purpose:** examine one security in detail.

### Slicer
- Single-select `Companies[Ticker]`.

### KPI cards
- Latest Close
- Daily Return %
- Period Return %
- Max Close
- Min Close

### Charts
- Line chart: Date vs Close.
- Column chart: Date vs Volume.
- Detail table: Date, Open, High, Low, Close, Volume.

## Formatting
- Import `powerbi/theme.json`.
- Use a clean white background and compact spacing.
- Apply conditional formatting to return measures: positive values visually distinguished from negative values.
- Keep no more than 6–8 visuals per page.
- Add a small footer: `Public market data | Portfolio project by Lokesh Kancharla`.

## Validation Checklist
- Confirm Company → Price History relationship is one-to-many.
- Confirm Date is typed as Date/DateTime.
- Confirm return measures respond correctly to Date/Ticker filters.
- Confirm the Web source refreshes without credentials beyond Anonymous access.
- Do not publish dashboard screenshots until the data refresh has been validated in Power BI Desktop.
