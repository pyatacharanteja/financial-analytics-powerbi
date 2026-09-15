-- Financial Analytics SQL
-- Supporting analytical queries for the Power BI financial analytics project.

-- Monthly performance by ticker
SELECT
    ticker,
    DATE_TRUNC('month', trade_date) AS month,
    AVG(close_price) AS avg_close,
    MAX(close_price) AS max_close,
    MIN(close_price) AS min_close,
    SUM(volume) AS total_volume
FROM price_history
GROUP BY ticker, DATE_TRUNC('month', trade_date)
ORDER BY month, ticker;

-- Period return by ticker
WITH ranked_prices AS (
    SELECT
        ticker,
        trade_date,
        close_price,
        FIRST_VALUE(close_price) OVER (
            PARTITION BY ticker ORDER BY trade_date
        ) AS first_close,
        FIRST_VALUE(close_price) OVER (
            PARTITION BY ticker ORDER BY trade_date DESC
        ) AS last_close
    FROM price_history
)
SELECT
    ticker,
    ROUND(((MAX(last_close) / NULLIF(MAX(first_close), 0)) - 1) * 100, 2) AS period_return_pct
FROM ranked_prices
GROUP BY ticker
ORDER BY period_return_pct DESC;

-- Volatility summary
WITH daily_returns AS (
    SELECT
        ticker,
        trade_date,
        (close_price / NULLIF(LAG(close_price) OVER (
            PARTITION BY ticker ORDER BY trade_date
        ), 0)) - 1 AS daily_return
    FROM price_history
)
SELECT
    ticker,
    COUNT(daily_return) AS observations,
    AVG(daily_return) AS avg_daily_return,
    STDDEV_SAMP(daily_return) AS daily_volatility
FROM daily_returns
WHERE daily_return IS NOT NULL
GROUP BY ticker
ORDER BY daily_volatility DESC;
