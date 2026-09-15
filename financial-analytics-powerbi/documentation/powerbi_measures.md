# Power BI Measure Ideas

Use the generated `daily_prices.csv`, `daily_returns.csv`, and `company_metrics.csv` as model inputs.

## Suggested KPIs
- Total Return
- Annualized Volatility
- Maximum Drawdown
- Average Daily Return
- Return Rank
- Return-to-Volatility ratio

## Example DAX
```DAX
Average Total Return = AVERAGE(company_metrics[total_return])

Average Volatility = AVERAGE(company_metrics[annualized_volatility])

Best Performer =
VAR TopTicker =
    TOPN(1, company_metrics, company_metrics[total_return], DESC)
RETURN
    CONCATENATEX(TopTicker, company_metrics[ticker], ", ")

Risk Adjusted Return =
DIVIDE(
    AVERAGE(company_metrics[total_return]),
    AVERAGE(company_metrics[annualized_volatility])
)
```

## Suggested Pages
1. Executive Overview
2. Company Comparison
3. Risk & Drawdown Analysis
4. Price and Return Trends
5. Methodology / Data Notes
