module("modules.common.others.FullScreenViewLimitMgr", package.seeall)

slot0 = class("FullScreenViewLimitMgr")
slot0.enableLimit = true
slot0.limitCount = 5

function slot0.ctor(slot0)
end

function slot0.init(slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenFullViewFinish, slot0._onOpenFullView, slot0)
end

function slot0._onOpenFullView(slot0, slot1)
	if not uv0.enableLimit then
		return
	end

	slot2 = 0

	for slot7 = #ViewMgr.instance:getOpenViewNameList(), 1, -1 do
		if ViewMgr.instance:isFull(slot3[slot7]) then
			if uv0.limitCount <= slot2 then
				logNormal("全屏界面数量超出限制, 关闭界面: " .. slot3[slot7])
				ViewMgr.instance:closeView(slot3[slot7])
			end

			slot2 = slot2 + 1
		end
	end
end

slot0.instance = slot0.New()

return slot0
