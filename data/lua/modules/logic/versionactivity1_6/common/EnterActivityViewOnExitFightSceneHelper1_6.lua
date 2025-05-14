module("modules.logic.versionactivity1_6.common.EnterActivityViewOnExitFightSceneHelper1_6", package.seeall)

local var_0_0 = EnterActivityViewOnExitFightSceneHelper

function var_0_0.enterActivity11610(arg_1_0, arg_1_1)
	local var_1_0 = V1a6_CachotRoomModel.instance:getNowBattleEventMo()

	if not arg_1_1 and var_1_0 and not var_1_0:isBattleSuccess() then
		GameSceneMgr.instance:closeScene(nil, nil, nil, true)
		V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.PlayerTriggerInteract, var_1_0)

		return
	end

	local var_1_1 = DungeonModel.instance.curSendEpisodeId

	DungeonModel.instance.curSendEpisodeId = nil

	V1a6_CachotController.instance:enterMap(true)
end

function var_0_0.enterActivity11605(arg_2_0, arg_2_1)
	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(arg_2_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_6EnterView)
		VersionActivity1_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			ActQuNiangController.instance:openLevelView({
				needShowFight = true
			})
		end, nil, ActQuNiangEnum.ActivityId)
	end)
end

function var_0_0.enterActivity11606(arg_5_0, arg_5_1)
	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(arg_5_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_6EnterView)
		VersionActivity1_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			ActGeTianController.instance:openLevelView({
				needShowFight = true
			})
		end, nil, ActGeTianEnum.ActivityId)
	end)
end

function var_0_0.enterActivity11602(arg_8_0, arg_8_1)
	var_0_0.enterVersionActivityDungeonCommon(var_0_0._enterActivity11602, arg_8_0, arg_8_1)
end

function var_0_0._enterActivity11602(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1.episodeId
	local var_9_1 = arg_9_1.episodeCo

	if var_0_0.sequence then
		var_0_0.sequence:destroy()

		var_0_0.sequence = nil
	end

	local var_9_2 = false

	if DungeonModel.instance.curSendEpisodePass then
		var_9_2 = false

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_6DungeonMapView)
	else
		var_9_2 = true

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_6DungeonMapLevelView)
	end

	local var_9_3 = FlowSequence.New()
	local var_9_4 = ActivityConfig.instance:getActivityCo(VersionActivity1_6Enum.ActivityId.Dungeon)
	local var_9_5 = var_9_4 and var_9_4.isRetroAcitivity == 1 and ViewName.VersionActivity2_5EnterView or ViewName.VersionActivity1_6EnterView
	local var_9_6 = var_9_4 and var_9_4.isRetroAcitivity == 1 and VersionActivity2_5EnterController or VersionActivity1_6EnterController

	var_9_3:addWork(OpenViewWork.New({
		openFunction = var_0_0.open2_5ReactivityEnterView,
		openFunctionObj = var_9_6.instance,
		waitOpenViewName = var_9_5
	}))
	var_9_3:registerDoneListener(function()
		if var_9_2 then
			VersionActivity1_6DungeonController.instance:openVersionActivityDungeonMapView(nil, var_9_0, function()
				ViewMgr.instance:openView(ViewName.VersionActivity1_6DungeonMapLevelView, {
					episodeId = var_9_0
				})
			end, nil)
		else
			VersionActivity1_6DungeonController.instance:openVersionActivityDungeonMapView(nil, var_9_0)
		end
	end)
	var_9_3:start()

	var_0_0.sequence = var_9_3
end

function var_0_0.open2_5ReactivityEnterView()
	VersionActivity2_5EnterController.instance:directOpenVersionActivityEnterView(VersionActivity2_5Enum.ActivityId.Reactivity)
end

function var_0_0.enterActivity11609(arg_13_0, arg_13_1)
	local var_13_0 = DungeonModel.instance.curSendEpisodeId

	DungeonModel.instance.lastSendEpisodeId = var_13_0
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(arg_13_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_6DungeonBossView)

		local var_14_0 = ActivityConfig.instance:getActivityCo(VersionActivity1_6Enum.ActivityId.DungeonBossRush)

		if var_14_0 and var_14_0.isRetroAcitivity == 1 then
			VersionActivity2_5EnterController.instance:openVersionActivityEnterViewIfNotOpened()
		else
			VersionActivity1_6EnterController.instance:openVersionActivityEnterViewIfNotOpened()
		end

		VersionActivity1_6DungeonController.instance:openVersionActivityDungeonMapView(nil, VersionActivity1_6DungeonEnum.DungeonBossEpisodeId, function()
			VersionActivity1_6DungeonController.instance:openDungeonBossView(true)
		end, nil)
	end)
end

function var_0_0.enterActivity11600(arg_16_0, arg_16_1)
	var_0_0.enterVersionActivityDungeonCommon(var_0_0._enterActivityDungeonAterFight11600, arg_16_0, arg_16_1)
end

function var_0_0.checkFightAfterStory11600(arg_17_0, arg_17_1, arg_17_2)
	if (var_0_0.recordMO and var_0_0.recordMO.fightResult) ~= 1 then
		return
	end

	local var_17_0 = DungeonModel.instance.curSendEpisodeId

	if not var_17_0 then
		return
	end

	local var_17_1 = DungeonConfig.instance:getEpisodeCO(var_17_0)

	if not var_17_1 or var_17_1.type ~= DungeonEnum.EpisodeType.Season then
		return
	end

	local var_17_2 = Activity104Model.instance:getBattleFinishLayer()
	local var_17_3 = Activity104Model.instance:getCurSeasonId()

	if Activity104Model.instance:isEpisodeAfterStory(var_17_3, var_17_2) then
		return
	end

	local var_17_4 = SeasonConfig.instance:getSeasonEpisodeCo(var_17_3, var_17_2)

	if not var_17_4 or var_17_4.afterStoryId == 0 then
		return
	end

	StoryController.instance:playStory(var_17_4.afterStoryId, nil, arg_17_0, arg_17_1, arg_17_2)

	return true
end

function var_0_0._enterActivityDungeonAterFight11600(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1.episodeId
	local var_18_1 = arg_18_1.exitFightGroup

	if not var_18_0 then
		return
	end

	local var_18_2 = Activity104Model.instance:getBattleFinishLayer()
	local var_18_3 = Activity104Model.instance:getCurSeasonId()

	VersionActivity1_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, var_18_3)

	local var_18_4 = var_0_0.recordMO and var_0_0.recordMO.fightResult
	local var_18_5 = DungeonConfig.instance:getEpisodeCO(var_18_0)
	local var_18_6 = var_18_5 and var_18_5.type
	local var_18_7 = Activity104Model.instance:canPlayStageLevelup(var_18_4, var_18_6, var_18_1, var_18_3, var_18_2)
	local var_18_8
	local var_18_9
	local var_18_10 = Activity104Model.instance:canMarkFightAfterStory(var_18_4, var_18_6, var_18_1, var_18_3, var_18_2)

	if var_18_10 then
		Activity104Rpc.instance:sendMarkEpisodeAfterStoryRequest(var_18_3, var_18_2)
	end

	if var_18_5 then
		if not var_18_4 or var_18_4 == -1 or var_18_4 == 0 then
			if var_18_6 == DungeonEnum.EpisodeType.Season then
				var_18_8 = Activity104Enum.JumpId.Market
				var_18_9 = {
					tarLayer = var_18_2
				}
			elseif var_18_6 == DungeonEnum.EpisodeType.SeasonRetail then
				var_18_8 = Activity104Enum.JumpId.Retail
			elseif var_18_6 == DungeonEnum.EpisodeType.SeasonSpecial then
				var_18_8 = Activity104Enum.JumpId.Discount
				var_18_9 = {
					defaultSelectLayer = var_18_2,
					directOpenLayer = var_18_2
				}
			end
		elseif var_18_4 == 1 then
			if not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonUTTU) or not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonDiscount) then
				if var_18_6 == DungeonEnum.EpisodeType.Season then
					if not var_18_7 then
						local var_18_11 = var_18_2 + 1

						if SeasonConfig.instance:getSeasonEpisodeCo(var_18_3, var_18_11) then
							var_18_8 = Activity104Enum.JumpId.Market
							var_18_9 = {
								tarLayer = var_18_11
							}
						end
					end
				elseif var_18_6 == DungeonEnum.EpisodeType.SeasonRetail then
					var_18_8 = Activity104Enum.JumpId.Retail
				elseif var_18_6 == DungeonEnum.EpisodeType.SeasonSpecial then
					var_18_8 = Activity104Enum.JumpId.Discount
					var_18_9 = {
						defaultSelectLayer = var_18_2
					}
				end
			end

			if var_18_10 and var_18_2 == 2 then
				var_18_8 = nil
				var_18_9 = nil
			end
		elseif var_18_6 == DungeonEnum.EpisodeType.SeasonSpecial then
			var_18_8 = Activity104Enum.JumpId.Discount
		end
	else
		logError(string.format("找不到对应关卡表,id:%s", var_18_0))
	end

	local var_18_12

	if var_18_8 == Activity104Enum.JumpId.Market then
		var_18_12 = Activity104Enum.ViewName.MarketView
	elseif var_18_8 == Activity104Enum.JumpId.Retail then
		var_18_12 = Activity104Enum.ViewName.RetailView
	elseif var_18_8 == Activity104Enum.JumpId.Discount then
		var_18_12 = Activity104Enum.ViewName.SpecialMarketView
	else
		var_18_12 = Activity104Enum.ViewName.MainView
	end

	local var_18_13 = SeasonViewHelper.getViewName(var_18_3, var_18_12, true)

	GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, var_18_13)
	Activity104Controller.instance:openSeasonMainView({
		levelUpStage = var_18_7,
		jumpId = var_18_8,
		jumpParam = var_18_9
	})
end

function var_0_0.enterFightAgain11600()
	local var_19_0 = DungeonModel.instance.curSendEpisodeId
	local var_19_1 = DungeonConfig.instance:getEpisodeCO(var_19_0)
	local var_19_2 = Activity104Model.instance:getCurSeasonId()
	local var_19_3 = Activity104Model.instance:getBattleFinishLayer()

	if var_19_1.type == DungeonEnum.EpisodeType.SeasonRetail then
		var_19_3 = 0

		return false
	end

	if FightController.instance:isReplayMode(var_19_0) and not var_19_3 then
		if var_19_1.type == DungeonEnum.EpisodeType.Season then
			local var_19_4 = SeasonConfig.instance:getSeasonEpisodeCos(var_19_2)

			for iter_19_0, iter_19_1 in pairs(var_19_4) do
				if iter_19_1.episodeId == var_19_0 then
					var_19_3 = iter_19_1.layer

					break
				end
			end
		elseif var_19_1.type == DungeonEnum.EpisodeType.SeasonRetail then
			var_19_3 = 0
		elseif var_19_1.type == DungeonEnum.EpisodeType.SeasonSpecial then
			local var_19_5 = SeasonConfig.instance:getSeasonSpecialCos(var_19_2)

			for iter_19_2, iter_19_3 in pairs(var_19_5) do
				if iter_19_3.episodeId == var_19_0 then
					var_19_3 = iter_19_3.layer

					break
				end
			end
		end

		Activity104Model.instance:setBattleFinishLayer(var_19_3)
	end

	GameSceneMgr.instance:closeScene(nil, nil, nil, true)
	Activity104Model.instance:enterAct104Battle(var_19_0, var_19_3)

	return true
end

function var_0_0.enterActivity11604(arg_20_0, arg_20_1)
	local var_20_0 = DungeonModel.instance.curSendEpisodeId
	local var_20_1, var_20_2 = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(var_20_0)

	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(arg_20_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.V1a4_BossRushMainView)
		VersionActivity1_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			BossRushController.instance:openMainView({
				isOpenLevelDetail = true,
				stage = var_20_1,
				layer = var_20_2
			})
		end, nil, VersionActivity1_6Enum.ActivityId.BossRush)
	end)
end

function var_0_0.activate()
	return
end

return var_0_0
