module("modules.logic.rouge.map.controller.RougeMapChoiceEventHelper", package.seeall)

local var_0_0 = class("RougeMapChoiceEventHelper")

function var_0_0.triggerEventHandle(arg_1_0)
	if not arg_1_0 then
		return
	end

	if arg_1_0:checkIsStart() then
		return
	end

	local var_1_0 = arg_1_0.eventMo

	if var_1_0.state == RougeMapEnum.EventState.Finish then
		return
	end

	local var_1_1 = var_1_0.eventCo and var_1_0.eventCo.type

	var_0_0._initEventHandleDict()

	local var_1_2 = var_0_0.eventHandleDict[var_1_1]

	if not var_1_2 then
		logError("not event handle event type : " .. tostring(var_1_1))

		return
	end

	var_1_2(arg_1_0)
end

function var_0_0._initEventHandleDict()
	if var_0_0.eventHandleDict then
		return
	end

	var_0_0.eventHandleDict = {
		[RougeMapEnum.EventType.Empty] = var_0_0.emptyHandle,
		[RougeMapEnum.EventType.NormalFight] = var_0_0.fightHandle,
		[RougeMapEnum.EventType.HardFight] = var_0_0.fightHandle,
		[RougeMapEnum.EventType.EliteFight] = var_0_0.fightHandle,
		[RougeMapEnum.EventType.BossFight] = var_0_0.fightHandle,
		[RougeMapEnum.EventType.Reward] = var_0_0.choiceHandle,
		[RougeMapEnum.EventType.Choice] = var_0_0.choiceHandle,
		[RougeMapEnum.EventType.Store] = var_0_0.storeHandle,
		[RougeMapEnum.EventType.Rest] = var_0_0.choiceHandle,
		[RougeMapEnum.EventType.WatchTower] = var_0_0.choiceHandle,
		[RougeMapEnum.EventType.TreasurePlace] = var_0_0.choiceHandle,
		[RougeMapEnum.EventType.ChoiceLair] = var_0_0.choiceHandle,
		[RougeMapEnum.EventType.FightLair] = var_0_0.fightHandle,
		[RougeMapEnum.EventType.Unknow] = var_0_0.emptyHandle,
		[RougeMapEnum.EventType.LevelUpSp] = var_0_0.choiceHandle
	}
end

function var_0_0.triggerContinueEventHandle(arg_3_0)
	if not arg_3_0 then
		return
	end

	if arg_3_0:checkIsStart() then
		return
	end

	local var_3_0 = arg_3_0.eventMo

	if var_3_0.state == RougeMapEnum.EventState.Finish then
		return
	end

	local var_3_1 = var_3_0.eventCo and var_3_0.eventCo.type

	var_0_0._initContinueEventHandleDict()

	local var_3_2 = var_0_0.continueEventHandleDict[var_3_1]

	if not var_3_2 then
		logError("not continue event handle event type : " .. tostring(var_3_1))

		return
	end

	var_3_2(arg_3_0)
end

function var_0_0._initContinueEventHandleDict()
	if var_0_0.continueEventHandleDict then
		return
	end

	var_0_0.continueEventHandleDict = {
		[RougeMapEnum.EventType.Empty] = var_0_0.emptyHandle,
		[RougeMapEnum.EventType.NormalFight] = var_0_0.continueFightEventHandle,
		[RougeMapEnum.EventType.HardFight] = var_0_0.continueFightEventHandle,
		[RougeMapEnum.EventType.EliteFight] = var_0_0.continueFightEventHandle,
		[RougeMapEnum.EventType.BossFight] = var_0_0.continueFightEventHandle,
		[RougeMapEnum.EventType.Reward] = var_0_0.choiceHandle,
		[RougeMapEnum.EventType.Choice] = var_0_0.choiceHandle,
		[RougeMapEnum.EventType.Store] = var_0_0.storeHandle,
		[RougeMapEnum.EventType.Rest] = var_0_0.choiceHandle,
		[RougeMapEnum.EventType.WatchTower] = var_0_0.choiceHandle,
		[RougeMapEnum.EventType.TreasurePlace] = var_0_0.choiceHandle,
		[RougeMapEnum.EventType.ChoiceLair] = var_0_0.choiceHandle,
		[RougeMapEnum.EventType.FightLair] = var_0_0.continueFightEventHandle,
		[RougeMapEnum.EventType.Unknow] = var_0_0.emptyHandle,
		[RougeMapEnum.EventType.LevelUpSp] = var_0_0.choiceHandle
	}
end

function var_0_0.emptyHandle(arg_5_0)
	logNormal("empty handle")
end

function var_0_0.fightHandle(arg_6_0)
	logNormal("fight handle")

	if arg_6_0:isStartedEvent() then
		return
	end

	local var_6_0 = arg_6_0:getEventCo()
	local var_6_1 = RougeMapEnum.ChapterId
	local var_6_2 = RougeMapConfig.instance:getFightEvent(var_6_0.id)
	local var_6_3 = RougeDLCHelper.isCurrentUsingVersions(var_6_2.versionEpisode) and var_6_2.episodeIdInstead or var_6_2.episodeId

	if var_6_3 and var_6_3 ~= 0 then
		DungeonFightController.instance:enterFight(var_6_1, var_6_3)
	else
		logError(string.format("尝试进入肉鸽战斗失败, 战斗事件 %s 中 episodeId and episodeIdInstead 不可为空", var_6_0.id))
	end
end

function var_0_0.continueFightEventHandle()
	logNormal("continue fight handle")
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onShowContinueFight)
end

function var_0_0.storeHandle(arg_8_0)
	logNormal("store handle")
	ViewMgr.instance:openView(ViewName.RougeStoreView, arg_8_0.eventMo)
end

function var_0_0.choiceHandle(arg_9_0)
	logNormal("choice handle")
	ViewMgr.instance:openView(ViewName.RougeMapChoiceView, arg_9_0)
end

function var_0_0.triggerEventHandleOnChoiceView(arg_10_0)
	if not arg_10_0 then
		var_0_0.defaultHandleOnChoiceView()

		return
	end

	if arg_10_0:checkIsStart() then
		var_0_0.defaultHandleOnChoiceView()

		return
	end

	local var_10_0 = arg_10_0.eventMo

	if var_10_0.state == RougeMapEnum.EventState.Finish then
		var_0_0.defaultHandleOnChoiceView()

		return
	end

	local var_10_1 = var_10_0.eventCo and var_10_0.eventCo.type

	var_0_0._initEventHandleOnChoiceViewDict()

	local var_10_2 = var_0_0._onChoiceViewHandleDict[var_10_1]

	if not var_10_2 then
		logError("not on choice view event handle event type : " .. tostring(var_10_1))
		var_0_0.defaultHandleOnChoiceView()

		return
	end

	return var_10_2(arg_10_0)
end

function var_0_0.defaultHandleOnChoiceView()
	ViewMgr.instance:closeView(ViewName.RougeMapChoiceView)
end

function var_0_0._initEventHandleOnChoiceViewDict()
	if var_0_0._onChoiceViewHandleDict then
		return
	end

	var_0_0._onChoiceViewHandleDict = {
		[RougeMapEnum.EventType.Empty] = var_0_0.defaultHandleOnChoiceView,
		[RougeMapEnum.EventType.NormalFight] = var_0_0.onChoiceViewFightHandle,
		[RougeMapEnum.EventType.HardFight] = var_0_0.onChoiceViewFightHandle,
		[RougeMapEnum.EventType.EliteFight] = var_0_0.onChoiceViewFightHandle,
		[RougeMapEnum.EventType.BossFight] = var_0_0.onChoiceViewFightHandle,
		[RougeMapEnum.EventType.Reward] = var_0_0.onChoiceViewChoiceHandle,
		[RougeMapEnum.EventType.Choice] = var_0_0.onChoiceViewChoiceHandle,
		[RougeMapEnum.EventType.Store] = var_0_0.onChoiceViewStoreHandle,
		[RougeMapEnum.EventType.Rest] = var_0_0.onChoiceViewChoiceHandle,
		[RougeMapEnum.EventType.WatchTower] = var_0_0.onChoiceViewChoiceHandle,
		[RougeMapEnum.EventType.TreasurePlace] = var_0_0.onChoiceViewChoiceHandle,
		[RougeMapEnum.EventType.ChoiceLair] = var_0_0.onChoiceViewChoiceHandle,
		[RougeMapEnum.EventType.FightLair] = var_0_0.onChoiceViewFightHandle,
		[RougeMapEnum.EventType.LevelUpSp] = var_0_0.onChoiceViewChoiceHandle
	}
end

function var_0_0.onChoiceViewFightHandle(arg_13_0)
	var_0_0.defaultHandleOnChoiceView()
	var_0_0.fightHandle(arg_13_0)
end

function var_0_0.onChoiceViewChoiceHandle(arg_14_0)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onChoiceEventChange, arg_14_0)
end

function var_0_0.onChoiceViewStoreHandle(arg_15_0)
	var_0_0.defaultHandleOnChoiceView()
	ViewMgr.instance:openView(ViewName.RougeStoreView, arg_15_0.eventMo)
end

function var_0_0._getLevelUpMaxNum(arg_16_0)
	if arg_16_0 then
		local var_16_0 = arg_16_0 and arg_16_0.eventMo
		local var_16_1 = var_16_0 and var_16_0.jsonData

		return var_16_1 and var_16_1.collectionLevelUpNum
	end
end

return var_0_0
