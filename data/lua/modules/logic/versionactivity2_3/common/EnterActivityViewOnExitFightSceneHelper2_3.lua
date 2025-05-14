module("modules.logic.versionactivity2_3.common.EnterActivityViewOnExitFightSceneHelper2_3", package.seeall)

local var_0_0 = EnterActivityViewOnExitFightSceneHelper

function var_0_0.activate()
	return
end

function var_0_0.enterActivity12313(arg_2_0, arg_2_1)
	local var_2_0 = DungeonModel.instance.curSendEpisodeId
	local var_2_1, var_2_2 = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(var_2_0)

	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(arg_2_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.V1a4_BossRushMainView)
		VersionActivity2_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			BossRushController.instance:openMainView({
				isOpenLevelDetail = true,
				stage = var_2_1,
				layer = var_2_2
			})
		end, nil, BossRushConfig.instance:getActivityId())
	end)
end

function var_0_0.enterActivity12305(arg_5_0, arg_5_1)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(arg_5_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_3EnterView)

		local var_6_0 = ActivityConfig.instance:getActivityCo(VersionActivity2_3Enum.ActivityId.DuDuGu)

		if DungeonModel.instance.lastSendEpisodeId == var_6_0.tryoutEpisode then
			VersionActivity2_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, VersionActivity2_3Enum.ActivityId.DuDuGu)
		else
			local function var_6_1()
				RoleActivityController.instance:enterActivity(VersionActivity2_3Enum.ActivityId.DuDuGu)
			end

			VersionActivity2_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(var_6_1, nil, VersionActivity2_3Enum.ActivityId.DuDuGu)
		end
	end)
end

function var_0_0.enterActivity12306(arg_8_0, arg_8_1)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(arg_8_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_3EnterView)

		local var_9_0 = ActivityConfig.instance:getActivityCo(VersionActivity2_3Enum.ActivityId.ZhiXinQuanEr)

		if DungeonModel.instance.lastSendEpisodeId == var_9_0.tryoutEpisode then
			VersionActivity2_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, VersionActivity2_3Enum.ActivityId.ZhiXinQuanEr)
		else
			local function var_9_1()
				RoleActivityController.instance:enterActivity(VersionActivity2_3Enum.ActivityId.ZhiXinQuanEr)
			end

			VersionActivity2_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(var_9_1, nil, VersionActivity2_3Enum.ActivityId.ZhiXinQuanEr)
		end
	end)
end

function var_0_0.enterActivity12302(arg_11_0, arg_11_1)
	var_0_0.enterVersionActivityDungeonCommon(var_0_0._enterActivity12302, arg_11_0, arg_11_1)
end

function var_0_0._enterActivity12302(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1.episodeId
	local var_12_1 = arg_12_1.episodeCo

	if not var_12_1 then
		return
	end

	if var_0_0.sequence then
		var_0_0.sequence:destroy()

		var_0_0.sequence = nil
	end

	local var_12_2 = false

	if var_12_1.chapterId == VersionActivity2_3DungeonEnum.DungeonChapterId.ElementFight then
		DungeonMapModel.instance.lastElementBattleId = var_12_0
		var_12_0 = VersionActivity2_3DungeonModel.instance:getLastEpisodeId()

		if var_12_0 then
			VersionActivity2_3DungeonModel.instance:setLastEpisodeId(nil)
		else
			var_12_0 = DungeonConfig.instance:getActivityElementFightEpisodeToNormalEpisodeId(var_12_1, VersionActivity2_3DungeonEnum.DungeonChapterId.Story)
		end

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_3DungeonMapView)
	elseif DungeonModel.instance.curSendEpisodePass then
		var_12_2 = false

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_3DungeonMapView)
	else
		var_12_2 = true

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_3DungeonMapLevelView)
	end

	local var_12_3 = FlowSequence.New()

	var_12_3:addWork(OpenViewWork.New({
		openFunction = VersionActivity2_3EnterController.directOpenVersionActivityEnterView,
		openFunctionObj = VersionActivity2_3EnterController.instance,
		waitOpenViewName = ViewName.VersionActivity2_3EnterView
	}))
	var_12_3:registerDoneListener(function()
		if var_12_2 then
			VersionActivity2_3DungeonController.instance:openVersionActivityDungeonMapView(nil, var_12_0, function()
				ViewMgr.instance:openView(ViewName.VersionActivity2_3DungeonMapLevelView, {
					episodeId = var_12_0
				})
			end, nil)
		else
			VersionActivity2_3DungeonController.instance:openVersionActivityDungeonMapView(nil, var_12_0)
		end
	end)
	var_12_3:start()

	var_0_0.sequence = var_12_3
end

function var_0_0.enterActivity12304(arg_15_0, arg_15_1)
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(arg_15_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_3EnterView)

		local function var_16_0()
			Activity174Controller.instance:openMainView({
				exitFromFight = true,
				actId = VersionActivity2_3Enum.ActivityId.Act174
			})
		end

		VersionActivity2_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(var_16_0, nil, VersionActivity2_3Enum.ActivityId.Act174)
	end)
end

function var_0_0.enterActivity12315(arg_18_0, arg_18_1)
	var_0_0.enterVersionActivityDungeonCommon(var_0_0._enterActivityDungeonAterFight12315, arg_18_0, arg_18_1)
end

local function var_0_1()
	local var_19_0 = DungeonModel.instance.curSendEpisodeId

	if not var_19_0 then
		return
	end

	local var_19_1 = DungeonConfig.instance:getEpisodeCO(var_19_0)

	if not var_19_1 then
		return false
	end

	local var_19_2 = Season123Model.instance:getBattleContext()

	if not var_19_2 then
		logNormal("Season123 checkSeason123BattleDatas no context found!")

		return false
	end

	return true, var_19_0, var_19_1, var_19_2
end

function var_0_0._enterActivityDungeonAterFight12315(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_1.episodeId
	local var_20_1 = arg_20_1.exitFightGroup

	if not var_20_0 then
		return
	end

	local var_20_2 = Season123Model.instance:getBattleContext()

	if not var_20_2 then
		logNormal("Season123 checkSeason123BattleDatas no context found!")

		return false
	end

	local var_20_3 = var_20_2.layer
	local var_20_4 = var_20_2.stage
	local var_20_5 = var_20_2.actId
	local var_20_6 = var_0_0.recordMO and var_0_0.recordMO.fightResult
	local var_20_7 = DungeonConfig.instance:getEpisodeCO(var_20_0)
	local var_20_8 = var_20_7 and var_20_7.type
	local var_20_9
	local var_20_10

	if var_20_7 then
		if not var_20_6 or var_20_6 == -1 or var_20_6 == 0 then
			if var_20_8 == DungeonEnum.EpisodeType.Season123 then
				var_20_9 = Activity123Enum.JumpId.MarketNoResult
				var_20_10 = {
					tarLayer = var_20_3
				}
			elseif var_20_8 == DungeonEnum.EpisodeType.Season123Retail then
				var_20_9 = Activity123Enum.JumpId.Retail
			end
		elseif var_20_6 == 1 and (not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonUTTU) or not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonDiscount)) then
			if var_20_8 == DungeonEnum.EpisodeType.Season123 then
				local var_20_11 = var_20_3 + 1

				if Season123Config.instance:getSeasonEpisodeCo(var_20_5, var_20_4, var_20_11) then
					var_20_9 = Activity123Enum.JumpId.Market
					var_20_10 = {
						tarLayer = var_20_11
					}
				else
					var_20_9 = Activity123Enum.JumpId.MarketStageFinish
					var_20_10 = {
						stage = var_20_4
					}
				end
			elseif var_20_8 == DungeonEnum.EpisodeType.Season123Retail then
				var_20_9 = Activity123Enum.JumpId.Retail
				var_20_10 = {
					needRandom = true
				}
			end
		end
	else
		logError(string.format("找不到对应关卡表,id:%s", var_20_0))
	end

	VersionActivity2_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		Season123Controller.instance:openSeasonEntry({
			actId = var_20_5,
			jumpId = var_20_9,
			jumpParam = var_20_10
		})
	end, nil, VersionActivity2_3Enum.ActivityId.Season)
end

function var_0_0.checkFightAfterStory12315(arg_22_0, arg_22_1, arg_22_2)
	if (var_0_0.recordMO and var_0_0.recordMO.fightResult) ~= 1 then
		return
	end

	local var_22_0, var_22_1, var_22_2, var_22_3 = var_0_1()

	if not var_22_0 or var_22_2.type ~= DungeonEnum.EpisodeType.Season123 then
		return
	end

	local var_22_4 = var_22_3.layer
	local var_22_5 = var_22_3.actId
	local var_22_6 = var_22_3.stage

	if Season123Model.instance:isEpisodeAfterStory(var_22_5, var_22_6, var_22_4) then
		return
	end

	local var_22_7 = Season123Config.instance:getSeasonEpisodeCo(var_22_5, var_22_6, var_22_4)

	if not var_22_7 or var_22_7.afterStoryId == nil or var_22_7.afterStoryId == 0 then
		return
	end

	StoryController.instance:playStory(var_22_7.afterStoryId, nil, arg_22_0, arg_22_1, arg_22_2)

	return true
end

function var_0_0.enterFightAgain12315()
	local var_23_0, var_23_1, var_23_2, var_23_3 = var_0_1()

	if not var_23_0 or var_23_2.type == DungeonEnum.EpisodeType.Season123Retail then
		return false
	end

	local var_23_4 = var_23_3.layer
	local var_23_5 = var_23_3.stage
	local var_23_6 = var_23_3.actId

	if FightController.instance:isReplayMode(var_23_1) and not var_23_4 then
		if var_23_2.type == DungeonEnum.EpisodeType.Season123 then
			local var_23_7 = Season123Config.instance:getSeasonEpisodeStageCos(var_23_6, var_23_5)

			if not var_23_7 then
				return false
			end

			for iter_23_0, iter_23_1 in pairs(var_23_7) do
				if iter_23_1.episodeId == var_23_1 then
					var_23_4 = iter_23_1.layer

					break
				end
			end
		elseif var_23_2.type == DungeonEnum.EpisodeType.Season123Retail then
			var_23_4 = 0
		end
	end

	GameSceneMgr.instance:closeScene(nil, nil, nil, true)
	Season123EpisodeDetailController.instance:startBattle(var_23_6, var_23_5, var_23_4, var_23_1)

	return true
end

return var_0_0
