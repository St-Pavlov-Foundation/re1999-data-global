module("modules.logic.versionactivity1_2.yaxian.controller.game.YaXianStateMgr", package.seeall)

slot0 = class("YaXianStateMgr")

function slot0.ctor(slot0)
	slot0._curEventData = nil
	slot0._curEvent = nil
end

slot0.EventClzMap = {
	[YaXianGameEnum.GameStateType.Battle] = YaXianStateBattle,
	[YaXianGameEnum.GameStateType.UseItem] = YaXianStateUseItem,
	[YaXianGameEnum.GameStateType.FinishEvent] = YaXianStateFinishEvent
}

function slot0.setCurEvent(slot0, slot1)
	if slot1 ~= nil and not string.nilorempty(slot1.param) then
		slot0._curEventData = cjson.decode(slot1.param)
	else
		slot0._curEventData = nil
	end

	slot0:buildEventState()
end

function slot0.setCurEventByObj(slot0, slot1)
	if slot1 then
		slot0._curEventData = slot1
	else
		slot0._curEventData = nil
	end

	slot0:buildEventState()
end

function slot0.buildEventState(slot0)
	slot1 = nil
	slot1 = (slot0._curEventData or YaXianGameEnum.GameStateType.Normal) and slot0._curEventData.eventType

	if slot0._curEvent and slot0._curEvent:getStateType() == slot1 then
		return
	end

	if uv0.EventClzMap[slot1] then
		slot0:disposeEventState()

		slot0._curEvent = slot2.New()

		slot0._curEvent:init(slot0._curEventData)
		slot0._curEvent:start()
	end
end

function slot0.setLockState(slot0)
	slot0:disposeEventState()

	slot0._curEventData = nil
	slot0._curEvent = YaXianStateLock.New()

	slot0._curEvent:init()
	slot0._curEvent:start()
end

function slot0.disposeEventState(slot0)
	if slot0._curEvent ~= nil then
		slot0._curEvent:dispose()

		slot0._curEvent = nil
	end
end

function slot0.getCurEvent(slot0)
	return slot0._curEvent
end

function slot0.removeAll(slot0)
	slot0:disposeEventState()
end

return slot0
