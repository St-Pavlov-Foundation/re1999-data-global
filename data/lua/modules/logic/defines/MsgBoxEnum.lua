module("modules.logic.defines.MsgBoxEnum", package.seeall)

slot0 = _M
slot0.BoxType = {
	Yes = 2,
	NO = 3,
	Yes_No = 1
}
slot0.CloseType = {
	Yes = 1,
	Close = 0,
	No = -1
}
slot0.optionType = {
	NotShow = 2,
	Daily = 1
}

return slot0
