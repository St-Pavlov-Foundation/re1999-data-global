module("modules.ugui.icon.common.CommonRedDotTag", package.seeall)

slot0 = class("CommonRedDotTag", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1

	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, slot0.refreshRelateDot, slot0)
end

function slot0.refreshDot(slot0)
	if slot0.overrideFunc then
		slot1, slot2 = pcall(slot0.overrideFunc, slot0.overrideFuncObj, slot0)

		if not slot1 then
			logError(string.format("CommonRedDotTag:overrideFunc dotId:%s error:%s", slot0.dotId, slot2))
		end

		return
	end

	if slot0.reverse then
		slot1 = not RedDotModel.instance:isDotShow(slot0.dotId, 0)
	end

	gohelper.setActive(slot0.go, slot1)
end

function slot0.refreshRelateDot(slot0, slot1)
	slot0:refreshDot()
end

function slot0.setScale(slot0, slot1)
	transformhelper.setLocalScale(slot0.go.transform, slot1, slot1, slot1)
end

function slot0.setId(slot0, slot1, slot2)
	slot0.dotId = slot1
	slot0.reverse = slot2
end

function slot0.overrideRefreshDotFunc(slot0, slot1, slot2)
	slot0.overrideFunc = slot1
	slot0.overrideFuncObj = slot2
end

function slot0.onDestroy(slot0)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, slot0.refreshRelateDot, slot0)
end

return slot0
