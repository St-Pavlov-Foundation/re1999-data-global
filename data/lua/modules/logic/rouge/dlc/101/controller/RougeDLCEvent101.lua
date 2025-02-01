module("modules.logic.rouge.dlc.101.controller.RougeDLCEvent101", package.seeall)

slot1 = 1

function slot2(slot0)
	assert(uv0[slot0] == nil, "[RougeDLCEvent101] error redefined RougeDLCEvent101." .. slot0)

	uv0[slot0] = uv1
	uv1 = uv1 + 1
end

slot2("UpdateLimitGroup")
slot2("OnSelectBuff")
slot2("RefreshLimiterDebuffTips")
slot2("UpdateBuffState")
slot2("UpdateEmblem")
slot2("CloseBuffDescTips")

return _M
