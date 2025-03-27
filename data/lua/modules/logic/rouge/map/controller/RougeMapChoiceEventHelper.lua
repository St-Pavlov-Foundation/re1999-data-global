module("modules.logic.rouge.map.controller.RougeMapChoiceEventHelper", package.seeall)

slot0 = class("RougeMapChoiceEventHelper")

function slot0.triggerEventHandle(slot0)
	if not slot0 then
		return
	end

	if slot0:checkIsStart() then
		return
	end

	if slot0.eventMo.state == RougeMapEnum.EventState.Finish then
		return
	end

	uv0._initEventHandleDict()

	if not uv0.eventHandleDict[slot1.eventCo and slot1.eventCo.type] then
		logError("not event handle event type : " .. tostring(slot2))

		return
	end

	slot3(slot0)
end

function slot0._initEventHandleDict()
	if uv0.eventHandleDict then
		return
	end

	uv0.eventHandleDict = {
		[RougeMapEnum.EventType.Empty] = uv0.emptyHandle,
		[RougeMapEnum.EventType.NormalFight] = uv0.fightHandle,
		[RougeMapEnum.EventType.HardFight] = uv0.fightHandle,
		[RougeMapEnum.EventType.EliteFight] = uv0.fightHandle,
		[RougeMapEnum.EventType.BossFight] = uv0.fightHandle,
		[RougeMapEnum.EventType.Reward] = uv0.choiceHandle,
		[RougeMapEnum.EventType.Choice] = uv0.choiceHandle,
		[RougeMapEnum.EventType.Store] = uv0.storeHandle,
		[RougeMapEnum.EventType.Rest] = uv0.choiceHandle,
		[RougeMapEnum.EventType.WatchTower] = uv0.choiceHandle,
		[RougeMapEnum.EventType.TreasurePlace] = uv0.choiceHandle,
		[RougeMapEnum.EventType.ChoiceLair] = uv0.choiceHandle,
		[RougeMapEnum.EventType.FightLair] = uv0.fightHandle,
		[RougeMapEnum.EventType.Unknow] = uv0.emptyHandle,
		[RougeMapEnum.EventType.LevelUpSp] = uv0.choiceHandle
	}
end

function slot0.triggerContinueEventHandle(slot0)
	if not slot0 then
		return
	end

	if slot0:checkIsStart() then
		return
	end

	if slot0.eventMo.state == RougeMapEnum.EventState.Finish then
		return
	end

	uv0._initContinueEventHandleDict()

	if not uv0.continueEventHandleDict[slot1.eventCo and slot1.eventCo.type] then
		logError("not continue event handle event type : " .. tostring(slot2))

		return
	end

	slot3(slot0)
end

function slot0._initContinueEventHandleDict()
	if uv0.continueEventHandleDict then
		return
	end

	uv0.continueEventHandleDict = {
		[RougeMapEnum.EventType.Empty] = uv0.emptyHandle,
		[RougeMapEnum.EventType.NormalFight] = uv0.continueFightEventHandle,
		[RougeMapEnum.EventType.HardFight] = uv0.continueFightEventHandle,
		[RougeMapEnum.EventType.EliteFight] = uv0.continueFightEventHandle,
		[RougeMapEnum.EventType.BossFight] = uv0.continueFightEventHandle,
		[RougeMapEnum.EventType.Reward] = uv0.choiceHandle,
		[RougeMapEnum.EventType.Choice] = uv0.choiceHandle,
		[RougeMapEnum.EventType.Store] = uv0.storeHandle,
		[RougeMapEnum.EventType.Rest] = uv0.choiceHandle,
		[RougeMapEnum.EventType.WatchTower] = uv0.choiceHandle,
		[RougeMapEnum.EventType.TreasurePlace] = uv0.choiceHandle,
		[RougeMapEnum.EventType.ChoiceLair] = uv0.choiceHandle,
		[RougeMapEnum.EventType.FightLair] = uv0.continueFightEventHandle,
		[RougeMapEnum.EventType.Unknow] = uv0.emptyHandle,
		[RougeMapEnum.EventType.LevelUpSp] = uv0.choiceHandle
	}
end

function slot0.emptyHandle(slot0)
	logNormal("empty handle")
end

function slot0.fightHandle(slot0)
	logNormal("fight handle")

	if slot0:isStartedEvent() then
		return
	end

	if (RougeDLCHelper.isCurrentUsingVersions(RougeMapConfig.instance:getFightEvent(slot0:getEventCo().id).versionEpisode) and slot3.episodeIdInstead or slot3.episodeId) and slot5 ~= 0 then
		DungeonFightController.instance:enterFight(RougeMapEnum.ChapterId, slot5)
	else
		logError(string.format("尝试进入肉鸽战斗失败, 战斗事件 %s 中 episodeId and episodeIdInstead 不可为空", slot1.id))
	end
end

function slot0.continueFightEventHandle()
	logNormal("continue fight handle")
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onShowContinueFight)
end

function slot0.storeHandle(slot0)
	logNormal("store handle")
	ViewMgr.instance:openView(ViewName.RougeStoreView, slot0.eventMo)
end

function slot0.choiceHandle(slot0)
	logNormal("choice handle")
	ViewMgr.instance:openView(ViewName.RougeMapChoiceView, slot0)
end

function slot0.triggerEventHandleOnChoiceView(slot0)
	if not slot0 then
		uv0.defaultHandleOnChoiceView()

		return
	end

	if slot0:checkIsStart() then
		uv0.defaultHandleOnChoiceView()

		return
	end

	if slot0.eventMo.state == RougeMapEnum.EventState.Finish then
		uv0.defaultHandleOnChoiceView()

		return
	end

	uv0._initEventHandleOnChoiceViewDict()

	if not uv0._onChoiceViewHandleDict[slot1.eventCo and slot1.eventCo.type] then
		logError("not on choice view event handle event type : " .. tostring(slot2))
		uv0.defaultHandleOnChoiceView()

		return
	end

	return slot3(slot0)
end

function slot0.defaultHandleOnChoiceView()
	ViewMgr.instance:closeView(ViewName.RougeMapChoiceView)
end

function slot0._initEventHandleOnChoiceViewDict()
	if uv0._onChoiceViewHandleDict then
		return
	end

	uv0._onChoiceViewHandleDict = {
		[RougeMapEnum.EventType.Empty] = uv0.defaultHandleOnChoiceView,
		[RougeMapEnum.EventType.NormalFight] = uv0.onChoiceViewFightHandle,
		[RougeMapEnum.EventType.HardFight] = uv0.onChoiceViewFightHandle,
		[RougeMapEnum.EventType.EliteFight] = uv0.onChoiceViewFightHandle,
		[RougeMapEnum.EventType.BossFight] = uv0.onChoiceViewFightHandle,
		[RougeMapEnum.EventType.Reward] = uv0.onChoiceViewChoiceHandle,
		[RougeMapEnum.EventType.Choice] = uv0.onChoiceViewChoiceHandle,
		[RougeMapEnum.EventType.Store] = uv0.onChoiceViewStoreHandle,
		[RougeMapEnum.EventType.Rest] = uv0.onChoiceViewChoiceHandle,
		[RougeMapEnum.EventType.WatchTower] = uv0.onChoiceViewChoiceHandle,
		[RougeMapEnum.EventType.TreasurePlace] = uv0.onChoiceViewChoiceHandle,
		[RougeMapEnum.EventType.ChoiceLair] = uv0.onChoiceViewChoiceHandle,
		[RougeMapEnum.EventType.FightLair] = uv0.onChoiceViewFightHandle,
		[RougeMapEnum.EventType.LevelUpSp] = uv0.onChoiceViewChoiceHandle
	}
end

function slot0.onChoiceViewFightHandle(slot0)
	uv0.defaultHandleOnChoiceView()
	uv0.fightHandle(slot0)
end

function slot0.onChoiceViewChoiceHandle(slot0)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onChoiceEventChange, slot0)
end

function slot0.onChoiceViewStoreHandle(slot0)
	uv0.defaultHandleOnChoiceView()
	ViewMgr.instance:openView(ViewName.RougeStoreView, slot0.eventMo)
end

function slot0._getLevelUpMaxNum(slot0)
	if slot0 then
		slot1 = slot0 and slot0.eventMo
		slot2 = slot1 and slot1.jsonData

		return slot2 and slot2.collectionLevelUpNum
	end
end

return slot0
