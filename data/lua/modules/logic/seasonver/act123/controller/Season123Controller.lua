module("modules.logic.seasonver.act123.controller.Season123Controller", package.seeall)

local var_0_0 = class("Season123Controller", BaseController)

function var_0_0.onInit(arg_1_0)
	Season123ControllerCardEffectHandleFunc.activeHandleFuncController()
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, arg_3_0.handleReceiveActChanged, arg_3_0)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, arg_3_0.onUpdateTaskList, arg_3_0)
	TaskController.instance:registerCallback(TaskEvent.SetTaskList, arg_3_0.onSetTaskList, arg_3_0)
end

function var_0_0.handleReceiveActChanged(arg_4_0, arg_4_1)
	logNormal("handleReceiveActChanged : " .. tostring(arg_4_1))

	local var_4_0 = ActivityModel.instance:getOnlineActIdByType(Activity123Enum.ActType)

	if var_4_0 then
		Activity123Rpc.instance:sendGet123InfosRequest(var_4_0[1])
	end
end

function var_0_0.openSeasonEntry(arg_5_0, arg_5_1)
	local var_5_0

	if arg_5_1 and arg_5_1.actId then
		var_5_0 = arg_5_1.actId
	else
		arg_5_1 = arg_5_1 or {}
		var_5_0 = Season123Model.instance:getCurSeasonId()
		arg_5_1.actId = var_5_0
	end

	if not var_5_0 then
		return
	end

	var_0_0.instance.lastOpenActId = var_5_0

	local var_5_1 = Activity123Enum.SeasonViewPrefix[var_5_0] or ""
	local var_5_2 = string.format("Season123%s%s", var_5_1, "EntryView")

	arg_5_0:enterVersionActivityView(ViewName[var_5_2], var_5_0, function()
		Season123ViewHelper.openView(var_5_0, "EntryView", arg_5_1)
		Season123Model.instance:setRetailRandomSceneId(arg_5_1.jumpParam)
	end, arg_5_0)
end

function var_0_0.openSeasonEntryByJump(arg_7_0)
	var_0_0.instance:openSeasonEntry(arg_7_0)
end

function var_0_0.openSeasonOverview(arg_8_0, arg_8_1)
	arg_8_1 = arg_8_1 or {}

	Season123ViewHelper.openView(arg_8_1.actId, "EntryOverview", arg_8_1)
end

function var_0_0.openSeasonRetail(arg_9_0, arg_9_1)
	arg_9_1 = arg_9_1 or {}

	Season123ViewHelper.openView(arg_9_1.actId, "RetailView", arg_9_1)
	arg_9_0:dispatchEvent(Season123Event.EnterRetailView)
end

function var_0_0.openSeasonEquipView(arg_10_0, arg_10_1)
	arg_10_1 = arg_10_1 or {}

	Season123ViewHelper.openView(arg_10_1.actId, "EquipView", arg_10_1)
end

function var_0_0.onUpdateTaskList(arg_11_0, arg_11_1)
	if Season123TaskModel.instance:updateInfo(arg_11_1.taskInfo) then
		Season123TaskModel.instance:refreshList()
	end

	Season123Model.instance:updateTaskReward()
	arg_11_0:dispatchEvent(Season123Event.TaskUpdated)
end

function var_0_0.onSetTaskList(arg_12_0)
	Season123Model.instance:updateTaskReward()
	arg_12_0:dispatchEvent(Season123Event.TaskUpdated)
end

function var_0_0.openSeasonStoreView(arg_13_0, arg_13_1)
	local var_13_0 = Season123Config.instance:getSeasonConstNum(arg_13_1, Activity123Enum.Const.StoreActId)
	local var_13_1 = Activity123Enum.SeasonViewPrefix[arg_13_1] or ""
	local var_13_2 = string.format("Season123%s%s", var_13_1, "StoreView")

	arg_13_0:enterVersionActivityView(ViewName[var_13_2], var_13_0, arg_13_0._openSeasonStoreView, arg_13_0)
end

function var_0_0._openSeasonStoreView(arg_14_0, arg_14_1, arg_14_2)
	Activity107Rpc.instance:sendGet107GoodsInfoRequest(arg_14_2, function()
		ViewMgr.instance:openView(arg_14_1, {
			actId = arg_14_2
		})
	end)
end

function var_0_0.openSeasonTaskView(arg_16_0, arg_16_1)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Season123
	}, function()
		Season123TaskModel.instance:resetMapData()
		Season123ViewHelper.openView(arg_16_1.actId, "TaskView", arg_16_1)
	end)
end

function var_0_0.openSeasonEquipBookView(arg_18_0, arg_18_1)
	Season123EquipBookModel.instance:initDatas(arg_18_1)
	Season123ViewHelper.openView(arg_18_1, "EquipBookView")
end

function var_0_0.openSeasonCardPackageView(arg_19_0, arg_19_1)
	Season123CardPackageModel.instance:initData(arg_19_1.actId)

	if Season123CardPackageModel.instance.packageCount > 0 then
		Season123ViewHelper.openView(arg_19_1.actId, "CardPackageView")
	else
		GameFacade.showToast(ToastEnum.Season123EmptyCardPackage)
	end
end

function var_0_0.openFightTipViewName(arg_20_0)
	if Season123Model.instance:getCurSeasonId() then
		ViewMgr.instance:openView(arg_20_0:getFightRuleTipViewName())
	end
end

function var_0_0.openResetView(arg_21_0, arg_21_1)
	arg_21_1 = arg_21_1 or {}

	Season123ViewHelper.openView(arg_21_1.actId, "ResetView", arg_21_1)
end

function var_0_0.getRecordWindowViewName(arg_22_0)
	return Season123ViewHelper.getViewName(nil, "RecordWindow")
end

function var_0_0.openHeroGroupFightView(arg_23_0, arg_23_1)
	ViewMgr.instance:openView(arg_23_0:getHeroGroupFightViewName(), arg_23_1)
end

function var_0_0.getHeroGroupFightViewName(arg_24_0)
	return Season123ViewHelper.getViewName(nil, "HeroGroupFightView")
end

function var_0_0.getHeroGroupEditViewName(arg_25_0)
	return Season123ViewHelper.getViewName(nil, "HeroGroupEditView")
end

function var_0_0.getEpisodeListViewName(arg_26_0)
	return Season123ViewHelper.getViewName(nil, "EpisodeListView")
end

function var_0_0.getPickHeroEntryViewName(arg_27_0)
	return Season123ViewHelper.getViewName(nil, "PickHeroEntryView")
end

function var_0_0.getStageLoadingViewName(arg_28_0)
	return Season123ViewHelper.getViewName(nil, "StageLoadingView")
end

function var_0_0.getStageFinishViewName(arg_29_0)
	return Season123ViewHelper.getViewName(nil, "StageFinishView")
end

function var_0_0.getEquipHeroViewName(arg_30_0)
	return Season123ViewHelper.getViewName(nil, "EquipHeroView")
end

function var_0_0.getPickAssistViewName(arg_31_0)
	return Season123ViewHelper.getViewName(nil, "PickAssistView")
end

function var_0_0.getPickHeroViewName(arg_32_0)
	return Season123ViewHelper.getViewName(nil, "PickHeroView")
end

function var_0_0.getShowHeroViewName(arg_33_0)
	return Season123ViewHelper.getViewName(nil, "ShowHeroView")
end

function var_0_0.getEpisodeLoadingViewName(arg_34_0)
	return Season123ViewHelper.getViewName(nil, "EpisodeLoadingView")
end

function var_0_0.getEpisodeMarketViewName(arg_35_0)
	return Season123ViewHelper.getViewName(nil, "EpisodeDetailView")
end

function var_0_0.getFightRuleTipViewName(arg_36_0)
	return Season123ViewHelper.getViewName(nil, "FightRuleTipView")
end

function var_0_0.enterVersionActivityView(arg_37_0, arg_37_1, arg_37_2, arg_37_3, arg_37_4)
	local var_37_0, var_37_1, var_37_2 = ActivityHelper.getActivityStatusAndToast(arg_37_2)

	if var_37_0 ~= ActivityEnum.ActivityStatus.Normal then
		if var_37_1 then
			GameFacade.showToast(var_37_1, var_37_2)
		end

		return
	end

	if arg_37_3 then
		arg_37_3(arg_37_4, arg_37_1, arg_37_2)

		return
	end

	ViewMgr.instance:openView(arg_37_1)
end

function var_0_0.openMainViewFromFightScene(arg_38_0)
	local var_38_0 = Season123Model.instance:getBattleContext()
	local var_38_1 = {}

	if var_38_0 then
		var_38_1.actId = var_38_0.actId
	else
		var_38_1.actId = Season123Model.instance:getCurSeasonId()
	end

	arg_38_0:openSeasonEntry(var_38_1)
end

function var_0_0.isSeason123EpisodeType(arg_39_0)
	return arg_39_0 == DungeonEnum.EpisodeType.Season123 or arg_39_0 == DungeonEnum.EpisodeType.Season123Retail or arg_39_0 == DungeonEnum.EpisodeType.Season123Trial
end

function var_0_0.canUse123EquipEpisodeType(arg_40_0)
	return arg_40_0 == DungeonEnum.EpisodeType.Season123 or arg_40_0 == DungeonEnum.EpisodeType.Season123Trial
end

function var_0_0.isSeason123ChapterType(arg_41_0)
	return arg_41_0 == DungeonEnum.ChapterType.Season123 or arg_41_0 == DungeonEnum.ChapterType.Season123Retail or arg_41_0 == DungeonEnum.ChapterType.Season123Trial
end

function var_0_0.sendEpisodeUseSeason123Equip()
	local var_42_0 = DungeonModel.instance.curSendEpisodeId

	if not var_42_0 or var_42_0 == 0 then
		return false
	end

	local var_42_1 = DungeonConfig.instance:getEpisodeCO(var_42_0)

	if var_0_0.canUse123EquipEpisodeType(var_42_1.type) then
		return true
	end

	return false
end

function var_0_0.openSeasonCelebrityCardTipView(arg_43_0, arg_43_1)
	arg_43_1 = arg_43_1 or {}

	Season123ViewHelper.openView(nil, "CelebrityCardTipView", arg_43_1)
end

function var_0_0.openSeasonCelebrityCardGetView(arg_44_0, arg_44_1)
	arg_44_1 = arg_44_1 or {}

	Season123ViewHelper.openView(nil, "CelebrityCardGetView", arg_44_1)
end

function var_0_0.openSeasonStoryView(arg_45_0, arg_45_1)
	arg_45_1 = arg_45_1 or {}

	Season123ViewHelper.openView(arg_45_1.actId, "StoryView", arg_45_1)
end

function var_0_0.checkProcessFightReconnect(arg_46_0)
	local var_46_0 = FightModel.instance:getFightReason()
	local var_46_1 = var_46_0.episodeId
	local var_46_2 = DungeonConfig.instance:getEpisodeCO(var_46_1)

	if var_46_2 and var_0_0.isSeason123EpisodeType(var_46_2.type) then
		if var_46_2.type == DungeonEnum.EpisodeType.Season123 then
			local var_46_3 = Season123Config.instance:getConfigByEpisodeId(var_46_1)

			if var_46_3 then
				Season123Model.instance:setBattleContext(var_46_3.activityId, var_46_3.stage, var_46_3.layer, var_46_1)
			end
		elseif var_46_2.type == DungeonEnum.EpisodeType.Season123Retail then
			local var_46_4 = Season123Config.instance:getRetailCOByEpisodeId(var_46_1)

			if var_46_4 then
				Season123Model.instance:setBattleContext(var_46_4.activityId, nil, nil, var_46_1)
			end
		elseif var_46_2.type == DungeonEnum.EpisodeType.Season123Trail then
			local var_46_5 = Season123Config.instance:getTrailCOByEpisodeId(var_46_1)

			if var_46_5 then
				Season123Model.instance:setBattleContext(var_46_5.activityId, nil, nil, var_46_1)
			end
		end

		local var_46_6 = var_46_0.type == FightEnum.FightReason.DungeonRecord
		local var_46_7 = var_46_0.multiplication

		var_46_7 = var_46_7 and var_46_7 > 0 and var_46_7 or 1

		FightController.instance:setFightParamByEpisodeId(var_46_1, var_46_6, var_46_7, var_46_0.battleId)
		HeroGroupModel.instance:setParam(var_46_0.battleId, var_46_1, false, true)
	end
end

function var_0_0.isEpisodeFromSeason123(arg_47_0)
	if not arg_47_0 then
		return false
	end

	local var_47_0 = DungeonConfig.instance:getEpisodeCO(arg_47_0)

	if var_47_0 and var_0_0.isSeason123EpisodeType(var_47_0.type) then
		return true
	end

	return false
end

function var_0_0.addDontNavigateBtn(arg_48_0, arg_48_1)
	arg_48_1[var_0_0.instance:getEpisodeLoadingViewName()] = true
	arg_48_1[var_0_0.instance:getStageLoadingViewName()] = true
	arg_48_1[var_0_0.instance:getStageFinishViewName()] = true
end

function var_0_0.openSeasonFightFailView(arg_49_0, arg_49_1)
	arg_49_1 = arg_49_1 or {}

	Season123ViewHelper.openView(arg_49_1.actId, "FightFailView", arg_49_1)
end

function var_0_0.openSeasonFightSuccView(arg_50_0, arg_50_1)
	arg_50_1 = arg_50_1 or {}

	Season123ViewHelper.openView(arg_50_1.actId, "FightSuccView", arg_50_1)
end

function var_0_0.openSeason123SettlementView(arg_51_0, arg_51_1)
	arg_51_1 = arg_51_1 or {}

	Season123ViewHelper.openView(arg_51_1.actId, "SettlementView", arg_51_1)
end

function var_0_0.openSeasonAdditionRuleTipView(arg_52_0, arg_52_1)
	arg_52_1 = arg_52_1 or {}

	Season123ViewHelper.openView(arg_52_1.actId, "AdditionRuleTipView", arg_52_1)
end

function var_0_0.openSeasonStoryPagePopView(arg_53_0, arg_53_1, arg_53_2)
	local var_53_0 = {
		actId = arg_53_1,
		stageId = arg_53_2
	}

	Season123ViewHelper.openView(var_53_0.actId, "StoryPagePopView", var_53_0)
end

function var_0_0.getSeasonIcon(arg_54_0, arg_54_1)
	local var_54_0 = Activity123Enum.SeasonIconFolder[arg_54_1]

	return string.format("singlebg/%s/%s", var_54_0, arg_54_0)
end

function var_0_0.checkHasReadUnlockStory(arg_55_0, arg_55_1)
	local var_55_0 = Season123Model.instance:checkHasUnlockStory(arg_55_1) and 1 or 0
	local var_55_1 = {
		{
			uid = 0,
			id = RedDotEnum.DotNode.Season123Story,
			value = var_55_0
		}
	}

	RedDotRpc.instance:clientAddRedDotGroupList(var_55_1, true)
end

function var_0_0.checkAndHandleEffectEquip(arg_56_0, arg_56_1)
	local var_56_0 = arg_56_1.layer
	local var_56_1 = arg_56_1.actId
	local var_56_2 = arg_56_1.stage
	local var_56_3 = Season123Model.instance:getActInfo(var_56_1):getStageMO(var_56_2)

	if not var_56_3 then
		return
	end

	if not var_56_0 or var_56_0 <= 0 then
		for iter_56_0, iter_56_1 in pairs(var_56_3.episodeMap) do
			arg_56_1.layer = iter_56_0

			arg_56_0:handleEffectEquip(iter_56_1, arg_56_1)
		end
	else
		local var_56_4 = var_56_3.episodeMap[var_56_0]

		arg_56_0:handleEffectEquip(var_56_4, arg_56_1)
	end
end

function var_0_0.handleEffectEquip(arg_57_0, arg_57_1, arg_57_2)
	local var_57_0 = arg_57_1.effectMainCelebrityEquipIds or {}

	for iter_57_0, iter_57_1 in pairs(var_57_0) do
		local var_57_1 = Season123Config.instance:getCardSpecialEffectMap(iter_57_1) or {}

		for iter_57_2, iter_57_3 in pairs(var_57_1) do
			local var_57_2 = var_0_0.SpecialEffctHandleFunc[iter_57_2]

			if var_57_2 then
				var_57_2(arg_57_0, iter_57_3, arg_57_2)
			end
		end
	end
end

function var_0_0.isReduceRound(arg_58_0, arg_58_1, arg_58_2, arg_58_3)
	local var_58_0 = arg_58_1
	local var_58_1 = arg_58_2
	local var_58_2 = Season123Model.instance:getActInfo(var_58_0):getStageMO(var_58_1)

	if var_58_2.reduceState then
		return var_58_2.reduceState[arg_58_3]
	end

	return false
end

var_0_0.instance = var_0_0.New()

return var_0_0
