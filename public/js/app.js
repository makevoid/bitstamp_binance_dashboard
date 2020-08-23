const host = "http://localhost:3000"

google.charts.load('current', {'packages':['corechart']})

const chartOptions = {
  legend:'none',
  bar: { groupWidth: '95%' },
  backgroundColor: "#222",
  candlestick: {
    fallingColor: { strokeWidth: 0, fill: '#d32e2e' }, // red
    risingColor: { strokeWidth: 0, fill: '#23db54' }   // green
  },
  hAxis: {
    // baselineColor: "#333",
    gridlines: {
      color: "#444",
    },
    minorGridlines: {
      color: "#333",
    },
    textStyle: {
      color: "#888",
    },
    textPosition: "none",
  },
  vAxis: {
    // logScale: true,
    // scaleType: "log",
    gridlines: {
      color: "#444",
    },
    minorGridlines: {
      color: "#333",
    },
    textStyle: {
      color: "#888",
    }
  }
}

const drawChart = async (elem, asset) => {
  const candleUrl = `${host}/candles/${asset}`
  let candleData = await axios.get(candleUrl)
  candleData = candleData.data

  const data = google.visualization.arrayToDataTable(candleData, true)
  const chart = new google.visualization.CandlestickChart(elem)

  chart.draw(data, chartOptions)
}

const drawCharts = () => {
  // const elem = document.querySelector('.chart[data-asset=\"BTC\"]')
  // drawChart(elem, "BTCUSDT")
  // // drawChart(elem, "BTCUSDT")
  let chartElems = document.querySelectorAll(".chart")
  chartElems = Array.from(chartElems)
  chartElems.forEach((elem) => {
    // const elem = document.querySelector('.chart[data-asset=\"BTC\"]')
    console.log(elem)
    const asset = elem.dataset.asset
    let symbol = "BTCUSDT"
    if (asset !== "BTC") symbol = `${asset}BTC`
    drawChart(elem, symbol)
  })
}

const main = () => {
  google.charts.setOnLoadCallback(drawCharts)
}

window.addEventListener('DOMContentLoaded', (event) => {
  main()
})
