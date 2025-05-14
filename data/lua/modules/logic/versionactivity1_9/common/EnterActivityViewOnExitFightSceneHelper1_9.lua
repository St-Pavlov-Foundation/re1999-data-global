module("modules.logic.versionactivity1_9.common.EnterActivityViewOnExitFightSceneHelper1_9", package.seeall)

local var_0_0 = EnterActivityViewOnExitFightSceneHelper

function var_0_0.activate()
	return
end

function var_0_0.enterActivity11906(arg_2_0, arg_2_1)
	var_0_0.enterVersionActivityDungeonCommon(var_0_0._enterActivityDungeonAterFight11906, arg_2_0, arg_2_1)
end

local function var_0_1()
	local var_3_0 = DungeonModel.instance.curSendEpisodeId

	if not var_3_0 then
		return
	end

	local var_3_1 = DungeonConfig.instance:getEpisodeCO(var_3_0)

	if not var_3_1 then
		return false
	end

	local var_3_2 = Season123Model.instance:getBattleContext()

	if not var_3_2 then
		logNormal("Season123 checkSeason123BattleDatas no context found!")

		return false
	end

	return true, var_3_0, var_3_1, var_3_2
end

function var_0_0._enterActivityDungeonAterFight11906(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1.episodeId
	local var_4_1 = arg_4_1.exitFightGroup

	if not var_4_0 then
		return
	end

	local var_4_2 = Season123Model.instance:getBattleContext()

	if not var_4_2 then
		logNormal("Season123 checkSeason123BattleDatas no context found!")

		return false
	end

	local var_4_3 = var_4_2.layer
	local var_4_4 = var_4_2.stage
	local var_4_5 = var_4_2.actId
	local var_4_6 = var_0_0.recordMO and var_0_0.recordMO.fightResult
	local var_4_7 = DungeonConfig.instance:getEpisodeCO(var_4_0)
	local var_4_8 = var_4_7 and var_4_7.type
	local var_4_9
	local var_4_10

	if var_4_7 then
		if not var_4_6 or var_4_6 == -1 or var_4_6 == 0 then
			if var_4_8 == DungeonEnum.EpisodeType.Season123 then
				var_4_9 = Activity123Enum.JumpId.MarketNoResult
				var_4_10 = {
					tarLayer = var_4_3
				}
			elseif var_4_8 == DungeonEnum.EpisodeType.Season123Retail then
				var_4_9 = Activity123Enum.JumpId.Retail
			end
		elseif var_4_6 == 1 and (not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonUTTU) or not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonDiscount)) then
			if var_4_8 == DungeonEnum.EpisodeType.Season123 then
				local var_4_11 = var_4_3 + 1

				if Season123Config.instance:getSeasonEpisodeCo(var_4_5, var_4_4, var_4_11) then
					var_4_9 = Activity123Enum.JumpId.Market
					var_4_10 = {
						tarLayer = var_4_11
					}
				else
					var_4_9 = Activity123Enum.JumpId.MarketStageFinish
					var_4_10 = {
						stage = var_4_4
					}
				end
			elseif var_4_8 == DungeonEnum.EpisodeType.Season123Retail then
				var_4_9 = Activity123Enum.JumpId.Retail
				var_4_10 = {
					needRandom = true
				}
			end
		end
	else
		logError(string.format("找不到对应关卡表,id:%s", var_4_0))
	end

	VersionActivity1_9EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		Season123Controller.instance:openSeasonEntry({
			actId = var_4_5,
			jumpId = var_4_9,
			jumpParam = var_4_10
		})
	end, nil, VersionActivity1_9Enum.ActivityId.Season)
end

function var_0_0.checkFightAfterStory11906(arg_6_0, arg_6_1, arg_6_2)
	if (var_0_0.recordMO and var_0_0.recordMO.fightResult) ~= 1 then
		return
	end

	local var_6_0, var_6_1, var_6_2, var_6_3 = var_0_1()

	if not var_6_0 or var_6_2.type ~= DungeonEnum.EpisodeType.Season123 then
		return
	end

	local var_6_4 = var_6_3.layer
	local var_6_5 = var_6_3.actId
	local var_6_6 = var_6_3.stage

	if Season123Model.instance:isEpisodeAfterStory(var_6_5, var_6_6, var_6_4) then
		return
	end

	local var_6_7 = Season123Config.instance:getSeasonEpisodeCo(var_6_5, var_6_6, var_6_4)

	if not var_6_7 or var_6_7.afterStoryId == nil or var_6_7.afterStoryId == 0 then
		return
	end

	StoryController.instance:playStory(var_6_7.afterStoryId, nil, arg_6_0, arg_6_1, arg_6_2)

	return true
end

function var_0_0.enterFightAgain11906()
	local var_7_0, var_7_1, var_7_2, var_7_3 = var_0_1()

	if not var_7_0 or var_7_2.type == DungeonEnum.EpisodeType.Season123Retail then
		return false
	end

	local var_7_4 = var_7_3.layer
	local var_7_5 = var_7_3.stage
	local var_7_6 = var_7_3.actId

	if FightController.instance:isReplayMode(var_7_1) and not var_7_4 then
		if var_7_2.type == DungeonEnum.EpisodeType.Season123 then
			local var_7_7 = Season123Config.instance:getSeasonEpisodeStageCos(var_7_6, var_7_5)

			if not var_7_7 then
				return false
			end

			for iter_7_0, iter_7_1 in pairs(var_7_7) do
				if iter_7_1.episodeId == var_7_1 then
					var_7_4 = iter_7_1.layer

					break
				end
			end
		elseif var_7_2.type == DungeonEnum.EpisodeType.Season123Retail then
			var_7_4 = 0
		end
	end

	GameSceneMgr.instance:closeScene(nil, nil, nil, true)
	Season123EpisodeDetailController.instance:startBattle(var_7_6, var_7_5, var_7_4, var_7_1)

	return true
end

function var_0_0.enterActivity11908(arg_8_0, arg_8_1)
	DungeonModel.instance:resetSendChapterEpisodeId()

	local var_8_0 = VersionActivity1_9Enum.ActivityId.Lucy

	MainController.instance:enterMainScene(arg_8_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_9EnterView)
		VersionActivity1_9EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			RoleActivityController.instance:openLevelView({
				needShowFight = true,
				actId = var_8_0
			})
		end, nil, var_8_0)
	end)
end

function var_0_0.enterActivity11909(arg_11_0, arg_11_1)
	DungeonModel.instance:resetSendChapterEpisodeId()

	local var_11_0 = VersionActivity1_9Enum.ActivityId.KaKaNia

	MainController.instance:enterMainScene(arg_11_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_9EnterView)
		VersionActivity1_9EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			RoleActivityController.instance:openLevelView({
				needShowFight = true,
				actId = var_11_0
			})
		end, nil, var_11_0)
	end)
end

function var_0_0.enterActivity11910(arg_14_0, arg_14_1)
	local var_14_0 = DungeonModel.instance.curSendEpisodeId
	local var_14_1, var_14_2 = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(var_14_0)

	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(arg_14_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.V1a4_BossRushMainView)
		VersionActivity1_9EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			BossRushController.instance:openMainView({
				isOpenLevelDetail = true,
				stage = var_14_1,
				layer = var_14_2
			})
		end, nil, BossRushConfig.instance:getActivityId())
	end)
end

return var_0_0
