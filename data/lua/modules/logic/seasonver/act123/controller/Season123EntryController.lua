module("modules.logic.seasonver.act123.controller.Season123EntryController", package.seeall)

local var_0_0 = class("Season123EntryController", BaseController)

function var_0_0.onOpenView(arg_1_0, arg_1_1)
	Season123EntryModel.instance:init(arg_1_1)
	Activity123Rpc.instance:sendGet123InfosRequest(arg_1_1)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Season123
	})
end

function var_0_0.onCloseView(arg_2_0)
	Season123EntryModel.instance:release()
end

function var_0_0.openStage(arg_3_0, arg_3_1)
	local var_3_0 = Season123EntryModel.instance.activityId
	local var_3_1 = Season123Model.instance:getActInfo(var_3_0)

	if not var_3_1 then
		return
	end

	local var_3_2 = var_3_1:getStageMO(arg_3_1)

	if not var_3_2 then
		return
	end

	local var_3_3, var_3_4, var_3_5 = Season123ProgressUtils.isStageUnlock(var_3_0, arg_3_1)

	if not var_3_3 then
		local var_3_6 = Season123Config.instance:getStageCo(var_3_0, arg_3_1)

		GameFacade.showToast(ToastEnum.SeasonStageLockTip, var_3_6.name)

		return
	end

	if var_3_2.episodeMap[1] and not var_3_2.episodeMap[1]:isFinished() and arg_3_1 ~= var_3_1.stage then
		if var_3_1.stage ~= 0 and arg_3_1 ~= var_3_1.stage and not Season123ProgressUtils.checkStageIsFinish(var_3_0, var_3_1.stage) then
			GameFacade.showMessageBox(MessageBoxIdDefine.Season123WarningCleanStage, MsgBoxEnum.BoxType.Yes_No, arg_3_0.cleanAndStartPickHero, nil, nil, arg_3_0)
		else
			arg_3_0:startPickHero()
		end
	else
		return true
	end
end

function var_0_0.startPickHero(arg_4_0)
	ViewMgr.instance:openView(Season123Controller.instance:getPickHeroEntryViewName(), {
		actId = Season123EntryModel.instance.activityId,
		stage = Season123EntryModel.instance:getCurrentStage(),
		finishCall = arg_4_0.handlePickHeroSuccess,
		finishCallObj = arg_4_0
	})
end

function var_0_0.cleanAndStartPickHero(arg_5_0)
	local var_5_0 = Season123Model.instance:getActInfo(Season123EntryModel.instance.activityId)

	if var_5_0 then
		Activity123Rpc.instance:sendAct123EndStageRequest(Season123EntryModel.instance.activityId, var_5_0.stage, arg_5_0.onReceiveReset, arg_5_0)
	end
end

function var_0_0.onReceiveReset(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_2 == 0 then
		GameFacade.showToast(ToastEnum.WeekwalkResetLayer)
	end

	Activity123Rpc.instance:sendGet123InfosRequest(Season123EntryModel.instance.activityId, arg_6_0.startPickHero, arg_6_0)
end

function var_0_0.openStageRecords(arg_7_0, arg_7_1)
	local var_7_0 = Season123EntryModel.instance.activityId

	Season123RecordModel.instance:setServerDataVerifiableId(var_7_0, arg_7_1)
	Activity123Rpc.instance:sendGetAct123StageRecordRequest(var_7_0, arg_7_1, arg_7_0._realOpenStageRecords, arg_7_0)
end

function var_0_0.processJumpParam(arg_8_0, arg_8_1)
	if arg_8_1.jumpId == Activity123Enum.JumpId.Market or arg_8_1.jumpId == Activity123Enum.JumpId.MarketNoResult then
		local var_8_0 = Season123Model.instance:getBattleContext()

		Season123Controller.instance:dispatchEvent(Season123Event.OtherViewAutoOpened)
		ViewMgr.instance:openView(Season123Controller.instance:getEpisodeListViewName(), {
			actId = Season123EntryModel.instance.activityId,
			stage = var_8_0.stage,
			jumpId = arg_8_1.jumpId,
			jumpParam = arg_8_1.jumpParam
		})
	elseif arg_8_1.jumpId == Activity123Enum.JumpId.Retail then
		Season123Controller.instance:dispatchEvent(Season123Event.OtherViewAutoOpened)
		Season123Controller.instance:openSeasonRetail({
			actId = Season123EntryModel.instance.activityId
		})
	elseif arg_8_1.jumpId == Activity123Enum.JumpId.ForStage then
		arg_8_0:goToStage(arg_8_1.jumpParam.stage)
	elseif arg_8_1.jumpId == Activity123Enum.JumpId.MarketStageFinish then
		arg_8_0:goToStage(arg_8_1.jumpParam.stage)
		Season123Controller.instance:dispatchEvent(Season123Event.OtherViewAutoOpened)
		ViewMgr.instance:openView(Season123Controller.instance:getStageFinishViewName(), {
			actId = Season123EntryModel.instance.activityId,
			stage = arg_8_1.jumpParam.stage
		})
	end
end

function var_0_0._realOpenStageRecords(arg_9_0)
	local var_9_0 = Season123Controller.instance:getRecordWindowViewName()

	ViewMgr.instance:openView(var_9_0)
end

function var_0_0.switchStage(arg_10_0, arg_10_1)
	local var_10_0

	if arg_10_1 then
		var_10_0 = Season123EntryModel.instance:getNextStage()
	else
		var_10_0 = Season123EntryModel.instance:getPrevStage()
	end

	if var_10_0 then
		Season123Controller.instance:dispatchEvent(Season123Event.LocateToStage, {
			actId = Season123EntryModel.instance.activityId,
			stageId = var_10_0
		})
	end
end

function var_0_0.goToStage(arg_11_0, arg_11_1)
	Season123EntryModel.instance:setCurrentStage(arg_11_1)
	var_0_0.instance:dispatchEvent(Season123Event.EntryStageChanged)
end

function var_0_0.handlePickHeroSuccess(arg_12_0)
	local var_12_0 = Season123EntryModel.instance.activityId

	Activity123Rpc.instance:sendGet123InfosRequest(var_12_0, arg_12_0.handleEnterStage, arg_12_0)
end

function var_0_0.handleEnterStage(arg_13_0)
	ViewMgr.instance:openView(Season123Controller.instance:getStageLoadingViewName(), {
		actId = Season123EntryModel.instance.activityId,
		stage = Season123EntryModel.instance:getCurrentStage()
	})
end

function var_0_0.enterTrailFightScene(arg_14_0)
	local var_14_0 = Season123EntryModel.instance:getTrialCO()

	if var_14_0 then
		arg_14_0:startBattle(Season123EntryModel.instance.activityId, var_14_0.episodeId)
	end
end

function var_0_0.startBattle(arg_15_0, arg_15_1, arg_15_2)
	logNormal(string.format("startBattle with actId = %s, episodeId = %s", arg_15_1, arg_15_2))

	local var_15_0 = DungeonConfig.instance:getEpisodeCO(arg_15_2)

	Season123Model.instance:setBattleContext(arg_15_1, nil, nil, arg_15_2)
	DungeonFightController.instance:enterSeasonFight(var_15_0.chapterId, arg_15_2)
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0
