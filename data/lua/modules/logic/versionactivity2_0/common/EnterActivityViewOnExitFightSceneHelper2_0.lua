﻿module("modules.logic.versionactivity2_0.common.EnterActivityViewOnExitFightSceneHelper2_0", package.seeall)

local var_0_0 = EnterActivityViewOnExitFightSceneHelper

function var_0_0.enterActivity12003(arg_1_0, arg_1_1)
	var_0_0.enterVersionActivityDungeonCommon(var_0_0._enterActivity12003, arg_1_0, arg_1_1)
end

function var_0_0._enterActivity12003(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.episodeId
	local var_2_1 = arg_2_1.episodeCo

	if var_0_0.sequence then
		var_0_0.sequence:destroy()

		var_0_0.sequence = nil
	end

	local var_2_2 = false

	if var_2_1.chapterId == VersionActivity2_0DungeonEnum.DungeonChapterId.ElementFight then
		DungeonMapModel.instance.lastElementBattleId = var_2_0
		var_2_0 = VersionActivity2_0DungeonModel.instance:getLastEpisodeId()

		if var_2_0 then
			VersionActivity2_0DungeonModel.instance:setLastEpisodeId(nil)
		else
			var_2_0 = DungeonConfig.instance:getActivityElementFightEpisodeToNormalEpisodeId(var_2_1, VersionActivity2_0DungeonEnum.DungeonChapterId.Story)
		end

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_0DungeonMapView)
	elseif DungeonModel.instance.curSendEpisodePass then
		var_2_2 = false

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_0DungeonMapView)
	else
		var_2_2 = true

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_0DungeonMapLevelView)
	end

	local var_2_3 = FlowSequence.New()

	var_2_3:addWork(OpenViewWork.New({
		openFunction = VersionActivity2_0EnterController.directOpenVersionActivityEnterView,
		openFunctionObj = VersionActivity2_0EnterController.instance,
		waitOpenViewName = ViewName.VersionActivity2_0EnterView
	}))
	var_2_3:registerDoneListener(function()
		if var_2_2 then
			VersionActivity2_0DungeonController.instance:openVersionActivityDungeonMapView(nil, var_2_0, function()
				ViewMgr.instance:openView(ViewName.VersionActivity2_0DungeonMapLevelView, {
					episodeId = var_2_0
				})
			end, nil)
		else
			VersionActivity2_0DungeonController.instance:openVersionActivityDungeonMapView(nil, var_2_0)
		end
	end)
	var_2_3:start()

	var_0_0.sequence = var_2_3
end

function var_0_0.enterActivity12009(arg_5_0, arg_5_1)
	DungeonModel.instance:resetSendChapterEpisodeId()

	local var_5_0 = VersionActivity2_0Enum.ActivityId.Mercuria

	MainController.instance:enterMainScene(arg_5_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_0EnterView)
		VersionActivity2_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			RoleActivityController.instance:openLevelView({
				needShowFight = true,
				actId = var_5_0
			})
		end, nil, var_5_0)
	end)
end

function var_0_0.enterActivity12008(arg_8_0, arg_8_1)
	DungeonModel.instance:resetSendChapterEpisodeId()

	local var_8_0 = VersionActivity2_0Enum.ActivityId.Joe

	MainController.instance:enterMainScene(arg_8_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_0EnterView)
		VersionActivity2_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			RoleActivityController.instance:openLevelView({
				needShowFight = true,
				actId = var_8_0
			})
		end, nil, var_8_0)
	end)
end

function var_0_0.activate()
	return
end

function var_0_0.enterActivity12013(arg_12_0, arg_12_1)
	local var_12_0 = DungeonModel.instance.curSendEpisodeId
	local var_12_1, var_12_2 = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(var_12_0)

	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(arg_12_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.V1a4_BossRushMainView)
		VersionActivity2_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			BossRushController.instance:openMainView({
				isOpenLevelDetail = true,
				stage = var_12_1,
				layer = var_12_2
			})
		end, nil, BossRushConfig.instance:getActivityId())
	end)
end

function var_0_0.enterActivity12006(arg_15_0, arg_15_1)
	var_0_0.enterVersionActivityDungeonCommon(var_0_0._enterActivityDungeonAterFight12006, arg_15_0, arg_15_1)
end

local function var_0_1()
	local var_16_0 = DungeonModel.instance.curSendEpisodeId

	if not var_16_0 then
		return
	end

	local var_16_1 = DungeonConfig.instance:getEpisodeCO(var_16_0)

	if not var_16_1 then
		return false
	end

	local var_16_2 = Season123Model.instance:getBattleContext()

	if not var_16_2 then
		logNormal("Season123 checkSeason123BattleDatas no context found!")

		return false
	end

	return true, var_16_0, var_16_1, var_16_2
end

function var_0_0._enterActivityDungeonAterFight12006(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1.episodeId
	local var_17_1 = arg_17_1.exitFightGroup

	if not var_17_0 then
		return
	end

	local var_17_2 = Season123Model.instance:getBattleContext()

	if not var_17_2 then
		logNormal("Season123 checkSeason123BattleDatas no context found!")

		return false
	end

	local var_17_3 = var_17_2.layer
	local var_17_4 = var_17_2.stage
	local var_17_5 = var_17_2.actId
	local var_17_6 = var_0_0.recordMO and var_0_0.recordMO.fightResult
	local var_17_7 = DungeonConfig.instance:getEpisodeCO(var_17_0)
	local var_17_8 = var_17_7 and var_17_7.type
	local var_17_9
	local var_17_10

	if var_17_7 then
		if not var_17_6 or var_17_6 == -1 or var_17_6 == 0 then
			if var_17_8 == DungeonEnum.EpisodeType.Season123 then
				var_17_9 = Activity123Enum.JumpId.MarketNoResult
				var_17_10 = {
					tarLayer = var_17_3
				}
			elseif var_17_8 == DungeonEnum.EpisodeType.Season123Retail then
				var_17_9 = Activity123Enum.JumpId.Retail
			end
		elseif var_17_6 == 1 and (not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonUTTU) or not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonDiscount)) then
			if var_17_8 == DungeonEnum.EpisodeType.Season123 then
				local var_17_11 = var_17_3 + 1

				if Season123Config.instance:getSeasonEpisodeCo(var_17_5, var_17_4, var_17_11) then
					var_17_9 = Activity123Enum.JumpId.Market
					var_17_10 = {
						tarLayer = var_17_11
					}
				else
					var_17_9 = Activity123Enum.JumpId.MarketStageFinish
					var_17_10 = {
						stage = var_17_4
					}
				end
			elseif var_17_8 == DungeonEnum.EpisodeType.Season123Retail then
				var_17_9 = Activity123Enum.JumpId.Retail
				var_17_10 = {
					needRandom = true
				}
			end
		end
	else
		logError(string.format("找不到对应关卡表,id:%s", var_17_0))
	end

	VersionActivity2_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		Season123Controller.instance:openSeasonEntry({
			actId = var_17_5,
			jumpId = var_17_9,
			jumpParam = var_17_10
		})
	end, nil, VersionActivity2_0Enum.ActivityId.Season)
end

function var_0_0.checkFightAfterStory12006(arg_19_0, arg_19_1, arg_19_2)
	if (var_0_0.recordMO and var_0_0.recordMO.fightResult) ~= 1 then
		return
	end

	local var_19_0, var_19_1, var_19_2, var_19_3 = var_0_1()

	if not var_19_0 or var_19_2.type ~= DungeonEnum.EpisodeType.Season123 then
		return
	end

	local var_19_4 = var_19_3.layer
	local var_19_5 = var_19_3.actId
	local var_19_6 = var_19_3.stage

	if Season123Model.instance:isEpisodeAfterStory(var_19_5, var_19_6, var_19_4) then
		return
	end

	local var_19_7 = Season123Config.instance:getSeasonEpisodeCo(var_19_5, var_19_6, var_19_4)

	if not var_19_7 or var_19_7.afterStoryId == nil or var_19_7.afterStoryId == 0 then
		return
	end

	StoryController.instance:playStory(var_19_7.afterStoryId, nil, arg_19_0, arg_19_1, arg_19_2)

	return true
end

function var_0_0.enterFightAgain12006()
	local var_20_0, var_20_1, var_20_2, var_20_3 = var_0_1()

	if not var_20_0 or var_20_2.type == DungeonEnum.EpisodeType.Season123Retail then
		return false
	end

	local var_20_4 = var_20_3.layer
	local var_20_5 = var_20_3.stage
	local var_20_6 = var_20_3.actId

	if FightController.instance:isReplayMode(var_20_1) and not var_20_4 then
		if var_20_2.type == DungeonEnum.EpisodeType.Season123 then
			local var_20_7 = Season123Config.instance:getSeasonEpisodeStageCos(var_20_6, var_20_5)

			if not var_20_7 then
				return false
			end

			for iter_20_0, iter_20_1 in pairs(var_20_7) do
				if iter_20_1.episodeId == var_20_1 then
					var_20_4 = iter_20_1.layer

					break
				end
			end
		elseif var_20_2.type == DungeonEnum.EpisodeType.Season123Retail then
			var_20_4 = 0
		end
	end

	GameSceneMgr.instance:closeScene(nil, nil, nil, true)
	Season123EpisodeDetailController.instance:startBattle(var_20_6, var_20_5, var_20_4, var_20_1)

	return true
end

return var_0_0
