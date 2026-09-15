# Power BI Build Steps

1. Open Power BI Desktop.
2. Get Data → Text/CSV → import `data/companies.csv` and the prepared price-history CSV.
3. Rename the price table to `PriceHistory`.
4. Model view: create `Companies[Ticker]` (1) → `PriceHistory[Ticker]` (*).
5. Set `PriceHistory[Date]` to Date, `Close` to Decimal Number, and `Volume` to Whole Number.
6. Create all measures from `documentation/dax_measures.csv`.
7. Build three report pages:
   - **Executive Overview**: KPI cards, price trend, sector comparison, ticker/sector/date slicers.
   - **Sector Analysis**: sector returns, company comparison table, sector trend.
   - **Company Drill-Down**: price trend, latest/period return/max/min cards, detail table.
8. Save the report as `dashboard/sp500_financial_analytics.pbix`.

## Important
The downloadable demo price-history CSV supplied with the project pack is **simulated data for dashboard assembly only**. Replace it with real market data from the repository's Python/yfinance pipeline before publishing screenshots or interpreting performance results.
