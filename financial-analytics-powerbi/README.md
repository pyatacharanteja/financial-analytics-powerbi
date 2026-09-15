# S&P 500 Financial Analytics — Power BI

A research-style financial analytics portfolio project combining **Power BI, DAX, Power Query, Python, SQL, and reproducible data modeling** to study market performance, sector trends, volatility, and company-level behavior.

## 🌐 Live Web Dashboard

A browser-based version of the dashboard is included under `docs/` and is designed to be published with **GitHub Pages**.

**Live dashboard URL after GitHub Pages is enabled:**  


The web dashboard includes:
- ticker selector
- latest-close KPI
- period-return KPI
- average-volume KPI
- maximum-close KPI
- interactive price-trend chart
- ticker performance comparison
- latest-observations table
- responsive desktop/mobile layout

> The current web dashboard uses a clearly labeled **simulated demo dataset for UI prototyping**. It must not be presented as live market performance. The Power BI and Python workflows in this repository contain the real-data pipelines.

### Enable GitHub Pages
In the repository, go to **Settings → Pages → Build and deployment → Deploy from a branch**, choose **main** and **/docs**, then click **Save**. GitHub will publish the dashboard at the URL above.

## Project Objective
Build an end-to-end financial analytics solution that moves from public market data to a documented semantic model and interactive decision-support dashboard.

## Dashboard Design
The report is designed around three Power BI pages:

1. **Executive Overview** — latest close, daily return, period return, average volume, market trend, and sector comparison.
2. **Sector Analysis** — sector ranking, company comparison, and sector trend analysis.
3. **Company Drill-Down** — company-specific price history, return KPIs, high/low values, and trading-volume detail.

The `docs/` folder provides a separate browser-native dashboard so the project can also be reviewed without Power BI Desktop.

## Data Sources

This project intentionally documents every data input used by the model so the analysis can be reproduced and audited.

### 1. Stooq — live Power BI market-price source
**Source:** https://stooq.com/

The Power Query pipeline in `powerbi/queries/PriceHistory.m` downloads daily market data directly from Stooq's public CSV endpoint. The current model requests data from **January 1, 2025 through the refresh date** for the selected securities.

**Fields used:** Date, Open, High, Low, Close, Volume, and Ticker.

**Current symbols:** AAPL, MSFT, NVDA, AMZN, GOOGL, META, JPM, V, XOM, and WMT.

**Purpose:** Primary web source for the Power BI `Price History` fact table and dashboard refresh workflow.

### 2. Yahoo Finance via `yfinance` — Python analytics source
**Source:** https://finance.yahoo.com/  
**Python package:** https://github.com/ranaroussi/yfinance

The reproducible Python workflow in `python/market_analysis.py` uses `yfinance` to download adjusted historical market prices beginning **January 1, 2021** for AAPL, MSFT, GOOGL, AMZN, NVDA, META, JPM, and XOM.

The script generates:
- `data/daily_prices.csv`
- `data/daily_returns.csv`
- `data/company_metrics.csv`

Derived metrics include total return, annualized volatility, average daily return, and maximum drawdown.

**Purpose:** Independent Python-based quantitative-analysis workflow and reproducible dataset generation outside Power BI.

> `yfinance` is an open-source client that retrieves Yahoo Finance market information. Yahoo Finance and `yfinance` are not treated as an official exchange feed in this portfolio project.

### 3. Company / sector lookup — project-maintained reference table
The `Companies` dimension is maintained directly inside the project in `powerbi/queries/Companies.m` and is also represented in the project data resources.

**Fields:** Ticker, Company, Sector.

**Current companies:** Apple, Microsoft, NVIDIA, Amazon, Alphabet, Meta Platforms, JPMorgan Chase, Visa, Exxon Mobil, and Walmart.

**Purpose:** Supplies readable company names and sector classifications used for filtering, relationships, drill-downs, and sector-level comparisons.

This is a **project-maintained analytical lookup**, not a live S&P Dow Jones Indices constituent feed. The repository should therefore not be interpreted as an authoritative or complete current S&P 500 constituent dataset.

### 4. Simulated demo dataset — dashboard prototyping only
`price_history_demo.csv` and `docs/data/market_data.csv` are **synthetically generated demonstration datasets** used only for assembling/testing dashboard layouts when a web refresh is unavailable.

**Purpose:** UI development, relationship testing, GitHub Pages previewing, and Power BI prototyping.

> **Important:** Simulated values must never be presented as actual market performance, research results, or historical S&P 500 observations. Published real-data screenshots/results should use refreshed public market data.

### Data-source summary
| Source | Access method | Main use | Status |
|---|---|---|---|
| Stooq | Power Query `Web.Contents` + CSV | Power BI OHLCV price history | Public web market data |
| Yahoo Finance | Python `yfinance` | Prices, returns, volatility, drawdown analysis | Public web data via third-party Python client |
| Project-maintained Companies table | Power Query / repository data | Ticker, company and sector dimension | Curated project reference data |
| Simulated demo price history | Repository CSV | Dashboard prototyping / GitHub Pages preview | Synthetic — not real market data |

## Data Model
- `Companies` — company/ticker/sector lookup table.
- `Price History` — daily OHLCV market observations.
- Relationship: `Companies[Ticker]` **1 → *** `Price History[Ticker]`.
- Import-mode semantic model with reusable DAX measures.

## Core DAX Measures
- Latest Close
- Previous Close
- Daily Return %
- Start Period Close
- Period Return %
- Average Close
- Average Volume
- Max Close
- Min Close

## Data Pipeline

```text
Stooq public CSV endpoint
        ↓
Power Query / Web.Contents
        ↓
Price History fact table
        ↓
Companies dimension
        ↓
Power BI semantic model + DAX
        ↓
Executive / Sector / Company dashboards

Yahoo Finance
        ↓
yfinance + Pandas
        ↓
Prices / Returns / Metrics CSVs
        ↓
Independent quantitative analysis

Simulated demo CSV
        ↓
GitHub Pages dashboard
        ↓
Browser-based portfolio preview
```

## Data Limitations
- Public third-party market endpoints may change, throttle requests, contain gaps, or become temporarily unavailable.
- Market-price conventions and adjustments can differ across providers, so Stooq and Yahoo-derived values should not automatically be expected to match exactly.
- The current company universe is a selected portfolio sample, not the complete S&P 500 index.
- The project-maintained sector lookup should be reviewed before using the project for time-sensitive constituent/sector research.
- The GitHub Pages dashboard is currently a UI prototype using synthetic data.
- This project is for portfolio, research-preparation, and educational analytics purposes; it is not investment advice or an official market-data product.

## Repository Structure
```text
powerbi-project/     PBIP/TMDL source for the Power BI model
powerbi/             Power Query, DAX, theme, and build resources
dashboard/           location for exported/saved PBIX file
python/              market-data preparation and quantitative analysis
sql/                 analytical SQL examples
data/                public/demo datasets and documentation
docs/                GitHub Pages interactive web dashboard
images/              dashboard screenshots
documentation/       methodology, data dictionary, and model notes
```

## Research / Analytical Questions
- Which sectors outperform over a selected period?
- How do company returns and volatility differ across sectors?
- Which securities experience the largest drawdowns?
- How sensitive are rankings to the selected time window?
- Can a transparent BI model provide reproducible financial decision support?

## Technology
`Power BI` `DAX` `Power Query` `Python` `Pandas` `SQL` `Excel` `Git` `HTML` `CSS` `JavaScript` `GitHub Pages`

## Reproducibility
The project documents data sources, transformations, measures, assumptions, and limitations so another analyst can reproduce the model rather than relying only on dashboard screenshots.

## Status
🚀 **Active development.** Power BI semantic-model source, Power Query connection logic, DAX measures, Python pipeline, SQL examples, and the browser-based GitHub Pages dashboard are included. The Desktop-saved `.pbix` still requires Power BI Desktop for final creation and validation.

## Author
**Pyata Charan Teja**  
Computer Science — IIT(ISM)Dhanbad 

