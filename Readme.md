# Bitstamp Binance Dashboard

Bitstamp & Binance Dashboard to shows your crypto balances across the two exchanges with daily candlestick chart - The app pulls balance data directly from the exchanges via API (read-only API keys are required) 

### Project status

*BETA* - fully functional but not polished

### Screenshot

![](https://raw.githubusercontent.com/makevoid/bitstamp_binance_dashboard/master/tmp/screenshots/screenshot1.png)


### Configuration


#### Binance:

Create a Binance API key and export the following environment variables containing your key and your secret: `BINANCE_API_KEY`, `BINANCE_SECRET_KEY`.

You don't want to give this key full permissions as this application just fetches your latest balances from the exchanges, readonly permissions are ok.

Example:

```sh
export BINANCE_API_KEY=XXX
export BINANCE_SECRET_KEY=XXX
```


#### Bitstamp:

You don't want to give this key full permissions as this application just fetches your latest balances from the exchanges, Read-Balance permissions only are enough.

```sh
export BITSTAMP_API_KEY=XXX
export BITSTAMP_API_SECRET=XXX
export BITSTAMP_CLIENT_ID=123456
```

### Install

    bundle


### Run


    bundle exec rackup -p 3000


then visit: <http://localhost:3000>

You sould see a dashboard with your


---

Enjoy,

@makevoid
