module("modules.logic.versionactivity2_0.common.EnterActivityViewOnExitFightSceneHelper2_0", package.seeall)

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
		openFunction = var_0_0.open2_7ReactivityEnterView,
		openFunctionObj = VersionActivityFixedHelper.getVersionActivityEnterController().instance,
		waitOpenViewName = VersionActivityFixedHelper.getVersionActivityEnterViewName()
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

function var_0_0.open2_7ReactivityEnterView()
	VersionActivityFixedHelper.getVersionActivityEnterController():directOpenVersionActivityEnterView(VersionActivity2_7Enum.ActivityId.Reactivity)
end

function var_0_0.enterActivity12009(arg_6_0, arg_6_1)
	DungeonModel.instance:resetSendChapterEpisodeId()

	local var_6_0 = VersionActivity2_0Enum.ActivityId.Mercuria

	MainController.instance:enterMainScene(arg_6_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_0EnterView)
		VersionActivity2_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			RoleActivityController.instance:openLevelView({
				needShowFight = true,
				actId = var_6_0
			})
		end, nil, var_6_0)
	end)
end

function var_0_0.enterActivity12008(arg_9_0, arg_9_1)
	DungeonModel.instance:resetSendChapterEpisodeId()

	local var_9_0 = VersionActivity2_0Enum.ActivityId.Joe

	MainController.instance:enterMainScene(arg_9_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_0EnterView)
		VersionActivity2_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			RoleActivityController.instance:openLevelView({
				needShowFight = true,
				actId = var_9_0
			})
		end, nil, var_9_0)
	end)
end

function var_0_0.activate()
	return
end

function var_0_0.enterActivity12013(arg_13_0, arg_13_1)
	local var_13_0 = DungeonModel.instance.curSendEpisodeId
	local var_13_1, var_13_2 = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(var_13_0)

	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(arg_13_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.V1a4_BossRushMainView)
		VersionActivity2_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			BossRushController.instance:openMainView({
				isOpenLevelDetail = true,
				stage = var_13_1,
				layer = var_13_2
			})
		end, nil, BossRushConfig.instance:getActivityId())
	end)
end

function var_0_0.enterActivity12006(arg_16_0, arg_16_1)
	var_0_0.enterVersionActivityDungeonCommon(var_0_0._enterActivityDungeonAterFight12006, arg_16_0, arg_16_1)
end

local function var_0_1()
	local var_17_0 = DungeonModel.instance.curSendEpisodeId

	if not var_17_0 then
		return
	end

	local var_17_1 = DungeonConfig.instance:getEpisodeCO(var_17_0)

	if not var_17_1 then
		return false
	end

	local var_17_2 = Season123Model.instance:getBattleContext()

	if not var_17_2 then
		logNormal("Season123 checkSeason123BattleDatas no context found!")

		return false
	end

	return true, var_17_0, var_17_1, var_17_2
end

function var_0_0._enterActivityDungeonAterFight12006(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1.episodeId
	local var_18_1 = arg_18_1.exitFightGroup

	if not var_18_0 then
		return
	end

	local var_18_2 = Season123Model.instance:getBattleContext()

	if not var_18_2 then
		logNormal("Season123 checkSeason123BattleDatas no context found!")

		return false
	end

	local var_18_3 = var_18_2.layer
	local var_18_4 = var_18_2.stage
	local var_18_5 = var_18_2.actId
	local var_18_6 = var_0_0.recordMO and var_0_0.recordMO.fightResult
	local var_18_7 = DungeonConfig.instance:getEpisodeCO(var_18_0)
	local var_18_8 = var_18_7 and var_18_7.type
	local var_18_9
	local var_18_10

	if var_18_7 then
		if not var_18_6 or var_18_6 == -1 or var_18_6 == 0 then
			if var_18_8 == DungeonEnum.EpisodeType.Season123 then
				var_18_9 = Activity123Enum.JumpId.MarketNoResult
				var_18_10 = {
					tarLayer = var_18_3
				}
			elseif var_18_8 == DungeonEnum.EpisodeType.Season123Retail then
				var_18_9 = Activity123Enum.JumpId.Retail
			end
		elseif var_18_6 == 1 and (not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonUTTU) or not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonDiscount)) then
			if var_18_8 == DungeonEnum.EpisodeType.Season123 then
				local var_18_11 = var_18_3 + 1

				if Season123Config.instance:getSeasonEpisodeCo(var_18_5, var_18_4, var_18_11) then
					var_18_9 = Activity123Enum.JumpId.Market
					var_18_10 = {
						tarLayer = var_18_11
					}
				else
					var_18_9 = Activity123Enum.JumpId.MarketStageFinish
					var_18_10 = {
						stage = var_18_4
					}
				end
			elseif var_18_8 == DungeonEnum.EpisodeType.Season123Retail then
				var_18_9 = Activity123Enum.JumpId.Retail
				var_18_10 = {
					needRandom = true
				}
			end
		end
	else
		logError(string.format("找不到对应关卡表,id:%s", var_18_0))
	end

	VersionActivity2_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		Season123Controller.instance:openSeasonEntry({
			actId = var_18_5,
			jumpId = var_18_9,
			jumpParam = var_18_10
		})
	end, nil, VersionActivity2_0Enum.ActivityId.Season)
end

function var_0_0.checkFightAfterStory12006(arg_20_0, arg_20_1, arg_20_2)
	if (var_0_0.recordMO and var_0_0.recordMO.fightResult) ~= 1 then
		return
	end

	local var_20_0, var_20_1, var_20_2, var_20_3 = var_0_1()

	if not var_20_0 or var_20_2.type ~= DungeonEnum.EpisodeType.Season123 then
		return
	end

	local var_20_4 = var_20_3.layer
	local var_20_5 = var_20_3.actId
	local var_20_6 = var_20_3.stage

	if Season123Model.instance:isEpisodeAfterStory(var_20_5, var_20_6, var_20_4) then
		return
	end

	local var_20_7 = Season123Config.instance:getSeasonEpisodeCo(var_20_5, var_20_6, var_20_4)

	if not var_20_7 or var_20_7.afterStoryId == nil or var_20_7.afterStoryId == 0 then
		return
	end

	StoryController.instance:playStory(var_20_7.afterStoryId, nil, arg_20_0, arg_20_1, arg_20_2)

	return true
end

function var_0_0.enterFightAgain12006()
	local var_21_0, var_21_1, var_21_2, var_21_3 = var_0_1()

	if not var_21_0 or var_21_2.type == DungeonEnum.EpisodeType.Season123Retail then
		return false
	end

	local var_21_4 = var_21_3.layer
	local var_21_5 = var_21_3.stage
	local var_21_6 = var_21_3.actId

	if FightController.instance:isReplayMode(var_21_1) and not var_21_4 then
		if var_21_2.type == DungeonEnum.EpisodeType.Season123 then
			local var_21_7 = Season123Config.instance:getSeasonEpisodeStageCos(var_21_6, var_21_5)

			if not var_21_7 then
				return false
			end

			for iter_21_0, iter_21_1 in pairs(var_21_7) do
				if iter_21_1.episodeId == var_21_1 then
					var_21_4 = iter_21_1.layer

					break
				end
			end
		elseif var_21_2.type == DungeonEnum.EpisodeType.Season123Retail then
			var_21_4 = 0
		end
	end

	GameSceneMgr.instance:closeScene(nil, nil, nil, true)
	Season123EpisodeDetailController.instance:startBattle(var_21_6, var_21_5, var_21_4, var_21_1)

	return true
end

return var_0_0
