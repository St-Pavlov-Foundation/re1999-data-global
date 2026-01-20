-- chunkname: @modules/logic/versionactivity2_3/common/EnterActivityViewOnExitFightSceneHelper2_3.lua

module("modules.logic.versionactivity2_3.common.EnterActivityViewOnExitFightSceneHelper2_3", package.seeall)

local EnterActivityViewOnExitFightSceneHelper = EnterActivityViewOnExitFightSceneHelper

function EnterActivityViewOnExitFightSceneHelper.activate()
	return
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity12313(forceStarting, exitFightGroup)
	local episodeId = DungeonModel.instance.curSendEpisodeId
	local stage, layer = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(episodeId)

	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.V1a4_BossRushMainView)
		VersionActivity2_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			BossRushController.instance:openMainView({
				isOpenLevelDetail = true,
				stage = stage,
				layer = layer
			})
		end, nil, BossRushConfig.instance:getActivityId())
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity12305(forceStarting, exitFightGroup)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_3EnterView)

		local actCo = ActivityConfig.instance:getActivityCo(VersionActivity2_3Enum.ActivityId.DuDuGu)

		if DungeonModel.instance.lastSendEpisodeId == actCo.tryoutEpisode then
			VersionActivity2_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, VersionActivity2_3Enum.ActivityId.DuDuGu)
		else
			local function returnViewAction()
				RoleActivityController.instance:enterActivity(VersionActivity2_3Enum.ActivityId.DuDuGu)
			end

			VersionActivity2_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(returnViewAction, nil, VersionActivity2_3Enum.ActivityId.DuDuGu)
		end
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity12306(forceStarting, exitFightGroup)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_3EnterView)

		local actCo = ActivityConfig.instance:getActivityCo(VersionActivity2_3Enum.ActivityId.ZhiXinQuanEr)

		if DungeonModel.instance.lastSendEpisodeId == actCo.tryoutEpisode then
			VersionActivity2_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, VersionActivity2_3Enum.ActivityId.ZhiXinQuanEr)
		else
			local function returnViewAction()
				RoleActivityController.instance:enterActivity(VersionActivity2_3Enum.ActivityId.ZhiXinQuanEr)
			end

			VersionActivity2_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(returnViewAction, nil, VersionActivity2_3Enum.ActivityId.ZhiXinQuanEr)
		end
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity12302(forceStarting, exitFightGroup)
	EnterActivityViewOnExitFightSceneHelper.enterVersionActivityDungeonCommon(EnterActivityViewOnExitFightSceneHelper._enterActivity12302, forceStarting, exitFightGroup)
end

function EnterActivityViewOnExitFightSceneHelper._enterActivity12302(cls, param)
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
		openFunction = VersionActivity2_3EnterController.directOpenVersionActivityEnterView,
		openFunctionObj = VersionActivity2_3EnterController.instance,
		waitOpenViewName = ViewName.VersionActivity2_3EnterView
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

function EnterActivityViewOnExitFightSceneHelper.enterActivity12304(forceStarting, exitFightGroup)
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_3EnterView)

		local function returnViewAction()
			Activity174Controller.instance:openMainView({
				exitFromFight = true,
				actId = VersionActivity2_3Enum.ActivityId.Act174
			})
		end

		VersionActivity2_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(returnViewAction, nil, VersionActivity2_3Enum.ActivityId.Act174)
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity12315(forceStarting, exitFightGroup)
	EnterActivityViewOnExitFightSceneHelper.enterVersionActivityDungeonCommon(EnterActivityViewOnExitFightSceneHelper._enterActivityDungeonAterFight12315, forceStarting, exitFightGroup)
end

local function checkSeason123BattleDatas()
	local episodeId = DungeonModel.instance.curSendEpisodeId

	if not episodeId then
		return
	end

	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not episodeCo then
		return false
	end

	local context = Season123Model.instance:getBattleContext()

	if not context then
		logNormal("Season123 checkSeason123BattleDatas no context found!")

		return false
	end

	return true, episodeId, episodeCo, context
end

function EnterActivityViewOnExitFightSceneHelper._enterActivityDungeonAterFight12315(tarClass, param)
	local episodeId = param.episodeId
	local exitFightGroup = param.exitFightGroup

	if not episodeId then
		return
	end

	local context = Season123Model.instance:getBattleContext()

	if not context then
		logNormal("Season123 checkSeason123BattleDatas no context found!")

		return false
	end

	local layer = context.layer
	local stage = context.stage
	local actId = context.actId
	local fightResult = EnterActivityViewOnExitFightSceneHelper.recordMO and EnterActivityViewOnExitFightSceneHelper.recordMO.fightResult
	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)
	local episodeType = episodeCo and episodeCo.type
	local jumpId, jumpParam

	if episodeCo then
		if not fightResult or fightResult == -1 or fightResult == 0 then
			if episodeType == DungeonEnum.EpisodeType.Season123 then
				jumpId = Activity123Enum.JumpId.MarketNoResult
				jumpParam = {
					tarLayer = layer
				}
			elseif episodeType == DungeonEnum.EpisodeType.Season123Retail then
				jumpId = Activity123Enum.JumpId.Retail
			end
		elseif fightResult == 1 and (not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonUTTU) or not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonDiscount)) then
			if episodeType == DungeonEnum.EpisodeType.Season123 then
				local curLayer = layer + 1
				local next_config = Season123Config.instance:getSeasonEpisodeCo(actId, stage, curLayer)

				if next_config then
					jumpId = Activity123Enum.JumpId.Market
					jumpParam = {
						tarLayer = curLayer
					}
				else
					jumpId = Activity123Enum.JumpId.MarketStageFinish
					jumpParam = {
						stage = stage
					}
				end
			elseif episodeType == DungeonEnum.EpisodeType.Season123Retail then
				jumpId = Activity123Enum.JumpId.Retail
				jumpParam = {
					needRandom = true
				}
			end
		end
	else
		logError(string.format("找不到对应关卡表,id:%s", episodeId))
	end

	VersionActivity2_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		Season123Controller.instance:openSeasonEntry({
			actId = actId,
			jumpId = jumpId,
			jumpParam = jumpParam
		})
	end, nil, VersionActivity2_3Enum.ActivityId.Season)
end

function EnterActivityViewOnExitFightSceneHelper.checkFightAfterStory12315(callback, target, param)
	local fightResult = EnterActivityViewOnExitFightSceneHelper.recordMO and EnterActivityViewOnExitFightSceneHelper.recordMO.fightResult

	if fightResult ~= 1 then
		return
	end

	local rs, episodeId, episodeCo, context = checkSeason123BattleDatas()

	if not rs or episodeCo.type ~= DungeonEnum.EpisodeType.Season123 then
		return
	end

	local layer = context.layer
	local actId = context.actId
	local stage = context.stage

	if Season123Model.instance:isEpisodeAfterStory(actId, stage, layer) then
		return
	end

	local layerCo = Season123Config.instance:getSeasonEpisodeCo(actId, stage, layer)

	if not layerCo or layerCo.afterStoryId == nil or layerCo.afterStoryId == 0 then
		return
	end

	StoryController.instance:playStory(layerCo.afterStoryId, nil, callback, target, param)

	return true
end

function EnterActivityViewOnExitFightSceneHelper.enterFightAgain12315()
	local rs, episodeId, episodeCo, context = checkSeason123BattleDatas()

	if not rs or episodeCo.type == DungeonEnum.EpisodeType.Season123Retail then
		return false
	end

	local layer = context.layer
	local stage = context.stage
	local actId = context.actId
	local isReplay = FightController.instance:isReplayMode(episodeId)

	if isReplay and not layer then
		if episodeCo.type == DungeonEnum.EpisodeType.Season123 then
			local coList = Season123Config.instance:getSeasonEpisodeStageCos(actId, stage)

			if not coList then
				return false
			end

			for _, v in pairs(coList) do
				if v.episodeId == episodeId then
					layer = v.layer

					break
				end
			end
		elseif episodeCo.type == DungeonEnum.EpisodeType.Season123Retail then
			layer = 0
		end
	end

	GameSceneMgr.instance:closeScene(nil, nil, nil, true)
	Season123EpisodeDetailController.instance:startBattle(actId, stage, layer, episodeId)

	return true
end

return EnterActivityViewOnExitFightSceneHelper
