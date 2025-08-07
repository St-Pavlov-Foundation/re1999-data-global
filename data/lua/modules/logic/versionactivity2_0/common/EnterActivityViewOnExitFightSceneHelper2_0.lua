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
	MainController.instance:enterMainScene(arg_6_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		PermanentController.instance:jump2Activity(VersionActivity2_0Enum.ActivityId.EnterView)
		RoleActivityController.instance:openLevelView({
			needShowFight = true,
			actId = VersionActivity2_0Enum.ActivityId.Mercuria
		})
	end)
end

function var_0_0.enterActivity12008(arg_8_0, arg_8_1)
	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(arg_8_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		PermanentController.instance:jump2Activity(VersionActivity2_0Enum.ActivityId.EnterView)
		RoleActivityController.instance:openLevelView({
			needShowFight = true,
			actId = VersionActivity2_0Enum.ActivityId.Joe
		})
	end)
end

function var_0_0.activate()
	return
end

function var_0_0.enterActivity12013(arg_11_0, arg_11_1)
	local var_11_0 = DungeonModel.instance.curSendEpisodeId
	local var_11_1, var_11_2 = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(var_11_0)

	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(arg_11_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.V1a4_BossRushMainView)
		VersionActivity2_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			BossRushController.instance:openMainView({
				isOpenLevelDetail = true,
				stage = var_11_1,
				layer = var_11_2
			})
		end, nil, BossRushConfig.instance:getActivityId())
	end)
end

function var_0_0.enterActivity12006(arg_14_0, arg_14_1)
	var_0_0.enterVersionActivityDungeonCommon(var_0_0._enterActivityDungeonAterFight12006, arg_14_0, arg_14_1)
end

local function var_0_1()
	local var_15_0 = DungeonModel.instance.curSendEpisodeId

	if not var_15_0 then
		return
	end

	local var_15_1 = DungeonConfig.instance:getEpisodeCO(var_15_0)

	if not var_15_1 then
		return false
	end

	local var_15_2 = Season123Model.instance:getBattleContext()

	if not var_15_2 then
		logNormal("Season123 checkSeason123BattleDatas no context found!")

		return false
	end

	return true, var_15_0, var_15_1, var_15_2
end

function var_0_0._enterActivityDungeonAterFight12006(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1.episodeId
	local var_16_1 = arg_16_1.exitFightGroup

	if not var_16_0 then
		return
	end

	local var_16_2 = Season123Model.instance:getBattleContext()

	if not var_16_2 then
		logNormal("Season123 checkSeason123BattleDatas no context found!")

		return false
	end

	local var_16_3 = var_16_2.layer
	local var_16_4 = var_16_2.stage
	local var_16_5 = var_16_2.actId
	local var_16_6 = var_0_0.recordMO and var_0_0.recordMO.fightResult
	local var_16_7 = DungeonConfig.instance:getEpisodeCO(var_16_0)
	local var_16_8 = var_16_7 and var_16_7.type
	local var_16_9
	local var_16_10

	if var_16_7 then
		if not var_16_6 or var_16_6 == -1 or var_16_6 == 0 then
			if var_16_8 == DungeonEnum.EpisodeType.Season123 then
				var_16_9 = Activity123Enum.JumpId.MarketNoResult
				var_16_10 = {
					tarLayer = var_16_3
				}
			elseif var_16_8 == DungeonEnum.EpisodeType.Season123Retail then
				var_16_9 = Activity123Enum.JumpId.Retail
			end
		elseif var_16_6 == 1 and (not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonUTTU) or not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonDiscount)) then
			if var_16_8 == DungeonEnum.EpisodeType.Season123 then
				local var_16_11 = var_16_3 + 1

				if Season123Config.instance:getSeasonEpisodeCo(var_16_5, var_16_4, var_16_11) then
					var_16_9 = Activity123Enum.JumpId.Market
					var_16_10 = {
						tarLayer = var_16_11
					}
				else
					var_16_9 = Activity123Enum.JumpId.MarketStageFinish
					var_16_10 = {
						stage = var_16_4
					}
				end
			elseif var_16_8 == DungeonEnum.EpisodeType.Season123Retail then
				var_16_9 = Activity123Enum.JumpId.Retail
				var_16_10 = {
					needRandom = true
				}
			end
		end
	else
		logError(string.format("找不到对应关卡表,id:%s", var_16_0))
	end

	VersionActivity2_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		Season123Controller.instance:openSeasonEntry({
			actId = var_16_5,
			jumpId = var_16_9,
			jumpParam = var_16_10
		})
	end, nil, VersionActivity2_0Enum.ActivityId.Season)
end

function var_0_0.checkFightAfterStory12006(arg_18_0, arg_18_1, arg_18_2)
	if (var_0_0.recordMO and var_0_0.recordMO.fightResult) ~= 1 then
		return
	end

	local var_18_0, var_18_1, var_18_2, var_18_3 = var_0_1()

	if not var_18_0 or var_18_2.type ~= DungeonEnum.EpisodeType.Season123 then
		return
	end

	local var_18_4 = var_18_3.layer
	local var_18_5 = var_18_3.actId
	local var_18_6 = var_18_3.stage

	if Season123Model.instance:isEpisodeAfterStory(var_18_5, var_18_6, var_18_4) then
		return
	end

	local var_18_7 = Season123Config.instance:getSeasonEpisodeCo(var_18_5, var_18_6, var_18_4)

	if not var_18_7 or var_18_7.afterStoryId == nil or var_18_7.afterStoryId == 0 then
		return
	end

	StoryController.instance:playStory(var_18_7.afterStoryId, nil, arg_18_0, arg_18_1, arg_18_2)

	return true
end

function var_0_0.enterFightAgain12006()
	local var_19_0, var_19_1, var_19_2, var_19_3 = var_0_1()

	if not var_19_0 or var_19_2.type == DungeonEnum.EpisodeType.Season123Retail then
		return false
	end

	local var_19_4 = var_19_3.layer
	local var_19_5 = var_19_3.stage
	local var_19_6 = var_19_3.actId

	if FightController.instance:isReplayMode(var_19_1) and not var_19_4 then
		if var_19_2.type == DungeonEnum.EpisodeType.Season123 then
			local var_19_7 = Season123Config.instance:getSeasonEpisodeStageCos(var_19_6, var_19_5)

			if not var_19_7 then
				return false
			end

			for iter_19_0, iter_19_1 in pairs(var_19_7) do
				if iter_19_1.episodeId == var_19_1 then
					var_19_4 = iter_19_1.layer

					break
				end
			end
		elseif var_19_2.type == DungeonEnum.EpisodeType.Season123Retail then
			var_19_4 = 0
		end
	end

	GameSceneMgr.instance:closeScene(nil, nil, nil, true)
	Season123EpisodeDetailController.instance:startBattle(var_19_6, var_19_5, var_19_4, var_19_1)

	return true
end

return var_0_0
