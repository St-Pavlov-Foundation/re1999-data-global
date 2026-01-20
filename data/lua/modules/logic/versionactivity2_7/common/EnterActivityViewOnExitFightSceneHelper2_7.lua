-- chunkname: @modules/logic/versionactivity2_7/common/EnterActivityViewOnExitFightSceneHelper2_7.lua

module("modules.logic.versionactivity2_7.common.EnterActivityViewOnExitFightSceneHelper2_7", package.seeall)

local EnterActivityViewOnExitFightSceneHelper = EnterActivityViewOnExitFightSceneHelper

function EnterActivityViewOnExitFightSceneHelper.activate()
	return
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity12701(forceStarting, exitFightGroup)
	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_7EnterView)
		VersionActivityFixedEnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			Activity191Controller.instance:openMainView({
				exitFromFight = true
			})
		end, nil, VersionActivity2_7Enum.ActivityId.Act191, true)
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity12703(forceStarting, exitFightGroup)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_7EnterView)
		VersionActivityFixedEnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, VersionActivity2_7Enum.ActivityId.CooperGarland, true)
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity12702(forceStarting, exitFightGroup)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId

	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_7EnterView)
		VersionActivityFixedEnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, VersionActivity2_7Enum.ActivityId.LengZhou6, true)
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity12706(forceStarting, exitFightGroup)
	EnterActivityViewOnExitFightSceneHelper.enterVersionActivityDungeonCommon(EnterActivityViewOnExitFightSceneHelper._enterActivity12706, forceStarting, exitFightGroup)
end

function EnterActivityViewOnExitFightSceneHelper._enterActivity12706(cls, param)
	local episodeId = param.episodeId
	local episodeCo = param.episodeCo

	if not episodeCo then
		return
	end

	if EnterActivityViewOnExitFightSceneHelper.sequence then
		EnterActivityViewOnExitFightSceneHelper.sequence:destroy()

		EnterActivityViewOnExitFightSceneHelper.sequence = nil
	end

	local needLoadMapLevel = false
	local mapLevelViewName = VersionActivityFixedHelper.getVersionActivityDungeonMapLevelViewName()
	local mapViewName = VersionActivityFixedHelper.getVersionActivityDungeonMapViewName()
	local enterViewName = VersionActivityFixedHelper.getVersionActivityEnterViewName()

	if DungeonModel.instance.curSendEpisodePass then
		needLoadMapLevel = false

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, mapViewName)
	else
		needLoadMapLevel = true

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, mapLevelViewName)
	end

	local sequence = FlowSequence.New()

	sequence:addWork(OpenViewWork.New({
		openFunction = VersionActivityFixedHelper.getVersionActivityEnterController().exitFightEnterView,
		openFunctionObj = VersionActivityFixedHelper.getVersionActivityEnterController().instance,
		waitOpenViewName = enterViewName
	}))
	sequence:registerDoneListener(function()
		local dungeonController = VersionActivityFixedHelper.getVersionActivityDungeonController()

		if needLoadMapLevel then
			dungeonController.instance:openVersionActivityDungeonMapView(nil, episodeId, function()
				ViewMgr.instance:openView(mapLevelViewName, {
					episodeId = episodeId
				})
			end, nil)
		else
			dungeonController.instance:openVersionActivityDungeonMapView(nil, episodeId)
		end
	end)
	sequence:start()

	EnterActivityViewOnExitFightSceneHelper.sequence = sequence
end

return EnterActivityViewOnExitFightSceneHelper
