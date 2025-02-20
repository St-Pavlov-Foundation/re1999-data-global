module("modules.logic.weekwalk.controller.WeekWalkController", package.seeall)

slot0 = class("WeekWalkController", BaseController)

function slot0.onInit(slot0)
	slot0:clear()
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
	TaskController.instance:registerCallback(TaskEvent.SetTaskList, slot0._refreshTaskData, slot0)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, slot0._refreshTaskData, slot0)
	uv0.instance:registerCallback(WeekWalkEvent.OnGetInfo, slot0.startCheckTime, slot0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0._onDailyRefresh, slot0, LuaEventSystem.Low)
end

function slot0._onDailyRefresh(slot0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.WeekWalk) then
		return
	end

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.WeekWalk
	})
	WeekwalkRpc.instance:sendGetWeekwalkInfoRequest()
end

function slot0.startCheckTime(slot0)
	TaskDispatcher.runRepeat(slot0._checkTime, slot0, 1)
end

function slot0.stopCheckTime(slot0)
	TaskDispatcher.cancelTask(slot0._checkTime, slot0)
end

function slot0._checkTime(slot0)
	if not WeekWalkModel.instance:getInfo() or not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.WeekWalk) then
		slot0:stopCheckTime()

		return
	end

	if slot1.endTime - ServerTime.now() <= 0 then
		slot0:stopCheckTime()

		if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
			WeekWalkModel.instance:addOldInfo()
		end

		slot0:requestTask(true)
		WeekwalkRpc.instance:sendGetWeekwalkInfoRequest()
	end
end

function slot0.reInit(slot0)
	slot0:clear()
end

function slot0.clear(slot0)
	slot0._requestTask = false
end

function slot0._refreshTaskData(slot0)
	WeekWalkTaskListModel.instance:updateTaskList()
	slot0:dispatchEvent(WeekWalkEvent.OnWeekwalkTaskUpdate)
end

function slot0.getTaskEndTime(slot0)
	for slot5, slot6 in ipairs(TaskConfig.instance:getWeekWalkTaskList(slot0)) do
		return WeekWalkTaskListModel.instance:getTaskMo(slot6.id) and slot7.expiryTime
	end
end

function slot0.requestTask(slot0, slot1)
	if slot0._requestTask and not slot1 then
		return
	end

	slot0._requestTask = true

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.WeekWalk
	})
end

function slot0.openWeekWalkCharacterView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.WeekWalkCharacterView, slot1, slot2)
end

function slot0.openWeekWalkTarotView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.WeekWalkTarotView, slot1, slot2)
end

function slot0.openWeekWalkReviveView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.WeekWalkReviveView, slot1, slot2)
end

function slot0.openWeekWalkRuleView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.WeekWalkRuleView, slot1, slot2)
end

function slot0.openWeekWalkShallowSettlementView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.WeekWalkShallowSettlementView, slot1, slot2)
end

function slot0.openWeekWalkDeepLayerNoticeView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.WeekWalkDeepLayerNoticeView, slot1, slot2)
end

function slot0.checkOpenWeekWalkDeepLayerNoticeView(slot0, slot1, slot2)
	if WeekWalkEnum.FirstDeepLayer <= WeekWalkModel.instance:getMaxLayerId() or GuideController.instance:isForbidGuides() or GuideModel.instance:isGuideFinish(GuideEnum.GuideId.WeekWalkDeep) then
		slot0:openWeekWalkDeepLayerNoticeView()
	end
end

function slot0.openWeekWalkView(slot0, slot1, slot2)
	if not (slot1 or {}).mapId then
		slot3 = FightModel.instance:getBattleId()

		FightModel.instance:clearBattleId()

		slot1.mapId = WeekWalkModel.instance:getCurMapId()
	end

	if slot1.mapId then
		WeekWalkModel.instance:setCurMapId(slot1.mapId)
	end

	ViewMgr.instance:openView(ViewName.WeekWalkView, slot1, slot2)
end

function slot0.openWeekWalkDegradeView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.WeekWalkDegradeView, slot1, slot2)
end

function slot0.openWeekWalkDialogView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.WeekWalkDialogView, slot1, slot2)
end

function slot0.openWeekWalkQuestionView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.WeekWalkQuestionView, slot1, slot2)
end

function slot0.openWeekWalkResetView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.WeekWalkResetView, slot1, slot2)
end

function slot0.openWeekWalkLayerView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.WeekWalkLayerView, slot1, slot2)
end

function slot0.openWeekWalkRewardView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.WeekWalkRewardView, slot1, slot2)
end

function slot0.openWeekWalkLayerRewardView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.WeekWalkLayerRewardView, slot1, slot2)
end

function slot0.openWeekWalkEnemyInfoView(slot0, slot1, slot2)
	logError("废弃 view")
end

function slot0.openWeekWalkBuffBindingView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.WeekWalkBuffBindingView, slot1, slot2)
end

function slot0.openWeekWalkRespawnView(slot0, slot1, slot2)
	if WeekWalkModel.instance:getInfo():haveDeathHero() then
		ViewMgr.instance:openView(ViewName.WeekWalkRespawnView, slot1, slot2)
	else
		GameFacade.showToast(ToastEnum.AdventureRespawn)
	end
end

function slot0.enterWeekwalkFight(slot0, slot1)
	slot5 = WeekWalkEnum.episodeId
	DungeonModel.instance.curLookEpisodeId = slot5

	DungeonFightController.instance:enterWeekwalkFight(DungeonConfig.instance:getEpisodeCO(slot5).chapterId, slot5, WeekWalkModel.instance:getElementInfo(WeekWalkModel.instance:getCurMapId(), slot1):getBattleId())
end

function slot0.jumpWeekWalkDeepLayerView(slot0, slot1, slot2)
	slot0._jumpCallback = slot1
	slot0._jumpCallbackTarget = slot2

	module_views_preloader.preloadMultiView(slot0._preloadCallback, slot0, {
		ViewName.DungeonView,
		ViewName.WeekWalkLayerView
	}, {
		DungeonEnum.dungeonweekwalkviewPath
	})
end

function slot0._preloadCallback(slot0)
	WeekWalkModel.instance:setSkipShowSettlementView(true)
	DungeonModel.instance:changeCategory(DungeonEnum.ChapterType.WeekWalk)
	DungeonController.instance:enterDungeonView()
	TaskDispatcher.runDelay(slot0._delayOpenLayerView, slot0, 0)

	slot0._jumpCallback = nil
	slot0._jumpCallbackTarget = nil

	if slot0._jumpCallback then
		slot1(slot0._jumpCallbackTarget)
	end
end

function slot0._delayOpenLayerView(slot0)
	uv0.instance:openWeekWalkLayerView({
		layerId = 11
	})
end

slot0.instance = slot0.New()

return slot0
