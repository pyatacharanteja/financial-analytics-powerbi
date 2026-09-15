-- Example analytical queries for a table named company_metrics.

-- Rank companies by total return
SELECT
    ticker,
    total_return,
    annualized_volatility,
    max_drawdown,
    DENSE_RANK() OVER (ORDER BY total_return DESC) AS return_rank
FROM company_metrics
ORDER BY return_rank;

-- Risk-adjusted comparison proxy
SELECT
    ticker,
    total_return,
    annualized_volatility,
    CASE
        WHEN annualized_volatility = 0 THEN NULL
        ELSE total_return / annualized_volatility
    END AS return_to_volatility
FROM company_metrics
ORDER BY return_to_volatility DESC;

-- Companies with drawdowns worse than 30 percent
SELECT ticker, max_drawdown
FROM company_metrics
WHERE max_drawdown <= -0.30
ORDER BY max_drawdown;
