module("modules.logic.versionactivity2_2.common.EnterActivityViewOnExitFightSceneHelper2_2", package.seeall)

local var_0_0 = EnterActivityViewOnExitFightSceneHelper

function var_0_0.activate()
	return
end

function var_0_0.enterActivity12210(arg_2_0, arg_2_1)
	var_0_0.enterVersionActivityDungeonCommon(var_0_0._enterActivityDungeonAterFight12210, arg_2_0, arg_2_1)
end

function var_0_0.enterActivity12203(arg_3_0, arg_3_1)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(arg_3_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_2EnterView)
		VersionActivity2_2EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, VersionActivity2_2Enum.ActivityId.TianShiNaNa, true)
	end)
end

local function var_0_1()
	local var_5_0 = DungeonModel.instance.curSendEpisodeId

	if not var_5_0 then
		return
	end

	local var_5_1 = DungeonConfig.instance:getEpisodeCO(var_5_0)

	if not var_5_1 then
		return false
	end

	local var_5_2 = Season166Model.instance:getBattleContext()

	if not var_5_2 then
		return false
	end

	return true, var_5_0, var_5_1, var_5_2
end

function var_0_0._enterActivityDungeonAterFight12210(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1.episodeId
	local var_6_1 = arg_6_1.exitFightGroup

	if not var_6_0 then
		return
	end

	local var_6_2 = Season166Model.instance:getBattleContext()

	if not var_6_2 then
		return false
	end

	local var_6_3 = var_6_2.trainId
	local var_6_4 = var_6_2.baseId
	local var_6_5 = var_6_2.actId
	local var_6_6 = var_0_0.recordMO and var_0_0.recordMO.fightResult
	local var_6_7 = DungeonConfig.instance:getEpisodeCO(var_6_0)
	local var_6_8 = var_6_7 and var_6_7.type
	local var_6_9
	local var_6_10

	if var_6_7 then
		if not var_6_6 or var_6_6 == -1 or var_6_6 == 0 then
			if var_6_8 == DungeonEnum.EpisodeType.Season166Base then
				var_6_9 = Season166Enum.JumpId.BaseSpotEpisode
				var_6_10 = {
					baseId = var_6_4
				}
			elseif var_6_8 == DungeonEnum.EpisodeType.Season166Train then
				var_6_9 = Season166Enum.JumpId.TrainEpisode
				var_6_10 = {
					trainId = var_6_3
				}
			elseif var_6_8 == DungeonEnum.EpisodeType.Season166Teach then
				var_6_9 = Season166Enum.JumpId.TeachView
			end
		elseif var_6_6 == 1 then
			if var_6_8 == DungeonEnum.EpisodeType.Season166Base then
				var_6_9 = Season166Enum.JumpId.MainView
			elseif var_6_8 == DungeonEnum.EpisodeType.Season166Train then
				var_6_9 = Season166Enum.JumpId.TrainView
			elseif var_6_8 == DungeonEnum.EpisodeType.Season166Teach then
				var_6_9 = Season166Enum.JumpId.TeachView
			end
		end
	else
		logError(string.format("找不到对应关卡表,id:%s", var_6_0))
	end

	VersionActivity2_2EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		Season166Controller.instance:openSeasonView({
			actId = var_6_5,
			jumpId = var_6_9,
			jumpParam = var_6_10
		})
	end, nil, VersionActivity2_2Enum.ActivityId.Season)
end

function var_0_0.enterActivity12204(arg_8_0, arg_8_1)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(arg_8_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_2EnterView)

		local var_9_0

		if DungeonModel.instance.lastSendEpisodeId == Activity168Model.instance:getCurBattleEpisodeId() then
			function var_9_0()
				LoperaController.instance:openLoperaMainView()
			end
		end

		VersionActivity2_2EnterController.instance:openVersionActivityEnterViewIfNotOpened(var_9_0, nil, VersionActivity2_2Enum.ActivityId.Lopera)
	end)
end

function var_0_0.enterActivity12209(arg_11_0, arg_11_1)
	local var_11_0 = DungeonModel.instance.curSendEpisodeId
	local var_11_1, var_11_2 = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(var_11_0)

	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(arg_11_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.V1a4_BossRushMainView)
		VersionActivity2_2EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			BossRushController.instance:openMainView({
				isOpenLevelDetail = true,
				stage = var_11_1,
				layer = var_11_2
			})
		end, nil, BossRushConfig.instance:getActivityId())
	end)
end

return var_0_0
