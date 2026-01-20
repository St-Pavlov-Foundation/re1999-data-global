-- chunkname: @modules/logic/sp01/enter/controller/EnterActivityViewOnExitFightSceneHelper2_9.lua

module("modules.logic.sp01.enter.controller.EnterActivityViewOnExitFightSceneHelper2_9", package.seeall)

local EnterActivityViewOnExitFightSceneHelper = EnterActivityViewOnExitFightSceneHelper

local function _enterActivity12003(cls, param)
	local isPermanent = true
	local modelInst = VersionActivity2_0DungeonModel.instance
	local controllerInst = VersionActivity2_0DungeonController.instance
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

	if episodeCo.chapterId == VersionActivity2_0DungeonEnum.DungeonChapterId.ElementFight then
		DungeonMapModel.instance.lastElementBattleId = episodeId
		episodeId = modelInst:getLastEpisodeId()

		if episodeId then
			modelInst:setLastEpisodeId(nil)
		else
			episodeId = DungeonConfig.instance:getActivityElementFightEpisodeToNormalEpisodeId(episodeCo, VersionActivity2_0DungeonEnum.DungeonChapterId.Story)
		end

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_0DungeonMapView)
	elseif DungeonModel.instance.curSendEpisodePass then
		needLoadMapLevel = false

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_0DungeonMapView)
	else
		needLoadMapLevel = true

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_0DungeonMapLevelView)
	end

	local sequence = FlowSequence.New()

	if isPermanent then
		PermanentController.instance:jump2Activity(VersionActivity2_0Enum.ActivityId.EnterView)
		sequence:addWork(OpenViewWork.New({
			openFunction = function()
				return
			end,
			waitOpenViewName = ViewName.Permanent2_0EnterView
		}))
	else
		sequence:addWork(OpenViewWork.New({
			openFunction = EnterActivityViewOnExitFightSceneHelper.open2_7ReactivityEnterView,
			openFunctionObj = VersionActivityFixedHelper.getVersionActivityEnterController().instance,
			waitOpenViewName = VersionActivityFixedHelper.getVersionActivityEnterViewName()
		}))
	end

	sequence:registerDoneListener(function()
		if needLoadMapLevel then
			controllerInst:openVersionActivityDungeonMapView(nil, episodeId, function()
				ViewMgr.instance:openView(ViewName.VersionActivity2_0DungeonMapLevelView, {
					episodeId = episodeId
				})
			end, nil)
		else
			controllerInst:openVersionActivityDungeonMapView(nil, episodeId)
		end
	end)
	sequence:start()

	EnterActivityViewOnExitFightSceneHelper.sequence = sequence
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity12003(forceStarting, exitFightGroup)
	EnterActivityViewOnExitFightSceneHelper.enterVersionActivityDungeonCommon(_enterActivity12003, forceStarting, exitFightGroup)
end

function EnterActivityViewOnExitFightSceneHelper.activate()
	return
end

local function _enterActivity12302(cls, param)
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

	if episodeCo.chapterId == VersionActivity2_3DungeonEnum.DungeonChapterId.ElementFight then
		DungeonMapModel.instance.lastElementBattleId = episodeId
		episodeId = VersionActivity2_3DungeonModel.instance:getLastEpisodeId()

		if episodeId then
			VersionActivity2_3DungeonModel.instance:setLastEpisodeId(nil)
		else
			episodeId = DungeonConfig.instance:getActivityElementFightEpisodeToNormalEpisodeId(episodeCo, VersionActivity2_3DungeonEnum.DungeonChapterId.Story)
		end

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_3DungeonMapView)
	elseif DungeonModel.instance.curSendEpisodePass then
		needLoadMapLevel = false

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_3DungeonMapView)
	else
		needLoadMapLevel = true

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_3DungeonMapLevelView)
	end

	local sequence = FlowSequence.New()

	sequence:addWork(OpenViewWork.New({
		openFunction = function()
			ViewMgr.instance:openView(ViewName.V2a3_ReactivityEnterview)
		end
	}))
	sequence:registerDoneListener(function()
		if needLoadMapLevel then
			VersionActivity2_3DungeonController.instance:openVersionActivityDungeonMapView(nil, episodeId, function()
				ViewMgr.instance:openView(ViewName.VersionActivity2_3DungeonMapLevelView, {
					episodeId = episodeId
				})
			end, nil)
		else
			VersionActivity2_3DungeonController.instance:openVersionActivityDungeonMapView(nil, episodeId)
		end
	end)
	sequence:start()

	EnterActivityViewOnExitFightSceneHelper.sequence = sequence
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity130502(forceStarting, exitFightGroup)
	EnterActivityViewOnExitFightSceneHelper.enterVersionActivityDungeonCommon(EnterActivityViewOnExitFightSceneHelper._enterActivity130502, forceStarting, exitFightGroup)
end

function EnterActivityViewOnExitFightSceneHelper._enterActivity130502(cls, param)
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
	local mapLevelViewName = ViewName.VersionActivity2_9DungeonMapLevelView
	local mapViewName = ViewName.VersionActivity2_9DungeonMapView
	local enterViewName = ViewName.VersionActivity2_9EnterView

	if DungeonModel.instance.curSendEpisodePass then
		needLoadMapLevel = false

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, mapViewName)
	else
		needLoadMapLevel = true

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, mapLevelViewName)
	end

	local sequence = FlowSequence.New()

	sequence:addWork(OpenViewWork.New({
		openFunction = VersionActivity2_9EnterController.directOpenVersionActivityEnterView,
		openFunctionObj = VersionActivity2_9EnterController.instance,
		waitOpenViewName = enterViewName
	}))
	sequence:registerDoneListener(function()
		if needLoadMapLevel then
			VersionActivity2_9DungeonController.instance:openVersionActivityDungeonMapView(nil, episodeId, function()
				ViewMgr.instance:openView(mapLevelViewName, {
					episodeId = episodeId
				})
			end, nil)
		else
			VersionActivity2_9DungeonController.instance:openVersionActivityDungeonMapView(nil, episodeId)
		end
	end)
	sequence:start()

	EnterActivityViewOnExitFightSceneHelper.sequence = sequence
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity12302(forceStarting, exitFightGroup)
	EnterActivityViewOnExitFightSceneHelper.enterVersionActivityDungeonCommon(_enterActivity12302, forceStarting, exitFightGroup)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity130504(forceStarting, exitFightGroup)
	EnterActivityViewOnExitFightSceneHelper.enterVersionActivityDungeonCommon(EnterActivityViewOnExitFightSceneHelper._enterActivity130504, forceStarting, exitFightGroup)
end

function EnterActivityViewOnExitFightSceneHelper._enterActivity130504(cls, param)
	local episodeCo = param.episodeCo
	local isStealth = episodeCo.type == DungeonEnum.EpisodeType.Assassin2Stealth

	if EnterActivityViewOnExitFightSceneHelper.sequence then
		EnterActivityViewOnExitFightSceneHelper.sequence:destroy()

		EnterActivityViewOnExitFightSceneHelper.sequence = nil
	end

	local isOpen = AssassinOutsideModel.instance:isAct195Open(true)
	local viewParam = {}

	if isOpen then
		local waitViewName = ViewName.AssassinMapView

		if isStealth then
			viewParam.fightReturnStealthGame = true
			waitViewName = ViewName.AssassinStealthGameView
		else
			local questId = AssassinOutsideModel.instance:getEnterFightQuest()
			local mapId = AssassinConfig.instance:getQuestMapId(questId)

			if mapId then
				waitViewName = ViewName.AssassinQuestMapView
			end

			viewParam.questMapId = mapId
		end

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, waitViewName)
	end

	local enterViewName = ViewName.VersionActivity2_9EnterView
	local sequence = FlowSequence.New()

	sequence:addWork(OpenViewWork.New({
		openFunction = VersionActivity2_9EnterController.directOpenVersionActivityEnterView,
		openFunctionObj = VersionActivity2_9EnterController.instance,
		waitOpenViewName = enterViewName
	}))
	sequence:registerDoneListener(function()
		AssassinController.instance:openAssassinMapView(viewParam)
	end)
	sequence:start()

	EnterActivityViewOnExitFightSceneHelper.sequence = sequence
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity130505(forceStarting, exitFightGroup)
	local episodeId = DungeonModel.instance.curSendEpisodeId
	local stage, layer = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(episodeId)

	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.V1a4_BossRushMainView)
		VersionActivity2_9EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			BossRushController.instance:openMainView({
				isOpenLevelDetail = true,
				stage = stage,
				layer = layer
			})
		end, nil, BossRushConfig.instance:getActivityId(), true, true)
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity130507(forceStarting, exitFightGroup)
	EnterActivityViewOnExitFightSceneHelper.enterVersionActivityDungeonCommon(EnterActivityViewOnExitFightSceneHelper.enterActivityDungeonAterFight130507, forceStarting, exitFightGroup)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivityDungeonAterFight130507(tarClass, param)
	if EnterActivityViewOnExitFightSceneHelper.sequence then
		EnterActivityViewOnExitFightSceneHelper.sequence:destroy()

		EnterActivityViewOnExitFightSceneHelper.sequence = nil
	end

	GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.OdysseyDungeonView)

	local enterViewName = ViewName.VersionActivity2_9EnterView
	local sequence = FlowSequence.New()

	sequence:addWork(OpenViewWork.New({
		openFunction = VersionActivity2_9EnterController.directOpenVersionActivityEnterView,
		openFunctionObj = VersionActivity2_9EnterController.instance,
		waitOpenViewName = enterViewName
	}))
	sequence:registerDoneListener(function()
		OdysseyDungeonController.instance:openDungeonView()
	end)
	sequence:start()

	EnterActivityViewOnExitFightSceneHelper.sequence = sequence
end

return EnterActivityViewOnExitFightSceneHelper
