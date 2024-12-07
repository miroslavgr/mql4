//examples


Event driven

Main events

OnInit: Initialization
OnStart: Script execution
OnTick: Reaction to market ticks

Prices constants
SYMBOL_BID
SYMBOL_ASK

Function to retrieve current symbol 
Symbol()

Parser function
SymbolInfoDouble(Symbol(),SYMBOL_BID )

Spread calculate
double spread = (ask - bid) / Point;




//Get candles info
PERIOD_M1
PERIOD_H1
PERIOD_D1

shift = 0 is the current open candle 1, 2,3 are the others previous

Params - (string symbol, int timeframe, int shift)

iClose(); - closing price
iOpen(); - opening price 
iHigh(); - highest price
iLow(); - lowest price
iTime(); - opening time 
iVolume(); - volume 

Get the maximum number of candles available
iBars(Symbol(), PERIOD_H1);
editable in Tools > Options > Charts > Max bars in history


Example of iterating through candles
string symbol = Symbol();    // Current chart symbol
  int timeframe = PERIOD_H1;  // 1-hour timeframe

  // Fetch data for the last three candles
  for (int shift = 0; shift <= 2; shift++) {
      double open = iOpen(symbol, timeframe, shift);
      double close = iClose(symbol, timeframe, shift);
      double high = iHigh(symbol, timeframe, shift);
      double low = iLow(symbol, timeframe, shift);

      Print("Candle Shift ", shift, ": Open = ", open, 
            ", Close = ", close, ", High = ", high, ", Low = ", low);
  }



may check for errors
double open = iOpen("EURUSD", PERIOD_H1, 1);
if (open == 0.0 && GetLastError() != ERR_NO_ERROR) {
    Print("Error fetching data: ", GetLastError());
}


//indicators
double iMA(string symbol, int timeframe, int period, int ma_shift, int ma_method, int applied_price, int shift); - moving average
double iRSI(string symbol, int timeframe, int period, int applied_price, int shift); - relative strength index
double iMACD(string symbol, int timeframe, int fast_ema_period, int slow_ema_period, int signal_sma_period, int applied_price, int shift); - Moving Average Convergence Divergence
double iBands(string symbol, int timeframe, int period, int deviation, int shift, int applied_price, int mode, int shift);


symbol: The symbol to query (e.g., "EURUSD" or NULL for the current symbol).
timeframe: The timeframe (e.g., PERIOD_H1 for 1-hour).
period: The number of periods (e.g., 14 for a 14-period moving average).
ma_shift: The number of bars to shift the moving average (usually 0).
ma_method: The method (e.g., MODE_SMA for Simple Moving Average).
applied_price: The price used for calculations (e.g., PRICE_CLOSE for closing prices).
shift: The index of the candle for which the moving average is calculated (e.g., 0 for the most recent completed candle).


//orders
OP_SELL
OP_BUY

int OrderSend(string symbol, int cmd, double volume, double price, int slippage, double stoploss, double takeprofit, string comment, int magic, datetime expiration, color arrow_color);
bool OrderModify(int ticket, double price, double stoploss, double takeprofit, datetime expiration, color arrow_color);
bool OrderClose(int ticket, double lots, double price, int slippage, color arrow_color); - can use tp1,tp2 emulation with lots logic
OrdersTotal();
OrderSelect(int index, SELECT_BY_POS);

pending orders
int ticket = OrderSend(Symbol(), OP_BUYSTOP, lotSize, stopPrice, 3, stopLoss, takeProfit, "Buy Stop Order", 0, 0, Blue);


symbol: The symbol (e.g., "EURUSD").
cmd: The order type (OP_BUY or OP_SELL).
volume: The number of lots to buy/sell.
price: The price at which to execute the order (for market orders, this is usually Ask for buying and Bid for selling).
slippage: The maximum slippage allowed for the order.
stoploss: The stop-loss price.
takeprofit: The take-profit price.
comment: A comment associated with the order (optional).
magic: A unique identifier for your order (optional).
expiration: The expiration time for the order (optional).
arrow_color: The color of the arrow on the chart (optional).

double lotSize = 0.1;  // Number of lots
double slippage = 3;   // Slippage
double stopLoss = 1.1234;  // Stop loss price (example)
double takeProfit = 1.1300; // Take profit price (example)

// Place a market buy order
int ticket = OrderSend(Symbol(), OP_BUY, lotSize, Ask, slippage, stopLoss, takeProfit, "Buy Order", 0, 0, Blue);

// loop through open orders
int totalOrders = OrdersTotal();
for (int i = 0; i < totalOrders; i++) {
    if (OrderSelect(i, SELECT_BY_POS)) {
        Print("Order Ticket: ", OrderTicket(), " | Type: ", OrderType(), " | Volume: ", OrderLots());
    }
}


Working get request with parameters

void OnStart() {
    string url = "https://pitlane.shop/barcodescanner/?price=30"; // Target URL
    string headers = ""; // No custom headers for this example
    int timeout = 5000; // Timeout in milliseconds
    char response[]; // Buffer for response body
    string responseHeaders; // Buffer for response headers
    int result = 0; // HTTP response code
    char post[];
    
    // Send GET request
    int requestStatus = WebRequest("GET", url, headers, 5000, post, response, headers);
   
    if (requestStatus == -1) {
        Print("Error in WebRequest: ", GetLastError());
    } else {
        string responseBody = CharArrayToString(response); // Convert response to string
        Print("HTTP Response Code: ", result);
        Print("Response Body: ", responseBody);
        Print("Response Headers: ", responseHeaders);
    }
}




    



