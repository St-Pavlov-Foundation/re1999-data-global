module("modules.logic.versionactivity2_6.common.EnterActivityViewOnExitFightSceneHelper2_6", package.seeall)

local var_0_0 = EnterActivityViewOnExitFightSceneHelper

function var_0_0.activate()
	return
end

function var_0_0.enterActivity12210(arg_2_0, arg_2_1)
	var_0_0.enterVersionActivityDungeonCommon(var_0_0._enterActivityDungeonAterFight12210, arg_2_0, arg_2_1)
end

function var_0_0.enterActivity12606(arg_3_0, arg_3_1)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(arg_3_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_6EnterView)
		VersionActivity2_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, VersionActivity2_6Enum.ActivityId.DiceHero, true)
	end)
end

function var_0_0.enterActivity12605(arg_5_0, arg_5_1)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(arg_5_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_6EnterView)
		VersionActivity2_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, VersionActivity2_6Enum.ActivityId.Xugouji, true)
	end)
end

function var_0_0.enterActivity12617(arg_7_0, arg_7_1)
	local var_7_0 = DungeonModel.instance.curSendEpisodeId
	local var_7_1, var_7_2 = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(var_7_0)

	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(arg_7_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.V1a4_BossRushMainView)
		VersionActivity2_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			BossRushController.instance:openMainView({
				isOpenLevelDetail = true,
				stage = var_7_1,
				layer = var_7_2
			})
		end, nil, BossRushConfig.instance:getActivityId())
	end)
end

function var_0_0.enterActivity12618(arg_10_0, arg_10_1)
	var_0_0.enterVersionActivityDungeonCommon(var_0_0._enterActivityDungeonAterFight12618, arg_10_0, arg_10_1)
end

function var_0_0._enterActivityDungeonAterFight12618(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1.episodeId
	local var_11_1 = arg_11_1.exitFightGroup

	if not var_11_0 then
		return
	end

	local var_11_2 = Season166Model.instance:getBattleContext()

	if not var_11_2 then
		return false
	end

	local var_11_3 = var_11_2.trainId
	local var_11_4 = var_11_2.baseId
	local var_11_5 = var_11_2.actId
	local var_11_6 = var_0_0.recordMO and var_0_0.recordMO.fightResult
	local var_11_7 = DungeonConfig.instance:getEpisodeCO(var_11_0)
	local var_11_8 = var_11_7 and var_11_7.type
	local var_11_9
	local var_11_10

	if var_11_7 then
		if not var_11_6 or var_11_6 == -1 or var_11_6 == 0 then
			if var_11_8 == DungeonEnum.EpisodeType.Season166Base then
				var_11_9 = Season166Enum.JumpId.BaseSpotEpisode
				var_11_10 = {
					baseId = var_11_4
				}
			elseif var_11_8 == DungeonEnum.EpisodeType.Season166Train then
				var_11_9 = Season166Enum.JumpId.TrainEpisode
				var_11_10 = {
					trainId = var_11_3
				}
			elseif var_11_8 == DungeonEnum.EpisodeType.Season166Teach then
				var_11_9 = Season166Enum.JumpId.TeachView
			end
		elseif var_11_6 == 1 then
			if var_11_8 == DungeonEnum.EpisodeType.Season166Base then
				var_11_9 = Season166Enum.JumpId.MainView
			elseif var_11_8 == DungeonEnum.EpisodeType.Season166Train then
				var_11_9 = Season166Enum.JumpId.TrainView
			elseif var_11_8 == DungeonEnum.EpisodeType.Season166Teach then
				var_11_9 = Season166Enum.JumpId.TeachView
			end
		end
	else
		logError(string.format("找不到对应关卡表,id:%s", var_11_0))
	end

	VersionActivity2_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		Season166Controller.instance:openSeasonView({
			actId = var_11_5,
			jumpId = var_11_9,
			jumpParam = var_11_10
		})
	end, nil, VersionActivity2_6Enum.ActivityId.Season)
end

return var_0_0
