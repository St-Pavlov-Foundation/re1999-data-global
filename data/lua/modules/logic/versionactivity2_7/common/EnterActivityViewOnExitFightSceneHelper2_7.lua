module("modules.logic.versionactivity2_7.common.EnterActivityViewOnExitFightSceneHelper2_7", package.seeall)

local var_0_0 = EnterActivityViewOnExitFightSceneHelper

function var_0_0.activate()
	return
end

function var_0_0.enterActivity12701(arg_2_0, arg_2_1)
	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(arg_2_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_7EnterView)
		VersionActivityFixedEnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			Activity191Controller.instance:openMainView({
				exitFromFight = true
			})
		end, nil, VersionActivity2_7Enum.ActivityId.Act191, true)
	end)
end

function var_0_0.enterActivity12703(arg_5_0, arg_5_1)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(arg_5_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_7EnterView)
		VersionActivityFixedEnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, VersionActivity2_7Enum.ActivityId.CooperGarland, true)
	end)
end

function var_0_0.enterActivity12702(arg_7_0, arg_7_1)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId

	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(arg_7_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_7EnterView)
		VersionActivityFixedEnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, VersionActivity2_7Enum.ActivityId.LengZhou6, true)
	end)
end

function var_0_0.enterActivity12706(arg_9_0, arg_9_1)
	var_0_0.enterVersionActivityDungeonCommon(var_0_0._enterActivity12706, arg_9_0, arg_9_1)
end

function var_0_0._enterActivity12706(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1.episodeId

	if not arg_10_1.episodeCo then
		return
	end

	if var_0_0.sequence then
		var_0_0.sequence:destroy()

		var_0_0.sequence = nil
	end

	local var_10_1 = false
	local var_10_2 = VersionActivityFixedHelper.getVersionActivityDungeonMapLevelViewName()
	local var_10_3 = VersionActivityFixedHelper.getVersionActivityDungeonMapViewName()
	local var_10_4 = VersionActivityFixedHelper.getVersionActivityEnterViewName()

	if DungeonModel.instance.curSendEpisodePass then
		var_10_1 = false

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, var_10_3)
	else
		var_10_1 = true

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, var_10_2)
	end

	local var_10_5 = FlowSequence.New()

	var_10_5:addWork(OpenViewWork.New({
		openFunction = VersionActivityFixedHelper.getVersionActivityEnterController().exitFightEnterView,
		openFunctionObj = VersionActivityFixedHelper.getVersionActivityEnterController().instance,
		waitOpenViewName = var_10_4
	}))
	var_10_5:registerDoneListener(function()
		local var_11_0 = VersionActivityFixedHelper.getVersionActivityDungeonController()

		if var_10_1 then
			var_11_0.instance:openVersionActivityDungeonMapView(nil, var_10_0, function()
				ViewMgr.instance:openView(var_10_2, {
					episodeId = var_10_0
				})
			end, nil)
		else
			var_11_0.instance:openVersionActivityDungeonMapView(nil, var_10_0)
		end
	end)
	var_10_5:start()

	var_0_0.sequence = var_10_5
end

return var_0_0
