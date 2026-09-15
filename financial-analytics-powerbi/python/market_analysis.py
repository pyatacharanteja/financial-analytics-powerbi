from pathlib import Path
import pandas as pd
import yfinance as yf

TICKERS = ["AAPL", "MSFT", "GOOGL", "AMZN", "NVDA", "META", "JPM", "XOM"]
START = "2021-01-01"


def download_prices(tickers=TICKERS, start=START):
    data = yf.download(tickers, start=start, auto_adjust=True, progress=False)
    close = data["Close"] if isinstance(data.columns, pd.MultiIndex) else data[["Close"]]
    return close


def build_metrics(close):
    returns = close.pct_change()
    summary = pd.DataFrame({
        "start_price": close.iloc[0],
        "end_price": close.iloc[-1],
        "total_return": close.iloc[-1] / close.iloc[0] - 1,
        "annualized_volatility": returns.std() * (252 ** 0.5),
        "avg_daily_return": returns.mean(),
        "max_drawdown": ((close / close.cummax()) - 1).min(),
    }).reset_index().rename(columns={"index": "ticker"})
    return summary, returns


def main():
    Path("data").mkdir(exist_ok=True)
    close = download_prices()
    summary, returns = build_metrics(close)
    close.to_csv("data/daily_prices.csv")
    returns.to_csv("data/daily_returns.csv")
    summary.to_csv("data/company_metrics.csv", index=False)
    print(summary.sort_values("total_return", ascending=False).round(4))


if __name__ == "__main__":
    main()
