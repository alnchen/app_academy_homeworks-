const selectCurrency = (baseCurrencyStr, ratesObj) => ({
  type: "SWITCH_CURRENCY",
  baseCurrency: baseCurrencyStr,
  rates: ratesObj
});

// window.selectCurrency = selectCurrency;

export default selectCurrency;
