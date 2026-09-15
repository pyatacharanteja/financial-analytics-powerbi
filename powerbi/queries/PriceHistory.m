let
    StartDate = #date(2025, 1, 1),
    EndDate = Date.From(DateTime.LocalNow()),
    Tickers = {
        [Ticker="AAPL", Stooq="aapl.us"],
        [Ticker="MSFT", Stooq="msft.us"],
        [Ticker="NVDA", Stooq="nvda.us"],
        [Ticker="AMZN", Stooq="amzn.us"],
        [Ticker="GOOGL", Stooq="googl.us"],
        [Ticker="META", Stooq="meta.us"],
        [Ticker="JPM", Stooq="jpm.us"],
        [Ticker="V", Stooq="v.us"],
        [Ticker="XOM", Stooq="xom.us"],
        [Ticker="WMT", Stooq="wmt.us"]
    },
    GetStock = (Ticker as text, Symbol as text) as table =>
        let
            D1 = Date.ToText(StartDate, "yyyyMMdd"),
            D2 = Date.ToText(EndDate, "yyyyMMdd"),
            Url = "https://stooq.com/q/d/l/?s=" & Symbol & "&d1=" & D1 & "&d2=" & D2 & "&i=d",
            Raw = Csv.Document(Web.Contents(Url), [Delimiter=",", Encoding=65001, QuoteStyle=QuoteStyle.Csv]),
            Headers = Table.PromoteHeaders(Raw, [PromoteAllScalars=true]),
            Typed = Table.TransformColumnTypes(Headers, {
                {"Date", type date}, {"Open", type number}, {"High", type number},
                {"Low", type number}, {"Close", type number}, {"Volume", Int64.Type}
            }),
            AddTicker = Table.AddColumn(Typed, "Ticker", each Ticker, type text)
        in
            AddTicker,
    Tables = List.Transform(Tickers, each GetStock(_[Ticker], _[Stooq])),
    Combined = Table.Combine(Tables),
    Sorted = Table.Sort(Combined, {{"Ticker", Order.Ascending}, {"Date", Order.Ascending}})
in
    Sorted
