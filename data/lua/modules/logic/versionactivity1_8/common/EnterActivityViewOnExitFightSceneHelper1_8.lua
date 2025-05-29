module("modules.logic.versionactivity1_8.common.EnterActivityViewOnExitFightSceneHelper1_8", package.seeall)

local var_0_0 = EnterActivityViewOnExitFightSceneHelper

function var_0_0.enterActivity11804(arg_1_0, arg_1_1)
	var_0_0.enterVersionActivityDungeonCommon(var_0_0._enterActivity11804, arg_1_0, arg_1_1)
end

function var_0_0._enterActivity11804(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.episodeId
	local var_2_1 = arg_2_1.episodeCo

	if var_0_0.sequence then
		var_0_0.sequence:destroy()

		var_0_0.sequence = nil
	end

	local var_2_2 = false

	if var_2_1.chapterId == VersionActivity1_8DungeonEnum.DungeonChapterId.ElementFight then
		DungeonMapModel.instance.lastElementBattleId = var_2_0
		var_2_0 = VersionActivity1_8DungeonModel.instance:getLastEpisodeId()

		if var_2_0 then
			VersionActivity1_8DungeonModel.instance:setLastEpisodeId(nil)
		else
			var_2_0 = DungeonConfig.instance:getActivityElementFightEpisodeToNormalEpisodeId(var_2_1, VersionActivity1_8DungeonEnum.DungeonChapterId.Story)
		end

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_8DungeonMapView)
	elseif DungeonModel.instance.curSendEpisodePass then
		var_2_2 = false

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_8DungeonMapView)
	else
		var_2_2 = true

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_8DungeonMapLevelView)
	end

	PermanentController.instance:jump2Activity(VersionActivity1_8Enum.ActivityId.EnterView)

	local var_2_3 = FlowSequence.New()

	var_2_3:addWork(OpenViewWork.New({
		openFunction = var_0_0.open2_4ReactivityEnterView,
		waitOpenViewName = ViewName.VersionActivity2_4EnterView
	}))
	var_2_3:registerDoneListener(function()
		if var_2_2 then
			VersionActivity1_8DungeonController.instance:openVersionActivityDungeonMapView(nil, var_2_0, function()
				ViewMgr.instance:openView(ViewName.VersionActivity1_8DungeonMapLevelView, {
					episodeId = var_2_0
				})
			end, nil)
		else
			VersionActivity1_8DungeonController.instance:openVersionActivityDungeonMapView(nil, var_2_0)
		end
	end)
	var_2_3:start()

	var_0_0.sequence = var_2_3
end

function var_0_0.open2_4ReactivityEnterView()
	VersionActivity2_4EnterController.instance:directOpenVersionActivityEnterView(VersionActivity2_4Enum.ActivityId.Reactivity)
end

function var_0_0._enterActivity11804(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1.episodeId
	local var_6_1 = arg_6_1.episodeCo

	if var_0_0.sequence then
		var_0_0.sequence:destroy()

		var_0_0.sequence = nil
	end

	local var_6_2 = false

	if var_6_1.chapterId == VersionActivity1_8DungeonEnum.DungeonChapterId.ElementFight then
		DungeonMapModel.instance.lastElementBattleId = var_6_0
		var_6_0 = VersionActivity1_8DungeonModel.instance:getLastEpisodeId()

		if var_6_0 then
			VersionActivity1_8DungeonModel.instance:setLastEpisodeId(nil)
		else
			var_6_0 = DungeonConfig.instance:getActivityElementFightEpisodeToNormalEpisodeId(var_6_1, VersionActivity1_8DungeonEnum.DungeonChapterId.Story)
		end

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_8DungeonMapView)
	elseif DungeonModel.instance.curSendEpisodePass then
		var_6_2 = false

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_8DungeonMapView)
	else
		var_6_2 = true

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_8DungeonMapLevelView)
	end

	local var_6_3 = FlowSequence.New()

	var_6_3:addWork(OpenViewWork.New({
		openFunction = var_0_0.open2_6ReactivityEnterView,
		waitOpenViewName = ViewName.VersionActivity2_6EnterView
	}))
	var_6_3:registerDoneListener(function()
		if var_6_2 then
			VersionActivity1_8DungeonController.instance:openVersionActivityDungeonMapView(nil, var_6_0, function()
				ViewMgr.instance:openView(ViewName.VersionActivity1_8DungeonMapLevelView, {
					episodeId = var_6_0
				})
			end, nil)
		else
			VersionActivity1_8DungeonController.instance:openVersionActivityDungeonMapView(nil, var_6_0)
		end
	end)
	var_6_3:start()

	var_0_0.sequence = var_6_3
end

function var_0_0.open2_6ReactivityEnterView()
	VersionActivity2_6EnterController.instance:directOpenVersionActivityEnterView(VersionActivity2_6Enum.ActivityId.Reactivity)
end

function var_0_0.enterActivity11806(arg_10_0, arg_10_1)
	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(arg_10_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		local var_11_0 = ActivityConfig.instance:getActivityCo(VersionActivity1_8Enum.ActivityId.Weila)

		if var_11_0 and var_11_0.isRetroAcitivity == 2 then
			PermanentController.instance:jump2Activity(VersionActivity1_8Enum.ActivityId.EnterView)
			ActWeilaController.instance:openLevelView({
				needShowFight = true
			})
		else
			GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_8EnterView)
			VersionActivity1_8EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
				ActWeilaController.instance:openLevelView({
					needShowFight = true
				})
			end, nil, VersionActivity1_8Enum.ActivityId.Weila)
		end
	end)
end

function var_0_0.enterActivity11807(arg_13_0, arg_13_1)
	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(arg_13_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		local var_14_0 = ActivityConfig.instance:getActivityCo(VersionActivity1_8Enum.ActivityId.Weila)

		if var_14_0 and var_14_0.isRetroAcitivity == 2 then
			PermanentController.instance:jump2Activity(VersionActivity1_8Enum.ActivityId.EnterView)
			ActWindSongController.instance:openLevelView({
				needShowFight = true
			})
		else
			GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_8EnterView)
			VersionActivity1_8EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
				ActWindSongController.instance:openLevelView({
					needShowFight = true
				})
			end, nil, VersionActivity1_8Enum.ActivityId.WindSong)
		end
	end)
end

function var_0_0.enterActivity11812(arg_16_0, arg_16_1)
	local var_16_0 = DungeonModel.instance.curSendEpisodeId
	local var_16_1, var_16_2 = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(var_16_0)

	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(arg_16_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.V1a4_BossRushMainView)
		VersionActivity1_8EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			BossRushController.instance:openMainView({
				isOpenLevelDetail = true,
				stage = var_16_1,
				layer = var_16_2
			})
		end, nil, BossRushConfig.instance:getActivityId())
	end)
end

function var_0_0.enterActivity11811(arg_19_0, arg_19_1)
	var_0_0.enterVersionActivityDungeonCommon(var_0_0._enterActivityDungeonAterFight11811, arg_19_0, arg_19_1)
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

function var_0_0._enterActivityDungeonAterFight11811(arg_21_0, arg_21_1)
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

	VersionActivity1_8EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		Season123Controller.instance:openSeasonEntry({
			actId = var_21_5,
			jumpId = var_21_9,
			jumpParam = var_21_10
		})
	end, nil, VersionActivity1_8Enum.ActivityId.Season)
end

function var_0_0.checkFightAfterStory11811(arg_23_0, arg_23_1, arg_23_2)
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

function var_0_0.enterFightAgain11811()
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

function var_0_0.activate()
	return
end

return var_0_0
