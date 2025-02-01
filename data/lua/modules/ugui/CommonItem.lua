module("modules.ugui.CommonItem", package.seeall)

slot0 = class("CommonItem", LuaCompBase)

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)
	logNormal("CommonItem:init...")

	slot0._gameObj = slot1
end

function LuaCompBase.addEventListeners(slot0)
	logNormal("CommonItem:addEventListeners...")
end

function LuaCompBase.removeEventListeners(slot0)
	logNormal("CommonItem:removeEventListeners...")
end

function slot0.onStart(slot0)
	logNormal("CommonItem:onStart...")

	slot0._updateCount = 0
end

function slot0.onUpdate(slot0)
	slot0._updateCount = slot0._updateCount + 1

	logNormal("CommonItem:onUpdate... self._updateCount = " .. slot0._updateCount)

	if slot0._updateCount >= 10 then
		MonoHelper.removeLuaComFromGo(slot0._gameObj, uv0)
		logNormal("CommonItem:onUpdate remove CommonItem-----")
	end
end

function slot0.onDestroy(slot0)
	logNormal("CommonItem:onDestroy...")
end

return slot0
