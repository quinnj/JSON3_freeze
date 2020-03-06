using JSON3, StructTypes
data="""{"latestCandles":[{"instrument":"EUR_USD","granularity":"M1","candles":[{"complete":true,"volume":15,"time":"2020-02-21T21:58:00.000000000Z","bid":{"o":"1.08472","h":"1.08472","l":"1.08447","c":"1.08467"},"ask":{"o":"1.08506","h":"1.08567","l":"1.08497","c":"1.08567"}},{"complete":true,"volume":13,"time":"2020-02-21T21:59:00.000000000Z","bid":{"o":"1.08460","h":"1.08464","l":"1.08427","c":"1.08459"},"ask":{"o":"1.08560","h":"1.08560","l":"1.08488","c":"1.08488"}}]},{"instrument":"EUR_CHF","granularity":"M5","candles":[{"complete":true,"volume":26,"time":"2020-02-21T21:50:00.000000000Z","mid":{"o":"1.06126","h":"1.06130","l":"1.06121","c":"1.06124"}},{"complete":true,"volume":62,"time":"2020-02-21T21:55:00.000000000Z","mid":{"o":"1.06126","h":"1.06155","l":"1.06126","c":"1.06128"}}]}]}"""

mutable struct candlestickdata
    o   #open
    h   #high
    l   #low
    c   #close

    candlestickdata() = new()
end

mutable struct candlestick
    complete
    volume
    time
    bid::candlestickdata
    ask::candlestickdata
    mid::candlestickdata

    candlestick() = new()
end

mutable struct candles
    instrument::String
    granularity::String
    candles::Vector{candlestick}

    candles() = new()
end

mutable struct latestCandles
    latestCandles::Vector{candles}

    latestCandles() = new()
end

# Declaring JSON3 struct types
StructTypes.StructType(::Type{candlestickdata}) = StructTypes.Mutable()
StructTypes.StructType(::Type{candlestick}) = StructTypes.Mutable()
StructTypes.StructType(::Type{candles}) = StructTypes.Mutable()
StructTypes.StructType(::Type{latestCandles}) = StructTypes.Mutable()

# running the following line causes REPL to hand, can't ctrl+c or anything
JSON3.read(data,latestCandles)

