module("modules.logic.versionactivity1_7.common.EnterActivityViewOnExitFightSceneHelper1_7", package.seeall)

local var_0_0 = EnterActivityViewOnExitFightSceneHelper

function var_0_0.enterActivity11700(arg_1_0, arg_1_1)
	var_0_0.enterVersionActivityDungeonCommon(var_0_0._enterActivityDungeonAterFight11700, arg_1_0, arg_1_1)
end

local function var_0_1()
	local var_2_0 = DungeonModel.instance.curSendEpisodeId

	if not var_2_0 then
		return
	end

	local var_2_1 = DungeonConfig.instance:getEpisodeCO(var_2_0)

	if not var_2_1 then
		return false
	end

	local var_2_2 = Season123Model.instance:getBattleContext()

	if not var_2_2 then
		logNormal("Season123 checkSeason123BattleDatas no context found!")

		return false
	end

	return true, var_2_0, var_2_1, var_2_2
end

function var_0_0._enterActivityDungeonAterFight11700(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1.episodeId
	local var_3_1 = arg_3_1.exitFightGroup

	if not var_3_0 then
		return
	end

	local var_3_2 = Season123Model.instance:getBattleContext()

	if not var_3_2 then
		logNormal("Season123 checkSeason123BattleDatas no context found!")

		return false
	end

	local var_3_3 = var_3_2.layer
	local var_3_4 = var_3_2.stage
	local var_3_5 = var_3_2.actId
	local var_3_6 = var_0_0.recordMO and var_0_0.recordMO.fightResult
	local var_3_7 = DungeonConfig.instance:getEpisodeCO(var_3_0)
	local var_3_8 = var_3_7 and var_3_7.type
	local var_3_9
	local var_3_10

	if var_3_7 then
		if not var_3_6 or var_3_6 == -1 or var_3_6 == 0 then
			if var_3_8 == DungeonEnum.EpisodeType.Season123 then
				var_3_9 = Activity123Enum.JumpId.MarketNoResult
				var_3_10 = {
					tarLayer = var_3_3
				}
			elseif var_3_8 == DungeonEnum.EpisodeType.Season123Retail then
				var_3_9 = Activity123Enum.JumpId.Retail
			end
		elseif var_3_6 == 1 and (not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonUTTU) or not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonDiscount)) then
			if var_3_8 == DungeonEnum.EpisodeType.Season123 then
				local var_3_11 = var_3_3 + 1

				if Season123Config.instance:getSeasonEpisodeCo(var_3_5, var_3_4, var_3_11) then
					var_3_9 = Activity123Enum.JumpId.Market
					var_3_10 = {
						tarLayer = var_3_11
					}
				else
					var_3_9 = Activity123Enum.JumpId.MarketStageFinish
					var_3_10 = {
						stage = var_3_4
					}
				end
			elseif var_3_8 == DungeonEnum.EpisodeType.Season123Retail then
				var_3_9 = Activity123Enum.JumpId.Retail
			end
		end
	else
		logError(string.format("找不到对应关卡表,id:%s", var_3_0))
	end

	VersionActivity1_7EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		Season123Controller.instance:openSeasonEntry({
			actId = var_3_5,
			jumpId = var_3_9,
			jumpParam = var_3_10
		})
	end, nil, VersionActivity1_7Enum.ActivityId.Season)
end

function var_0_0.checkFightAfterStory11700(arg_5_0, arg_5_1, arg_5_2)
	if (var_0_0.recordMO and var_0_0.recordMO.fightResult) ~= 1 then
		return
	end

	local var_5_0, var_5_1, var_5_2, var_5_3 = var_0_1()

	if not var_5_0 or var_5_2.type ~= DungeonEnum.EpisodeType.Season123 then
		return
	end

	local var_5_4 = var_5_3.layer
	local var_5_5 = var_5_3.actId
	local var_5_6 = var_5_3.stage

	if Season123Model.instance:isEpisodeAfterStory(var_5_5, var_5_6, var_5_4) then
		return
	end

	local var_5_7 = Season123Config.instance:getSeasonEpisodeCo(var_5_5, var_5_6, var_5_4)

	if not var_5_7 or var_5_7.afterStoryId == nil or var_5_7.afterStoryId == 0 then
		return
	end

	StoryController.instance:playStory(var_5_7.afterStoryId, nil, arg_5_0, arg_5_1, arg_5_2)

	return true
end

function var_0_0.enterFightAgain11700()
	local var_6_0, var_6_1, var_6_2, var_6_3 = var_0_1()

	if not var_6_0 or var_6_2.type == DungeonEnum.EpisodeType.Season123Retail then
		return false
	end

	local var_6_4 = var_6_3.layer
	local var_6_5 = var_6_3.stage
	local var_6_6 = var_6_3.actId

	if FightController.instance:isReplayMode(var_6_1) and not var_6_4 then
		if var_6_2.type == DungeonEnum.EpisodeType.Season123 then
			local var_6_7 = Season123Config.instance:getSeasonEpisodeStageCos(var_6_6, var_6_5)

			if not var_6_7 then
				return false
			end

			for iter_6_0, iter_6_1 in pairs(var_6_7) do
				if iter_6_1.episodeId == var_6_1 then
					var_6_4 = iter_6_1.layer

					break
				end
			end
		elseif var_6_2.type == DungeonEnum.EpisodeType.Season123Retail then
			var_6_4 = 0
		end
	end

	GameSceneMgr.instance:closeScene(nil, nil, nil, true)
	Season123EpisodeDetailController.instance:startBattle(var_6_6, var_6_5, var_6_4, var_6_1)

	return true
end

function var_0_0.enterActivity11706(arg_7_0, arg_7_1)
	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(arg_7_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		PermanentController.instance:jump2Activity(VersionActivity1_7Enum.ActivityId.EnterView)
		ActIsoldeController.instance:openLevelView({
			needShowFight = true
		})
	end)
end

function var_0_0.enterActivity11707(arg_9_0, arg_9_1)
	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(arg_9_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		PermanentController.instance:jump2Activity(VersionActivity1_7Enum.ActivityId.EnterView)
		ActMarcusController.instance:openLevelView({
			needShowFight = true
		})
	end)
end

function var_0_0.enterActivity11704(arg_11_0, arg_11_1)
	local var_11_0 = DungeonModel.instance.curSendEpisodeId
	local var_11_1, var_11_2 = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(var_11_0)

	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(arg_11_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.V1a4_BossRushMainView)
		VersionActivity1_7EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			BossRushController.instance:openMainView({
				isOpenLevelDetail = true,
				stage = var_11_1,
				layer = var_11_2
			})
		end, nil, BossRushConfig.instance:getActivityId())
	end)
end

function var_0_0.activate()
	return
end

return var_0_0
