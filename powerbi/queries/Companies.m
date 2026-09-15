let
    Source = #table(
        type table [Ticker=text, Company=text, Sector=text],
        {
            {"AAPL", "Apple Inc.", "Information Technology"},
            {"MSFT", "Microsoft Corp.", "Information Technology"},
            {"NVDA", "NVIDIA Corp.", "Information Technology"},
            {"AMZN", "Amazon.com Inc.", "Consumer Discretionary"},
            {"GOOGL", "Alphabet Inc. Class A", "Communication Services"},
            {"META", "Meta Platforms Inc.", "Communication Services"},
            {"JPM", "JPMorgan Chase & Co.", "Financials"},
            {"V", "Visa Inc.", "Financials"},
            {"XOM", "Exxon Mobil Corp.", "Energy"},
            {"WMT", "Walmart Inc.", "Consumer Staples"}
        }
    )
in
    Source
