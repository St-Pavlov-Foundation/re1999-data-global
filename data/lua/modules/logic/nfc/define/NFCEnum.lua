module("modules.logic.nfc.define.NFCEnum", package.seeall)

local var_0_0 = _M

var_0_0.NFCVersion = {
	OpenFunction = 1
}
var_0_0.NFCVersionDic = {
	[var_0_0.NFCVersion.OpenFunction] = 1
}
var_0_0.NFCVFunctionType = {
	PlayerCard = 81,
	BGMSwitch = 76
}

return var_0_0
