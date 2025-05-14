module("modules.logic.versionactivity2_4.common.EnterActivityViewOnExitFightSceneHelper2_4", package.seeall)

local var_0_0 = EnterActivityViewOnExitFightSceneHelper

function var_0_0.activate()
	return
end

function var_0_0.enterActivity12404(arg_2_0, arg_2_1)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(arg_2_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_4EnterView)
		VersionActivity2_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, VersionActivity2_4Enum.ActivityId.Pinball, true)
	end)
end

function var_0_0.enterActivity12405(arg_4_0, arg_4_1)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(arg_4_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_4EnterView)
		VersionActivity2_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, VersionActivity2_4Enum.ActivityId.MusicGame, true)
	end)
end

function var_0_0.enterActivity12400(arg_6_0, arg_6_1)
	var_0_0.enterVersionActivityDungeonCommon(var_0_0._enterActivityDungeonAterFight12400, arg_6_0, arg_6_1)
end

function var_0_0._enterActivityDungeonAterFight12400(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1.episodeId
	local var_7_1 = arg_7_1.exitFightGroup

	if not var_7_0 then
		return
	end

	local var_7_2 = Season166Model.instance:getBattleContext()

	if not var_7_2 then
		return false
	end

	local var_7_3 = var_7_2.trainId
	local var_7_4 = var_7_2.baseId
	local var_7_5 = var_7_2.actId
	local var_7_6 = var_0_0.recordMO and var_0_0.recordMO.fightResult
	local var_7_7 = DungeonConfig.instance:getEpisodeCO(var_7_0)
	local var_7_8 = var_7_7 and var_7_7.type
	local var_7_9
	local var_7_10

	if var_7_7 then
		if not var_7_6 or var_7_6 == -1 or var_7_6 == 0 then
			if var_7_8 == DungeonEnum.EpisodeType.Season166Base then
				var_7_9 = Season166Enum.JumpId.BaseSpotEpisode
				var_7_10 = {
					baseId = var_7_4
				}
			elseif var_7_8 == DungeonEnum.EpisodeType.Season166Train then
				var_7_9 = Season166Enum.JumpId.TrainEpisode
				var_7_10 = {
					trainId = var_7_3
				}
			elseif var_7_8 == DungeonEnum.EpisodeType.Season166Teach then
				var_7_9 = Season166Enum.JumpId.TeachView
			end
		elseif var_7_6 == 1 then
			if var_7_8 == DungeonEnum.EpisodeType.Season166Base then
				var_7_9 = Season166Enum.JumpId.MainView
			elseif var_7_8 == DungeonEnum.EpisodeType.Season166Train then
				var_7_9 = Season166Enum.JumpId.TrainView
			elseif var_7_8 == DungeonEnum.EpisodeType.Season166Teach then
				var_7_9 = Season166Enum.JumpId.TeachView
			end
		end
	else
		logError(string.format("找不到对应关卡表,id:%s", var_7_0))
	end

	VersionActivity2_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		Season166Controller.instance:openSeasonView({
			actId = var_7_5,
			jumpId = var_7_9,
			jumpParam = var_7_10
		})
	end, nil, VersionActivity2_4Enum.ActivityId.Season)
end

function var_0_0.enterActivity12402(arg_9_0, arg_9_1)
	var_0_0.enterVersionActivityDungeonCommon(var_0_0._enterActivity12402, arg_9_0, arg_9_1)
end

function var_0_0._enterActivity12402(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1.episodeId

	if not arg_10_1.episodeCo then
		return
	end

	if var_0_0.sequence then
		var_0_0.sequence:destroy()

		var_0_0.sequence = nil
	end

	local var_10_1 = false

	if DungeonModel.instance.curSendEpisodePass then
		var_10_1 = false

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_4DungeonMapView)
	else
		var_10_1 = true

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_4DungeonMapLevelView)
	end

	local var_10_2 = FlowSequence.New()

	var_10_2:addWork(OpenViewWork.New({
		openFunction = VersionActivity2_4EnterController.directOpenVersionActivityEnterView,
		openFunctionObj = VersionActivity2_4EnterController.instance,
		waitOpenViewName = ViewName.VersionActivity2_4EnterView
	}))
	var_10_2:registerDoneListener(function()
		if var_10_1 then
			VersionActivity2_4DungeonController.instance:openVersionActivityDungeonMapView(nil, var_10_0, function()
				ViewMgr.instance:openView(ViewName.VersionActivity2_4DungeonMapLevelView, {
					episodeId = var_10_0
				})
			end, nil)
		else
			VersionActivity2_4DungeonController.instance:openVersionActivityDungeonMapView(nil, var_10_0)
		end
	end)
	var_10_2:start()

	var_0_0.sequence = var_10_2
end

function var_0_0.enterActivity12410(arg_13_0, arg_13_1)
	local var_13_0 = DungeonModel.instance.curSendEpisodeId
	local var_13_1, var_13_2 = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(var_13_0)

	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(arg_13_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.V1a4_BossRushMainView)
		VersionActivity2_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			BossRushController.instance:openMainView({
				isOpenLevelDetail = true,
				stage = var_13_1,
				layer = var_13_2
			})
		end, nil, BossRushConfig.instance:getActivityId())
	end)
end

return var_0_0
