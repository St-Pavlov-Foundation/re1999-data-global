module("modules.logic.rouge.map.map.event.RougeMapEventComp", package.seeall)

slot0 = class("RougeMapEventComp", UserDataDispose)

function slot0.init(slot0)
end

function slot0.handleEvent(slot0, slot1)
	slot0.eventCo = slot1

	if not uv0.EventHandleDict[slot0.eventCo.type] then
		logError("not handle event type : " .. tostring(slot2))

		return
	end

	slot3(slot0)
end

function slot0.emptyHandle(slot0)
	logWarn("empty handle")
end

function slot0.fightHandle(slot0)
	logError("进入战斗")
end

function slot0.storeHandle(slot0)
	logError("打开商店")
end

function slot0.choiceHandle(slot0)
	logError("打开选项")
end

slot0.EventHandleDict = {
	[RougeMapEnum.EventType.Empty] = slot0.emptyHandle,
	[RougeMapEnum.EventType.NormalFight] = slot0.fightHandle,
	[RougeMapEnum.EventType.HardFight] = slot0.fightHandle,
	[RougeMapEnum.EventType.EliteFight] = slot0.fightHandle,
	[RougeMapEnum.EventType.BossFight] = slot0.fightHandle,
	[RougeMapEnum.EventType.Reward] = slot0.choiceHandle,
	[RougeMapEnum.EventType.Choice] = slot0.choiceHandle,
	[RougeMapEnum.EventType.Store] = slot0.storeHandle,
	[RougeMapEnum.EventType.Rest] = slot0.choiceHandle
}

function slot0.destroy(slot0)
end

return slot0
