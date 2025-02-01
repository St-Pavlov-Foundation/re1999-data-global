module("modules.logic.pay.define.PayEnum", package.seeall)

slot0 = _M
slot0.PayResultCode = {
	PayCancel = 901,
	PayOrderCancel = 904,
	PayError = 903,
	PayInfoFail = 902,
	PayFinish = 200,
	PayChannelFail = 905
}
slot0.CurrencyCode = {
	DKK = "DKK",
	CNY = "CNY",
	GBP = "GBP",
	RUB = "RUB",
	HKD = "HKD",
	ILS = "ILS",
	AUD = "AUD",
	SEK = "SEK",
	BGN = "BGN",
	HUF = "HUF",
	TZS = "TZS",
	COP = "COP",
	NZD = "NZD",
	THB = "THB",
	TRY = "TRY",
	NOK = "NOK",
	KZT = "KZT",
	EGP = "EGP",
	BRL = "BRL",
	VND = "VND",
	MXN = "MXN",
	PKR = "PKR",
	CZK = "CZK",
	CLP = "CLP",
	KRW = "KRW",
	NGN = "NGN",
	TWD = "TWD",
	MYR = "MYR",
	JPY = "JPY",
	ZAR = "ZAR",
	CHF = "CHF",
	RON = "RON",
	SAR = "SAR",
	AED = "AED",
	QAR = "QAR",
	USD = "USD",
	INR = "INR",
	PHP = "PHP",
	SGD = "SGD",
	IDR = "IDR",
	EUR = "EUR",
	PEN = "PEN",
	CAD = "CAD",
	PLN = "PLN"
}
slot0.CurrencySymbol = {
	[slot0.CurrencyCode.USD] = "US$",
	[slot0.CurrencyCode.KRW] = "₩",
	[slot0.CurrencyCode.JPY] = "¥",
	[slot0.CurrencyCode.EUR] = "€"
}
slot0.NoDecimalsCurrency = {
	[slot0.CurrencyCode.JPY] = true,
	[slot0.CurrencyCode.HKD] = true,
	[slot0.CurrencyCode.TWD] = true,
	[slot0.CurrencyCode.KRW] = true
}

return slot0
