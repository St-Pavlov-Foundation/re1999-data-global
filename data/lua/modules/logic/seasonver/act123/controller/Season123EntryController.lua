module("modules.logic.seasonver.act123.controller.Season123EntryController", package.seeall)

slot0 = class("Season123EntryController", BaseController)

function slot0.onOpenView(slot0, slot1)
	Season123EntryModel.instance:init(slot1)
	Activity123Rpc.instance:sendGet123InfosRequest(slot1)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Season123
	})
end

function slot0.onCloseView(slot0)
	Season123EntryModel.instance:release()
end

function slot0.openStage(slot0, slot1)
	if not Season123Model.instance:getActInfo(Season123EntryModel.instance.activityId) then
		return
	end

	if not slot3:getStageMO(slot1) then
		return
	end

	slot5, slot6, slot7 = Season123ProgressUtils.isStageUnlock(slot2, slot1)

	if not slot5 then
		GameFacade.showToast(ToastEnum.SeasonStageLockTip, Season123Config.instance:getStageCo(slot2, slot1).name)

		return
	end

	if slot4.episodeMap[1] and not slot4.episodeMap[1]:isFinished() and slot1 ~= slot3.stage then
		if slot3.stage ~= 0 and slot1 ~= slot3.stage and not Season123ProgressUtils.checkStageIsFinish(slot2, slot3.stage) then
			GameFacade.showMessageBox(MessageBoxIdDefine.Season123WarningCleanStage, MsgBoxEnum.BoxType.Yes_No, slot0.cleanAndStartPickHero, nil, , slot0)
		else
			slot0:startPickHero()
		end
	else
		return true
	end
end

function slot0.startPickHero(slot0)
	ViewMgr.instance:openView(Season123Controller.instance:getPickHeroEntryViewName(), {
		actId = Season123EntryModel.instance.activityId,
		stage = Season123EntryModel.instance:getCurrentStage(),
		finishCall = slot0.handlePickHeroSuccess,
		finishCallObj = slot0
	})
end

function slot0.cleanAndStartPickHero(slot0)
	if Season123Model.instance:getActInfo(Season123EntryModel.instance.activityId) then
		Activity123Rpc.instance:sendAct123EndStageRequest(Season123EntryModel.instance.activityId, slot1.stage, slot0.onReceiveReset, slot0)
	end
end

function slot0.onReceiveReset(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		GameFacade.showToast(ToastEnum.WeekwalkResetLayer)
	end

	Activity123Rpc.instance:sendGet123InfosRequest(Season123EntryModel.instance.activityId, slot0.startPickHero, slot0)
end

function slot0.openStageRecords(slot0, slot1)
	slot2 = Season123EntryModel.instance.activityId

	Season123RecordModel.instance:setServerDataVerifiableId(slot2, slot1)
	Activity123Rpc.instance:sendGetAct123StageRecordRequest(slot2, slot1, slot0._realOpenStageRecords, slot0)
end

function slot0.processJumpParam(slot0, slot1)
	if slot1.jumpId == Activity123Enum.JumpId.Market or slot1.jumpId == Activity123Enum.JumpId.MarketNoResult then
		Season123Controller.instance:dispatchEvent(Season123Event.OtherViewAutoOpened)
		ViewMgr.instance:openView(Season123Controller.instance:getEpisodeListViewName(), {
			actId = Season123EntryModel.instance.activityId,
			stage = Season123Model.instance:getBattleContext().stage,
			jumpId = slot1.jumpId,
			jumpParam = slot1.jumpParam
		})
	elseif slot1.jumpId == Activity123Enum.JumpId.Retail then
		Season123Controller.instance:dispatchEvent(Season123Event.OtherViewAutoOpened)
		Season123Controller.instance:openSeasonRetail({
			actId = Season123EntryModel.instance.activityId
		})
	elseif slot1.jumpId == Activity123Enum.JumpId.ForStage then
		slot0:goToStage(slot1.jumpParam.stage)
	elseif slot1.jumpId == Activity123Enum.JumpId.MarketStageFinish then
		slot0:goToStage(slot1.jumpParam.stage)
		Season123Controller.instance:dispatchEvent(Season123Event.OtherViewAutoOpened)
		ViewMgr.instance:openView(Season123Controller.instance:getStageFinishViewName(), {
			actId = Season123EntryModel.instance.activityId,
			stage = slot1.jumpParam.stage
		})
	end
end

function slot0._realOpenStageRecords(slot0)
	ViewMgr.instance:openView(Season123Controller.instance:getRecordWindowViewName())
end

function slot0.switchStage(slot0, slot1)
	slot2 = nil

	if (not slot1 or Season123EntryModel.instance:getNextStage()) and Season123EntryModel.instance:getPrevStage() then
		Season123Controller.instance:dispatchEvent(Season123Event.LocateToStage, {
			actId = Season123EntryModel.instance.activityId,
			stageId = slot2
		})
	end
end

function slot0.goToStage(slot0, slot1)
	Season123EntryModel.instance:setCurrentStage(slot1)
	uv0.instance:dispatchEvent(Season123Event.EntryStageChanged)
end

function slot0.handlePickHeroSuccess(slot0)
	Activity123Rpc.instance:sendGet123InfosRequest(Season123EntryModel.instance.activityId, slot0.handleEnterStage, slot0)
end

function slot0.handleEnterStage(slot0)
	ViewMgr.instance:openView(Season123Controller.instance:getStageLoadingViewName(), {
		actId = Season123EntryModel.instance.activityId,
		stage = Season123EntryModel.instance:getCurrentStage()
	})
end

function slot0.enterTrailFightScene(slot0)
	if Season123EntryModel.instance:getTrialCO() then
		slot0:startBattle(Season123EntryModel.instance.activityId, slot1.episodeId)
	end
end

function slot0.startBattle(slot0, slot1, slot2)
	logNormal(string.format("startBattle with actId = %s, episodeId = %s", slot1, slot2))
	Season123Model.instance:setBattleContext(slot1, nil, , slot2)
	DungeonFightController.instance:enterSeasonFight(DungeonConfig.instance:getEpisodeCO(slot2).chapterId, slot2)
end

slot0.instance = slot0.New()

LuaEventSystem.addEventMechanism(slot0.instance)

return slot0
