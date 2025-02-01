module("modules.logic.seasonver.act123.controller.Season123Controller", package.seeall)

slot0 = class("Season123Controller", BaseController)

function slot0.onInit(slot0)
	Season123ControllerCardEffectHandleFunc.activeHandleFuncController()
end

function slot0.reInit(slot0)
end

function slot0.addConstEvents(slot0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, slot0.handleReceiveActChanged, slot0)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, slot0.onUpdateTaskList, slot0)
	TaskController.instance:registerCallback(TaskEvent.SetTaskList, slot0.onSetTaskList, slot0)
end

function slot0.handleReceiveActChanged(slot0, slot1)
	logNormal("handleReceiveActChanged : " .. tostring(slot1))

	if ActivityModel.instance:getOnlineActIdByType(Activity123Enum.ActType) then
		Activity123Rpc.instance:sendGet123InfosRequest(slot2[1])
	end
end

function slot0.openSeasonEntry(slot0, slot1)
	slot2 = nil

	if slot1 and slot1.actId then
		slot2 = slot1.actId
	else
		(slot1 or {}).actId = Season123Model.instance:getCurSeasonId()
	end

	if not slot2 then
		return
	end

	uv0.instance.lastOpenActId = slot2

	slot0:enterVersionActivityView(ViewName[string.format("Season123%s%s", Activity123Enum.SeasonViewPrefix[slot2] or "", "EntryView")], slot2, function ()
		Season123ViewHelper.openView(uv0, "EntryView", uv1)
		Season123Model.instance:setRetailRandomSceneId(uv1.jumpParam)
	end, slot0)
end

function slot0.openSeasonEntryByJump(slot0)
	uv0.instance:openSeasonEntry(slot0)
end

function slot0.openSeasonOverview(slot0, slot1)
	slot1 = slot1 or {}

	Season123ViewHelper.openView(slot1.actId, "EntryOverview", slot1)
end

function slot0.openSeasonRetail(slot0, slot1)
	slot1 = slot1 or {}

	Season123ViewHelper.openView(slot1.actId, "RetailView", slot1)
	slot0:dispatchEvent(Season123Event.EnterRetailView)
end

function slot0.openSeasonEquipView(slot0, slot1)
	slot1 = slot1 or {}

	Season123ViewHelper.openView(slot1.actId, "EquipView", slot1)
end

function slot0.onUpdateTaskList(slot0, slot1)
	if Season123TaskModel.instance:updateInfo(slot1.taskInfo) then
		Season123TaskModel.instance:refreshList()
	end

	Season123Model.instance:updateTaskReward()
	slot0:dispatchEvent(Season123Event.TaskUpdated)
end

function slot0.onSetTaskList(slot0)
	Season123Model.instance:updateTaskReward()
	slot0:dispatchEvent(Season123Event.TaskUpdated)
end

function slot0.openSeasonStoreView(slot0, slot1)
	slot0:enterVersionActivityView(ViewName[string.format("Season123%s%s", Activity123Enum.SeasonViewPrefix[slot1] or "", "StoreView")], Season123Config.instance:getSeasonConstNum(slot1, Activity123Enum.Const.StoreActId), slot0._openSeasonStoreView, slot0)
end

function slot0._openSeasonStoreView(slot0, slot1, slot2)
	Activity107Rpc.instance:sendGet107GoodsInfoRequest(slot2, function ()
		ViewMgr.instance:openView(uv0, {
			actId = uv1
		})
	end)
end

function slot0.openSeasonTaskView(slot0, slot1)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Season123
	}, function ()
		Season123TaskModel.instance:resetMapData()
		Season123ViewHelper.openView(uv0.actId, "TaskView", uv0)
	end)
end

function slot0.openSeasonEquipBookView(slot0, slot1)
	Season123EquipBookModel.instance:initDatas(slot1)
	Season123ViewHelper.openView(slot1, "EquipBookView")
end

function slot0.openSeasonCardPackageView(slot0, slot1)
	Season123CardPackageModel.instance:initData(slot1.actId)

	if Season123CardPackageModel.instance.packageCount > 0 then
		Season123ViewHelper.openView(slot1.actId, "CardPackageView")
	else
		GameFacade.showToast(ToastEnum.Season123EmptyCardPackage)
	end
end

function slot0.openFightTipViewName(slot0)
	if Season123Model.instance:getCurSeasonId() then
		ViewMgr.instance:openView(slot0:getFightRuleTipViewName())
	end
end

function slot0.openResetView(slot0, slot1)
	slot1 = slot1 or {}

	Season123ViewHelper.openView(slot1.actId, "ResetView", slot1)
end

function slot0.getRecordWindowViewName(slot0)
	return Season123ViewHelper.getViewName(nil, "RecordWindow")
end

function slot0.openHeroGroupFightView(slot0, slot1)
	ViewMgr.instance:openView(slot0:getHeroGroupFightViewName(), slot1)
end

function slot0.getHeroGroupFightViewName(slot0)
	return Season123ViewHelper.getViewName(nil, "HeroGroupFightView")
end

function slot0.getHeroGroupEditViewName(slot0)
	return Season123ViewHelper.getViewName(nil, "HeroGroupEditView")
end

function slot0.getEpisodeListViewName(slot0)
	return Season123ViewHelper.getViewName(nil, "EpisodeListView")
end

function slot0.getPickHeroEntryViewName(slot0)
	return Season123ViewHelper.getViewName(nil, "PickHeroEntryView")
end

function slot0.getStageLoadingViewName(slot0)
	return Season123ViewHelper.getViewName(nil, "StageLoadingView")
end

function slot0.getStageFinishViewName(slot0)
	return Season123ViewHelper.getViewName(nil, "StageFinishView")
end

function slot0.getEquipHeroViewName(slot0)
	return Season123ViewHelper.getViewName(nil, "EquipHeroView")
end

function slot0.getPickAssistViewName(slot0)
	return Season123ViewHelper.getViewName(nil, "PickAssistView")
end

function slot0.getPickHeroViewName(slot0)
	return Season123ViewHelper.getViewName(nil, "PickHeroView")
end

function slot0.getShowHeroViewName(slot0)
	return Season123ViewHelper.getViewName(nil, "ShowHeroView")
end

function slot0.getEpisodeLoadingViewName(slot0)
	return Season123ViewHelper.getViewName(nil, "EpisodeLoadingView")
end

function slot0.getEpisodeMarketViewName(slot0)
	return Season123ViewHelper.getViewName(nil, "EpisodeDetailView")
end

function slot0.getFightRuleTipViewName(slot0)
	return Season123ViewHelper.getViewName(nil, "FightRuleTipView")
end

function slot0.enterVersionActivityView(slot0, slot1, slot2, slot3, slot4)
	slot5, slot6, slot7 = ActivityHelper.getActivityStatusAndToast(slot2)

	if slot5 ~= ActivityEnum.ActivityStatus.Normal then
		if slot6 then
			GameFacade.showToast(slot6, slot7)
		end

		return
	end

	if slot3 then
		slot3(slot4, slot1, slot2)

		return
	end

	ViewMgr.instance:openView(slot1)
end

function slot0.openMainViewFromFightScene(slot0)
	if Season123Model.instance:getBattleContext() then
		-- Nothing
	else
		slot2.actId = Season123Model.instance:getCurSeasonId()
	end

	slot0:openSeasonEntry({
		actId = slot1.actId
	})
end

function slot0.isSeason123EpisodeType(slot0)
	return slot0 == DungeonEnum.EpisodeType.Season123 or slot0 == DungeonEnum.EpisodeType.Season123Retail or slot0 == DungeonEnum.EpisodeType.Season123Trial
end

function slot0.canUse123EquipEpisodeType(slot0)
	return slot0 == DungeonEnum.EpisodeType.Season123 or slot0 == DungeonEnum.EpisodeType.Season123Trial
end

function slot0.isSeason123ChapterType(slot0)
	return slot0 == DungeonEnum.ChapterType.Season123 or slot0 == DungeonEnum.ChapterType.Season123Retail or slot0 == DungeonEnum.ChapterType.Season123Trial
end

function slot0.sendEpisodeUseSeason123Equip()
	if not DungeonModel.instance.curSendEpisodeId or slot0 == 0 then
		return false
	end

	if uv0.canUse123EquipEpisodeType(DungeonConfig.instance:getEpisodeCO(slot0).type) then
		return true
	end

	return false
end

function slot0.openSeasonCelebrityCardTipView(slot0, slot1)
	Season123ViewHelper.openView(nil, "CelebrityCardTipView", slot1 or {})
end

function slot0.openSeasonCelebrityCardGetView(slot0, slot1)
	Season123ViewHelper.openView(nil, "CelebrityCardGetView", slot1 or {})
end

function slot0.openSeasonStoryView(slot0, slot1)
	slot1 = slot1 or {}

	Season123ViewHelper.openView(slot1.actId, "StoryView", slot1)
end

function slot0.checkProcessFightReconnect(slot0)
	if DungeonConfig.instance:getEpisodeCO(FightModel.instance:getFightReason().episodeId) and uv0.isSeason123EpisodeType(slot3.type) then
		if slot3.type == DungeonEnum.EpisodeType.Season123 then
			if Season123Config.instance:getConfigByEpisodeId(slot2) then
				Season123Model.instance:setBattleContext(slot4.activityId, slot4.stage, slot4.layer, slot2)
			end
		elseif slot3.type == DungeonEnum.EpisodeType.Season123Retail then
			if Season123Config.instance:getRetailCOByEpisodeId(slot2) then
				Season123Model.instance:setBattleContext(slot4.activityId, nil, , slot2)
			end
		elseif slot3.type == DungeonEnum.EpisodeType.Season123Trail and Season123Config.instance:getTrailCOByEpisodeId(slot2) then
			Season123Model.instance:setBattleContext(slot4.activityId, nil, , slot2)
		end

		FightController.instance:setFightParamByEpisodeId(slot2, slot1.type == FightEnum.FightReason.DungeonRecord, slot1.multiplication and slot5 > 0 and slot5 or 1, slot1.battleId)
		HeroGroupModel.instance:setParam(slot1.battleId, slot2, false, true)
	end
end

function slot0.isEpisodeFromSeason123(slot0)
	if not slot0 then
		return false
	end

	if DungeonConfig.instance:getEpisodeCO(slot0) and uv0.isSeason123EpisodeType(slot1.type) then
		return true
	end

	return false
end

function slot0.addDontNavigateBtn(slot0, slot1)
	slot1[uv0.instance:getEpisodeLoadingViewName()] = true
	slot1[uv0.instance:getStageLoadingViewName()] = true
	slot1[uv0.instance:getStageFinishViewName()] = true
end

function slot0.openSeasonFightFailView(slot0, slot1)
	slot1 = slot1 or {}

	Season123ViewHelper.openView(slot1.actId, "FightFailView", slot1)
end

function slot0.openSeasonFightSuccView(slot0, slot1)
	slot1 = slot1 or {}

	Season123ViewHelper.openView(slot1.actId, "FightSuccView", slot1)
end

function slot0.openSeason123SettlementView(slot0, slot1)
	slot1 = slot1 or {}

	Season123ViewHelper.openView(slot1.actId, "SettlementView", slot1)
end

function slot0.openSeasonAdditionRuleTipView(slot0, slot1)
	slot1 = slot1 or {}

	Season123ViewHelper.openView(slot1.actId, "AdditionRuleTipView", slot1)
end

function slot0.openSeasonStoryPagePopView(slot0, slot1, slot2)
	slot3 = {
		actId = slot1,
		stageId = slot2
	}

	Season123ViewHelper.openView(slot3.actId, "StoryPagePopView", slot3)
end

function slot0.getSeasonIcon(slot0, slot1)
	return string.format("singlebg/%s/%s", Activity123Enum.SeasonIconFolder[slot1], slot0)
end

function slot0.checkHasReadUnlockStory(slot0, slot1)
	RedDotRpc.instance:clientAddRedDotGroupList({
		{
			uid = 0,
			id = RedDotEnum.DotNode.Season123Story,
			value = Season123Model.instance:checkHasUnlockStory(slot1) and 1 or 0
		}
	}, true)
end

function slot0.checkAndHandleEffectEquip(slot0, slot1)
	slot2 = slot1.layer

	if not Season123Model.instance:getActInfo(slot1.actId):getStageMO(slot1.stage) then
		return
	end

	if not slot2 or slot2 <= 0 then
		for slot10, slot11 in pairs(slot6.episodeMap) do
			slot1.layer = slot10

			slot0:handleEffectEquip(slot11, slot1)
		end
	else
		slot0:handleEffectEquip(slot6.episodeMap[slot2], slot1)
	end
end

function slot0.handleEffectEquip(slot0, slot1, slot2)
	for slot7, slot8 in pairs(slot1.effectMainCelebrityEquipIds or {}) do
		for slot13, slot14 in pairs(Season123Config.instance:getCardSpecialEffectMap(slot8) or {}) do
			if uv0.SpecialEffctHandleFunc[slot13] then
				slot15(slot0, slot14, slot2)
			end
		end
	end
end

function slot0.isReduceRound(slot0, slot1, slot2, slot3)
	if Season123Model.instance:getActInfo(slot1):getStageMO(slot2).reduceState then
		return slot7.reduceState[slot3]
	end

	return false
end

slot0.instance = slot0.New()

return slot0
