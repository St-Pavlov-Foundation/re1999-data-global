-- chunkname: @modules/logic/versionactivity3_1/common/EnterActivityViewOnExitFightSceneHelper3_1.lua

module("modules.logic.versionactivity3_1.common.EnterActivityViewOnExitFightSceneHelper3_1", package.seeall)

local EnterActivityViewOnExitFightSceneHelper = EnterActivityViewOnExitFightSceneHelper

function EnterActivityViewOnExitFightSceneHelper.activate()
	return
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity13113(forceStarting, exitFightGroup)
	local episodeId = DungeonModel.instance.curSendEpisodeId
	local stage, layer = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(episodeId)

	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.V1a4_BossRushLevelDetail)
		VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
			BossRushController.instance:openMainView({
				isOpenLevelDetail = true,
				stage = stage,
				layer = layer
			})
		end, nil, BossRushConfig.instance:getActivityId())
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity13105(forceStarting, exitFightGroup)
	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.Act191MainView)
		VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
			Activity191Controller.instance:openMainView({
				exitFromFight = true
			})
		end, nil, VersionActivity3_1Enum.ActivityId.DouQuQu3)
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity13103(forceStarting, exitFightGroup)
	EnterActivityViewOnExitFightSceneHelper.enterVersionActivityDungeonCommon(EnterActivityViewOnExitFightSceneHelper._enterActivity13103, forceStarting, exitFightGroup)
end

function EnterActivityViewOnExitFightSceneHelper._enterActivity13103(cls, param)
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

function EnterActivityViewOnExitFightSceneHelper.enterActivity13117(forceStarting, exitFightGroup)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId

	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity3_1EnterView)

		local actCo = ActivityConfig.instance:getActivityCo(VersionActivity3_1Enum.ActivityId.YeShuMei)

		if DungeonModel.instance.lastSendEpisodeId == actCo.tryoutEpisode then
			VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(nil, nil, VersionActivity3_1Enum.ActivityId.YeShuMei, true)
		else
			local function returnViewAction()
				RoleActivityController.instance:enterActivity(VersionActivity3_1Enum.ActivityId.YeShuMei)
			end

			VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(returnViewAction, nil, VersionActivity3_1Enum.ActivityId.YeShuMei, true)
		end
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity13118(forceStarting, exitFightGroup)
	local actId = 13118
	local versionActCtrlInst = VersionActivityFixedHelper.getVersionActivityEnterController().instance
	local actCo = ActivityConfig.instance:getActivityCo(actId)

	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId

	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity3_1EnterView)

		if DungeonModel.instance.lastSendEpisodeId == actCo.tryoutEpisode then
			versionActCtrlInst:openVersionActivityEnterViewIfNotOpened(nil, nil, actId, true)
		else
			local function returnViewAction()
				RoleActivityController.instance:enterActivity(actId)
			end

			versionActCtrlInst:openVersionActivityEnterViewIfNotOpened(returnViewAction, nil, actId, true)
		end
	end)
end

return EnterActivityViewOnExitFightSceneHelper
