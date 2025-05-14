module("modules.logic.versionactivity2_1.common.EnterActivityViewOnExitFightSceneHelper2_1", package.seeall)

local var_0_0 = EnterActivityViewOnExitFightSceneHelper

function var_0_0.enterActivity12113(arg_1_0, arg_1_1)
	local var_1_0 = DungeonModel.instance.curSendEpisodeId
	local var_1_1, var_1_2 = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(var_1_0)

	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(arg_1_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.V1a4_BossRushMainView)
		VersionActivity2_1EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			BossRushController.instance:openMainView({
				isOpenLevelDetail = true,
				stage = var_1_1,
				layer = var_1_2
			})
		end, nil, BossRushConfig.instance:getActivityId())
	end)
end

function var_0_0.enterActivity12105(arg_4_0, arg_4_1)
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(arg_4_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		VersionActivity2_1EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, VersionActivity2_1Enum.ActivityId.Aergusi, true)
	end)
end

function var_0_0.enterActivity12114(arg_6_0, arg_6_1)
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(arg_6_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		VersionActivity2_1EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, VersionActivity2_1Enum.ActivityId.LanShouPa, true)
	end)
end

function var_0_0.enterActivity12115(arg_8_0, arg_8_1)
	var_0_0.enterVersionActivityDungeonCommon(var_0_0._enterActivityDungeonAterFight12115, arg_8_0, arg_8_1)
end

local function var_0_1()
	local var_9_0 = DungeonModel.instance.curSendEpisodeId

	if not var_9_0 then
		return
	end

	local var_9_1 = DungeonConfig.instance:getEpisodeCO(var_9_0)

	if not var_9_1 then
		return false
	end

	local var_9_2 = Season123Model.instance:getBattleContext()

	if not var_9_2 then
		logNormal("Season123 checkSeason123BattleDatas no context found!")

		return false
	end

	return true, var_9_0, var_9_1, var_9_2
end

function var_0_0._enterActivityDungeonAterFight12115(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1.episodeId
	local var_10_1 = arg_10_1.exitFightGroup

	if not var_10_0 then
		return
	end

	local var_10_2 = Season123Model.instance:getBattleContext()

	if not var_10_2 then
		logNormal("Season123 checkSeason123BattleDatas no context found!")

		return false
	end

	local var_10_3 = var_10_2.layer
	local var_10_4 = var_10_2.stage
	local var_10_5 = var_10_2.actId
	local var_10_6 = var_0_0.recordMO and var_0_0.recordMO.fightResult
	local var_10_7 = DungeonConfig.instance:getEpisodeCO(var_10_0)
	local var_10_8 = var_10_7 and var_10_7.type
	local var_10_9
	local var_10_10

	if var_10_7 then
		if not var_10_6 or var_10_6 == -1 or var_10_6 == 0 then
			if var_10_8 == DungeonEnum.EpisodeType.Season123 then
				var_10_9 = Activity123Enum.JumpId.MarketNoResult
				var_10_10 = {
					tarLayer = var_10_3
				}
			elseif var_10_8 == DungeonEnum.EpisodeType.Season123Retail then
				var_10_9 = Activity123Enum.JumpId.Retail
			end
		elseif var_10_6 == 1 and (not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonUTTU) or not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonDiscount)) then
			if var_10_8 == DungeonEnum.EpisodeType.Season123 then
				local var_10_11 = var_10_3 + 1

				if Season123Config.instance:getSeasonEpisodeCo(var_10_5, var_10_4, var_10_11) then
					var_10_9 = Activity123Enum.JumpId.Market
					var_10_10 = {
						tarLayer = var_10_11
					}
				else
					var_10_9 = Activity123Enum.JumpId.MarketStageFinish
					var_10_10 = {
						stage = var_10_4
					}
				end
			elseif var_10_8 == DungeonEnum.EpisodeType.Season123Retail then
				var_10_9 = Activity123Enum.JumpId.Retail
				var_10_10 = {
					needRandom = true
				}
			end
		end
	else
		logError(string.format("找不到对应关卡表,id:%s", var_10_0))
	end

	VersionActivity2_1EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		Season123Controller.instance:openSeasonEntry({
			actId = var_10_5,
			jumpId = var_10_9,
			jumpParam = var_10_10
		})
	end, nil, VersionActivity2_1Enum.ActivityId.Season)
end

function var_0_0.checkFightAfterStory12115(arg_12_0, arg_12_1, arg_12_2)
	if (var_0_0.recordMO and var_0_0.recordMO.fightResult) ~= 1 then
		return
	end

	local var_12_0, var_12_1, var_12_2, var_12_3 = var_0_1()

	if not var_12_0 or var_12_2.type ~= DungeonEnum.EpisodeType.Season123 then
		return
	end

	local var_12_4 = var_12_3.layer
	local var_12_5 = var_12_3.actId
	local var_12_6 = var_12_3.stage

	if Season123Model.instance:isEpisodeAfterStory(var_12_5, var_12_6, var_12_4) then
		return
	end

	local var_12_7 = Season123Config.instance:getSeasonEpisodeCo(var_12_5, var_12_6, var_12_4)

	if not var_12_7 or var_12_7.afterStoryId == nil or var_12_7.afterStoryId == 0 then
		return
	end

	StoryController.instance:playStory(var_12_7.afterStoryId, nil, arg_12_0, arg_12_1, arg_12_2)

	return true
end

function var_0_0.enterFightAgain12115()
	local var_13_0, var_13_1, var_13_2, var_13_3 = var_0_1()

	if not var_13_0 or var_13_2.type == DungeonEnum.EpisodeType.Season123Retail then
		return false
	end

	local var_13_4 = var_13_3.layer
	local var_13_5 = var_13_3.stage
	local var_13_6 = var_13_3.actId

	if FightController.instance:isReplayMode(var_13_1) and not var_13_4 then
		if var_13_2.type == DungeonEnum.EpisodeType.Season123 then
			local var_13_7 = Season123Config.instance:getSeasonEpisodeStageCos(var_13_6, var_13_5)

			if not var_13_7 then
				return false
			end

			for iter_13_0, iter_13_1 in pairs(var_13_7) do
				if iter_13_1.episodeId == var_13_1 then
					var_13_4 = iter_13_1.layer

					break
				end
			end
		elseif var_13_2.type == DungeonEnum.EpisodeType.Season123Retail then
			var_13_4 = 0
		end
	end

	GameSceneMgr.instance:closeScene(nil, nil, nil, true)
	Season123EpisodeDetailController.instance:startBattle(var_13_6, var_13_5, var_13_4, var_13_1)

	return true
end

function var_0_0.enterActivity12102(arg_14_0, arg_14_1)
	var_0_0.enterVersionActivityDungeonCommon(var_0_0._enterActivity12102, arg_14_0, arg_14_1)
end

function var_0_0._enterActivity12102(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1.episodeId
	local var_15_1 = arg_15_1.episodeCo

	if not var_15_1 then
		return
	end

	if var_0_0.sequence then
		var_0_0.sequence:destroy()

		var_0_0.sequence = nil
	end

	local var_15_2 = false

	if var_15_1.chapterId == VersionActivity2_1DungeonEnum.DungeonChapterId.ElementFight then
		DungeonMapModel.instance.lastElementBattleId = var_15_0
		var_15_0 = VersionActivity2_1DungeonModel.instance:getLastEpisodeId()

		if var_15_0 then
			VersionActivity2_1DungeonModel.instance:setLastEpisodeId(nil)
		else
			var_15_0 = DungeonConfig.instance:getActivityElementFightEpisodeToNormalEpisodeId(var_15_1, VersionActivity2_1DungeonEnum.DungeonChapterId.Story)
		end

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_1DungeonMapView)
	elseif DungeonModel.instance.curSendEpisodePass then
		var_15_2 = false

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_1DungeonMapView)
	else
		var_15_2 = true

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_1DungeonMapLevelView)
	end

	local var_15_3 = FlowSequence.New()

	var_15_3:addWork(OpenViewWork.New({
		openFunction = VersionActivity2_1EnterController.directOpenVersionActivityEnterView,
		openFunctionObj = VersionActivity2_1EnterController.instance,
		waitOpenViewName = ViewName.VersionActivity2_1EnterView
	}))
	var_15_3:registerDoneListener(function()
		if var_15_2 then
			VersionActivity2_1DungeonController.instance:openVersionActivityDungeonMapView(nil, var_15_0, function()
				ViewMgr.instance:openView(ViewName.VersionActivity2_1DungeonMapLevelView, {
					episodeId = var_15_0
				})
			end, nil)
		else
			VersionActivity2_1DungeonController.instance:openVersionActivityDungeonMapView(nil, var_15_0)
		end
	end)
	var_15_3:start()

	var_0_0.sequence = var_15_3
end

return var_0_0
