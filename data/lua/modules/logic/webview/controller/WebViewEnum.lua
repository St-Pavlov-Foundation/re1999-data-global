module("modules.logic.webview.controller.WebViewEnum", package.seeall)

local var_0_0 = _M

var_0_0.WebViewCBType = {
	Err = 1,
	Hooked = 4,
	Cookies = 5,
	Started = 3,
	Cb = 0,
	HttpErr = 2,
	LD = 6
}
var_0_0.DefaultMargin = {
	Top = 0,
	Right = 0,
	Left = 0,
	Bottom = 120
}
var_0_0.DeviceType = {
	PC = 2,
	Harmony = 3,
	Emulator = 1,
	Normal = 0
}

return var_0_0
