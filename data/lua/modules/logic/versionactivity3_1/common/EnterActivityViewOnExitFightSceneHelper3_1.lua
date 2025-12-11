module("modules.logic.versionactivity3_1.common.EnterActivityViewOnExitFightSceneHelper3_1", package.seeall)

local var_0_0 = EnterActivityViewOnExitFightSceneHelper

function var_0_0.activate()
	return
end

function var_0_0.enterActivity13113(arg_2_0, arg_2_1)
	local var_2_0 = DungeonModel.instance.curSendEpisodeId
	local var_2_1, var_2_2 = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(var_2_0)

	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(arg_2_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.V1a4_BossRushLevelDetail)
		VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
			BossRushController.instance:openMainView({
				isOpenLevelDetail = true,
				stage = var_2_1,
				layer = var_2_2
			})
		end, nil, BossRushConfig.instance:getActivityId())
	end)
end

function var_0_0.enterActivity13105(arg_5_0, arg_5_1)
	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(arg_5_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.Act191MainView)
		VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
			Activity191Controller.instance:openMainView({
				exitFromFight = true
			})
		end, nil, VersionActivity3_1Enum.ActivityId.DouQuQu3)
	end)
end

function var_0_0.enterActivity13103(arg_8_0, arg_8_1)
	var_0_0.enterVersionActivityDungeonCommon(var_0_0._enterActivity13103, arg_8_0, arg_8_1)
end

function var_0_0._enterActivity13103(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1.episodeId

	if not arg_9_1.episodeCo then
		return
	end

	if var_0_0.sequence then
		var_0_0.sequence:destroy()

		var_0_0.sequence = nil
	end

	local var_9_1 = false
	local var_9_2 = VersionActivityFixedHelper.getVersionActivityDungeonMapLevelViewName()
	local var_9_3 = VersionActivityFixedHelper.getVersionActivityDungeonMapViewName()
	local var_9_4 = VersionActivityFixedHelper.getVersionActivityEnterViewName()

	if DungeonModel.instance.curSendEpisodePass then
		var_9_1 = false

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, var_9_3)
	else
		var_9_1 = true

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, var_9_2)
	end

	local var_9_5 = FlowSequence.New()

	var_9_5:addWork(OpenViewWork.New({
		openFunction = VersionActivityFixedHelper.getVersionActivityEnterController().exitFightEnterView,
		openFunctionObj = VersionActivityFixedHelper.getVersionActivityEnterController().instance,
		waitOpenViewName = var_9_4
	}))
	var_9_5:registerDoneListener(function()
		local var_10_0 = VersionActivityFixedHelper.getVersionActivityDungeonController()

		if var_9_1 then
			var_10_0.instance:openVersionActivityDungeonMapView(nil, var_9_0, function()
				ViewMgr.instance:openView(var_9_2, {
					episodeId = var_9_0
				})
			end, nil)
		else
			var_10_0.instance:openVersionActivityDungeonMapView(nil, var_9_0)
		end
	end)
	var_9_5:start()

	var_0_0.sequence = var_9_5
end

function var_0_0.enterActivity13117(arg_12_0, arg_12_1)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId

	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(arg_12_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity3_1EnterView)

		local var_13_0 = ActivityConfig.instance:getActivityCo(VersionActivity3_1Enum.ActivityId.YeShuMei)

		if DungeonModel.instance.lastSendEpisodeId == var_13_0.tryoutEpisode then
			VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(nil, nil, VersionActivity3_1Enum.ActivityId.YeShuMei, true)
		else
			local function var_13_1()
				RoleActivityController.instance:enterActivity(VersionActivity3_1Enum.ActivityId.YeShuMei)
			end

			VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(var_13_1, nil, VersionActivity3_1Enum.ActivityId.YeShuMei, true)
		end
	end)
end

function var_0_0.enterActivity13118(arg_15_0, arg_15_1)
	local var_15_0 = 13118
	local var_15_1 = VersionActivityFixedHelper.getVersionActivityEnterController().instance
	local var_15_2 = ActivityConfig.instance:getActivityCo(var_15_0)

	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId

	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(arg_15_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity3_1EnterView)

		if DungeonModel.instance.lastSendEpisodeId == var_15_2.tryoutEpisode then
			var_15_1:openVersionActivityEnterViewIfNotOpened(nil, nil, var_15_0, true)
		else
			local function var_16_0()
				RoleActivityController.instance:enterActivity(var_15_0)
			end

			var_15_1:openVersionActivityEnterViewIfNotOpened(var_16_0, nil, var_15_0, true)
		end
	end)
end

return var_0_0
