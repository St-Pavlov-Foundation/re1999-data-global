module("modules.logic.versionactivity2_5.common.EnterActivityViewOnExitFightSceneHelper2_5", package.seeall)

local var_0_0 = EnterActivityViewOnExitFightSceneHelper

function var_0_0.activate()
	return
end

function var_0_0.enterActivity12516(arg_2_0, arg_2_1)
	local var_2_0 = DungeonModel.instance.curSendEpisodeId
	local var_2_1, var_2_2 = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(var_2_0)

	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(arg_2_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.V1a4_BossRushMainView)
		VersionActivity2_5EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			BossRushController.instance:openMainView({
				isOpenLevelDetail = true,
				stage = var_2_1,
				layer = var_2_2
			})
		end, nil, BossRushConfig.instance:getActivityId())
	end)
end

function var_0_0.enterActivity12502(arg_5_0, arg_5_1)
	var_0_0.enterVersionActivityDungeonCommon(var_0_0._enterActivity12502, arg_5_0, arg_5_1)
end

function var_0_0._enterActivity12502(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1.episodeId

	if not arg_6_1.episodeCo then
		return
	end

	if var_0_0.sequence then
		var_0_0.sequence:destroy()

		var_0_0.sequence = nil
	end

	local var_6_1 = false

	if DungeonModel.instance.curSendEpisodePass then
		var_6_1 = false

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_5DungeonMapView)
	else
		var_6_1 = true

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_5DungeonMapLevelView)
	end

	local var_6_2 = FlowSequence.New()

	var_6_2:addWork(OpenViewWork.New({
		openFunction = VersionActivity2_5EnterController.directOpenVersionActivityEnterView,
		openFunctionObj = VersionActivity2_5EnterController.instance,
		waitOpenViewName = ViewName.VersionActivity2_5EnterView
	}))
	var_6_2:registerDoneListener(function()
		if var_6_1 then
			VersionActivity2_5DungeonController.instance:openVersionActivityDungeonMapView(nil, var_6_0, function()
				ViewMgr.instance:openView(ViewName.VersionActivity2_5DungeonMapLevelView, {
					episodeId = var_6_0
				})
			end, nil)
		else
			VersionActivity2_5DungeonController.instance:openVersionActivityDungeonMapView(nil, var_6_0)
		end
	end)
	var_6_2:start()

	var_0_0.sequence = var_6_2
end

function var_0_0.enterActivity12305(arg_9_0, arg_9_1)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(arg_9_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_5EnterView)

		local var_10_0 = ActivityConfig.instance:getActivityCo(VersionActivity2_5Enum.ActivityId.DuDuGu)

		if DungeonModel.instance.lastSendEpisodeId == var_10_0.tryoutEpisode then
			VersionActivity2_5EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, VersionActivity2_5Enum.ActivityId.DuDuGu)
		else
			local function var_10_1()
				RoleActivityController.instance:enterActivity(VersionActivity2_5Enum.ActivityId.DuDuGu)
			end

			VersionActivity2_5EnterController.instance:openVersionActivityEnterViewIfNotOpened(var_10_1, nil, VersionActivity2_5Enum.ActivityId.DuDuGu)
		end
	end)
end

function var_0_0.enterActivity12302(arg_12_0, arg_12_1)
	var_0_0.enterVersionActivityDungeonCommon(var_0_0._enterActivity12302, arg_12_0, arg_12_1)
end

function var_0_0._enterActivity12302(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1.episodeId
	local var_13_1 = arg_13_1.episodeCo

	if not var_13_1 then
		return
	end

	if var_0_0.sequence then
		var_0_0.sequence:destroy()

		var_0_0.sequence = nil
	end

	local var_13_2 = false

	if var_13_1.chapterId == VersionActivity2_5DungeonEnum.DungeonChapterId.ElementFight then
		DungeonMapModel.instance.lastElementBattleId = var_13_0
		var_13_0 = VersionActivity2_5DungeonModel.instance:getLastEpisodeId()

		if var_13_0 then
			VersionActivity2_5DungeonModel.instance:setLastEpisodeId(nil)
		else
			var_13_0 = DungeonConfig.instance:getActivityElementFightEpisodeToNormalEpisodeId(var_13_1, VersionActivity2_5DungeonEnum.DungeonChapterId.Story)
		end

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_5DungeonMapView)
	elseif DungeonModel.instance.curSendEpisodePass then
		var_13_2 = false

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_5DungeonMapView)
	else
		var_13_2 = true

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_5DungeonMapLevelView)
	end

	local var_13_3 = FlowSequence.New()

	var_13_3:addWork(OpenViewWork.New({
		openFunction = VersionActivity2_5EnterController.directOpenVersionActivityEnterView,
		openFunctionObj = VersionActivity2_5EnterController.instance,
		waitOpenViewName = ViewName.VersionActivity2_5EnterView
	}))
	var_13_3:registerDoneListener(function()
		if var_13_2 then
			VersionActivity2_5DungeonController.instance:openVersionActivityDungeonMapView(nil, var_13_0, function()
				ViewMgr.instance:openView(ViewName.VersionActivity2_5DungeonMapLevelView, {
					episodeId = var_13_0
				})
			end, nil)
		else
			VersionActivity2_5DungeonController.instance:openVersionActivityDungeonMapView(nil, var_13_0)
		end
	end)
	var_13_3:start()

	var_0_0.sequence = var_13_3
end

function var_0_0.enterActivity12304(arg_16_0, arg_16_1)
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(arg_16_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_5EnterView)

		local function var_17_0()
			Activity174Controller.instance:openMainView({
				exitFromFight = true
			})
		end

		VersionActivity2_5EnterController.instance:openVersionActivityEnterViewIfNotOpened(var_17_0, nil, VersionActivity2_5Enum.ActivityId.Act174)
	end)
end

function var_0_0.enterActivity12315(arg_19_0, arg_19_1)
	var_0_0.enterVersionActivityDungeonCommon(var_0_0._enterActivityDungeonAterFight12115, arg_19_0, arg_19_1)
end

local function var_0_1()
	local var_20_0 = DungeonModel.instance.curSendEpisodeId

	if not var_20_0 then
		return
	end

	local var_20_1 = DungeonConfig.instance:getEpisodeCO(var_20_0)

	if not var_20_1 then
		return false
	end

	local var_20_2 = Season123Model.instance:getBattleContext()

	if not var_20_2 then
		logNormal("Season123 checkSeason123BattleDatas no context found!")

		return false
	end

	return true, var_20_0, var_20_1, var_20_2
end

function var_0_0._enterActivityDungeonAterFight12115(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_1.episodeId
	local var_21_1 = arg_21_1.exitFightGroup

	if not var_21_0 then
		return
	end

	local var_21_2 = Season123Model.instance:getBattleContext()

	if not var_21_2 then
		logNormal("Season123 checkSeason123BattleDatas no context found!")

		return false
	end

	local var_21_3 = var_21_2.layer
	local var_21_4 = var_21_2.stage
	local var_21_5 = var_21_2.actId
	local var_21_6 = var_0_0.recordMO and var_0_0.recordMO.fightResult
	local var_21_7 = DungeonConfig.instance:getEpisodeCO(var_21_0)
	local var_21_8 = var_21_7 and var_21_7.type
	local var_21_9
	local var_21_10

	if var_21_7 then
		if not var_21_6 or var_21_6 == -1 or var_21_6 == 0 then
			if var_21_8 == DungeonEnum.EpisodeType.Season123 then
				var_21_9 = Activity123Enum.JumpId.MarketNoResult
				var_21_10 = {
					tarLayer = var_21_3
				}
			elseif var_21_8 == DungeonEnum.EpisodeType.Season123Retail then
				var_21_9 = Activity123Enum.JumpId.Retail
			end
		elseif var_21_6 == 1 and (not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonUTTU) or not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonDiscount)) then
			if var_21_8 == DungeonEnum.EpisodeType.Season123 then
				local var_21_11 = var_21_3 + 1

				if Season123Config.instance:getSeasonEpisodeCo(var_21_5, var_21_4, var_21_11) then
					var_21_9 = Activity123Enum.JumpId.Market
					var_21_10 = {
						tarLayer = var_21_11
					}
				else
					var_21_9 = Activity123Enum.JumpId.MarketStageFinish
					var_21_10 = {
						stage = var_21_4
					}
				end
			elseif var_21_8 == DungeonEnum.EpisodeType.Season123Retail then
				var_21_9 = Activity123Enum.JumpId.Retail
				var_21_10 = {
					needRandom = true
				}
			end
		end
	else
		logError(string.format("找不到对应关卡表,id:%s", var_21_0))
	end

	VersionActivity2_5EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		Season123Controller.instance:openSeasonEntry({
			actId = var_21_5,
			jumpId = var_21_9,
			jumpParam = var_21_10
		})
	end, nil, VersionActivity2_5Enum.ActivityId.Season)
end

function var_0_0.checkFightAfterStory12115(arg_23_0, arg_23_1, arg_23_2)
	if (var_0_0.recordMO and var_0_0.recordMO.fightResult) ~= 1 then
		return
	end

	local var_23_0, var_23_1, var_23_2, var_23_3 = var_0_1()

	if not var_23_0 or var_23_2.type ~= DungeonEnum.EpisodeType.Season123 then
		return
	end

	local var_23_4 = var_23_3.layer
	local var_23_5 = var_23_3.actId
	local var_23_6 = var_23_3.stage

	if Season123Model.instance:isEpisodeAfterStory(var_23_5, var_23_6, var_23_4) then
		return
	end

	local var_23_7 = Season123Config.instance:getSeasonEpisodeCo(var_23_5, var_23_6, var_23_4)

	if not var_23_7 or var_23_7.afterStoryId == nil or var_23_7.afterStoryId == 0 then
		return
	end

	StoryController.instance:playStory(var_23_7.afterStoryId, nil, arg_23_0, arg_23_1, arg_23_2)

	return true
end

function var_0_0.enterFightAgain12115()
	local var_24_0, var_24_1, var_24_2, var_24_3 = var_0_1()

	if not var_24_0 or var_24_2.type == DungeonEnum.EpisodeType.Season123Retail then
		return false
	end

	local var_24_4 = var_24_3.layer
	local var_24_5 = var_24_3.stage
	local var_24_6 = var_24_3.actId

	if FightController.instance:isReplayMode(var_24_1) and not var_24_4 then
		if var_24_2.type == DungeonEnum.EpisodeType.Season123 then
			local var_24_7 = Season123Config.instance:getSeasonEpisodeStageCos(var_24_6, var_24_5)

			if not var_24_7 then
				return false
			end

			for iter_24_0, iter_24_1 in pairs(var_24_7) do
				if iter_24_1.episodeId == var_24_1 then
					var_24_4 = iter_24_1.layer

					break
				end
			end
		elseif var_24_2.type == DungeonEnum.EpisodeType.Season123Retail then
			var_24_4 = 0
		end
	end

	GameSceneMgr.instance:closeScene(nil, nil, nil, true)
	Season123EpisodeDetailController.instance:startBattle(var_24_6, var_24_5, var_24_4, var_24_1)

	return true
end

function var_0_0.enterActivity12505(arg_25_0, arg_25_1)
	local var_25_0 = DungeonModel.instance.curSendEpisodeId

	DungeonModel.instance.lastSendEpisodeId = var_25_0
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(arg_25_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.Act183MainView)
		VersionActivity2_5EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, VersionActivity2_5Enum.ActivityId.Challenge)
		Act183Controller.instance:openAct183MainView(nil, function()
			local var_27_0 = Act183Config.instance:getEpisodeCo(var_25_0)
			local var_27_1 = Act183Model.instance:getGroupEpisodeMo(var_27_0.groupId)
			local var_27_2 = var_27_1 and var_27_1:getGroupType()
			local var_27_3 = var_27_1 and var_27_1:getGroupId()
			local var_27_4 = Act183Helper.generateDungeonViewParams(var_27_2, var_27_3)

			Act183Controller.instance:openAct183DungeonView(var_27_4)
		end)
	end)
end

function var_0_0.enterActivity12512(arg_28_0, arg_28_1)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(arg_28_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_5EnterView)
		VersionActivity2_5EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, VersionActivity2_5Enum.ActivityId.LiangYue, true)
	end)
end

function var_0_0.enterActivity12513(arg_30_0, arg_30_1)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(arg_30_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_5EnterView)
		VersionActivity2_5EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, VersionActivity2_5Enum.ActivityId.FeiLinShiDuo, true)
	end)
end

return var_0_0
