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
	GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_6EnterView)
	PermanentController.instance:jump2Activity(VersionActivity1_6Enum.ActivityId.EnterView)
	ActQuNiangController.instance:openLevelView({
		needShowFight = true
	})
end

function var_0_0.enterActivity11606(arg_3_0, arg_3_1)
	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(arg_3_0)
	GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_6EnterView)
	PermanentController.instance:jump2Activity(VersionActivity1_6Enum.ActivityId.EnterView)
	ActGeTianController.instance:openLevelView({
		needShowFight = true
	})
end

function var_0_0.enterActivity11602(arg_4_0, arg_4_1)
	var_0_0.enterVersionActivityDungeonCommon(var_0_0._enterActivity11602, arg_4_0, arg_4_1)
end

function var_0_0._enterActivity11602(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1.episodeId
	local var_5_1 = arg_5_1.episodeCo

	if var_0_0.sequence then
		var_0_0.sequence:destroy()

		var_0_0.sequence = nil
	end

	local var_5_2 = false

	if DungeonModel.instance.curSendEpisodePass then
		var_5_2 = false

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_6DungeonMapView)
	else
		var_5_2 = true

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_6DungeonMapLevelView)
	end

	local var_5_3 = FlowSequence.New()
	local var_5_4 = ViewName.VersionActivity1_6EnterView
	local var_5_5 = VersionActivity1_6EnterController

	var_5_3:addWork(OpenViewWork.New({
		openFunction = var_0_0._openEnterView,
		openFunctionObj = var_5_5.instance,
		waitOpenViewName = var_5_4
	}))
	var_5_3:registerDoneListener(function()
		if var_5_2 then
			VersionActivity1_6DungeonController.instance:openVersionActivityDungeonMapView(nil, var_5_0, function()
				ViewMgr.instance:openView(ViewName.VersionActivity1_6DungeonMapLevelView, {
					episodeId = var_5_0
				})
			end, nil)
		else
			VersionActivity1_6DungeonController.instance:openVersionActivityDungeonMapView(nil, var_5_0)
		end
	end)
	var_5_3:start()

	var_0_0.sequence = var_5_3
end

function var_0_0._openEnterView()
	PermanentController.instance:jump2Activity(VersionActivity1_6Enum.ActivityId.EnterView)
end

function var_0_0.enterActivity11609(arg_9_0, arg_9_1)
	local var_9_0 = DungeonModel.instance.curSendEpisodeId

	DungeonModel.instance.lastSendEpisodeId = var_9_0
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(arg_9_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_6DungeonBossView)
		PermanentController.instance:jump2Activity(VersionActivity1_6Enum.ActivityId.EnterView)
		VersionActivity1_6DungeonController.instance:openVersionActivityDungeonMapView(nil, VersionActivity1_6DungeonEnum.DungeonBossEpisodeId, function()
			VersionActivity1_6DungeonController.instance:openDungeonBossView(true)
		end, nil)
	end)
end

function var_0_0.enterActivity11600(arg_12_0, arg_12_1)
	var_0_0.enterVersionActivityDungeonCommon(var_0_0._enterActivityDungeonAterFight11600, arg_12_0, arg_12_1)
end

function var_0_0.checkFightAfterStory11600(arg_13_0, arg_13_1, arg_13_2)
	if (var_0_0.recordMO and var_0_0.recordMO.fightResult) ~= 1 then
		return
	end

	local var_13_0 = DungeonModel.instance.curSendEpisodeId

	if not var_13_0 then
		return
	end

	local var_13_1 = DungeonConfig.instance:getEpisodeCO(var_13_0)

	if not var_13_1 or var_13_1.type ~= DungeonEnum.EpisodeType.Season then
		return
	end

	local var_13_2 = Activity104Model.instance:getBattleFinishLayer()
	local var_13_3 = Activity104Model.instance:getCurSeasonId()

	if Activity104Model.instance:isEpisodeAfterStory(var_13_3, var_13_2) then
		return
	end

	local var_13_4 = SeasonConfig.instance:getSeasonEpisodeCo(var_13_3, var_13_2)

	if not var_13_4 or var_13_4.afterStoryId == 0 then
		return
	end

	StoryController.instance:playStory(var_13_4.afterStoryId, nil, arg_13_0, arg_13_1, arg_13_2)

	return true
end

function var_0_0._enterActivityDungeonAterFight11600(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1.episodeId
	local var_14_1 = arg_14_1.exitFightGroup

	if not var_14_0 then
		return
	end

	local var_14_2 = Activity104Model.instance:getBattleFinishLayer()
	local var_14_3 = Activity104Model.instance:getCurSeasonId()

	VersionActivity1_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, var_14_3)

	local var_14_4 = var_0_0.recordMO and var_0_0.recordMO.fightResult
	local var_14_5 = DungeonConfig.instance:getEpisodeCO(var_14_0)
	local var_14_6 = var_14_5 and var_14_5.type
	local var_14_7 = Activity104Model.instance:canPlayStageLevelup(var_14_4, var_14_6, var_14_1, var_14_3, var_14_2)
	local var_14_8
	local var_14_9
	local var_14_10 = Activity104Model.instance:canMarkFightAfterStory(var_14_4, var_14_6, var_14_1, var_14_3, var_14_2)

	if var_14_10 then
		Activity104Rpc.instance:sendMarkEpisodeAfterStoryRequest(var_14_3, var_14_2)
	end

	if var_14_5 then
		if not var_14_4 or var_14_4 == -1 or var_14_4 == 0 then
			if var_14_6 == DungeonEnum.EpisodeType.Season then
				var_14_8 = Activity104Enum.JumpId.Market
				var_14_9 = {
					tarLayer = var_14_2
				}
			elseif var_14_6 == DungeonEnum.EpisodeType.SeasonRetail then
				var_14_8 = Activity104Enum.JumpId.Retail
			elseif var_14_6 == DungeonEnum.EpisodeType.SeasonSpecial then
				var_14_8 = Activity104Enum.JumpId.Discount
				var_14_9 = {
					defaultSelectLayer = var_14_2,
					directOpenLayer = var_14_2
				}
			end
		elseif var_14_4 == 1 then
			if not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonUTTU) or not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonDiscount) then
				if var_14_6 == DungeonEnum.EpisodeType.Season then
					if not var_14_7 then
						local var_14_11 = var_14_2 + 1

						if SeasonConfig.instance:getSeasonEpisodeCo(var_14_3, var_14_11) then
							var_14_8 = Activity104Enum.JumpId.Market
							var_14_9 = {
								tarLayer = var_14_11
							}
						end
					end
				elseif var_14_6 == DungeonEnum.EpisodeType.SeasonRetail then
					var_14_8 = Activity104Enum.JumpId.Retail
				elseif var_14_6 == DungeonEnum.EpisodeType.SeasonSpecial then
					var_14_8 = Activity104Enum.JumpId.Discount
					var_14_9 = {
						defaultSelectLayer = var_14_2
					}
				end
			end

			if var_14_10 and var_14_2 == 2 then
				var_14_8 = nil
				var_14_9 = nil
			end
		elseif var_14_6 == DungeonEnum.EpisodeType.SeasonSpecial then
			var_14_8 = Activity104Enum.JumpId.Discount
		end
	else
		logError(string.format("找不到对应关卡表,id:%s", var_14_0))
	end

	local var_14_12

	if var_14_8 == Activity104Enum.JumpId.Market then
		var_14_12 = Activity104Enum.ViewName.MarketView
	elseif var_14_8 == Activity104Enum.JumpId.Retail then
		var_14_12 = Activity104Enum.ViewName.RetailView
	elseif var_14_8 == Activity104Enum.JumpId.Discount then
		var_14_12 = Activity104Enum.ViewName.SpecialMarketView
	else
		var_14_12 = Activity104Enum.ViewName.MainView
	end

	local var_14_13 = SeasonViewHelper.getViewName(var_14_3, var_14_12, true)

	GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, var_14_13)
	Activity104Controller.instance:openSeasonMainView({
		levelUpStage = var_14_7,
		jumpId = var_14_8,
		jumpParam = var_14_9
	})
end

function var_0_0.enterFightAgain11600()
	local var_15_0 = DungeonModel.instance.curSendEpisodeId
	local var_15_1 = DungeonConfig.instance:getEpisodeCO(var_15_0)
	local var_15_2 = Activity104Model.instance:getCurSeasonId()
	local var_15_3 = Activity104Model.instance:getBattleFinishLayer()

	if var_15_1.type == DungeonEnum.EpisodeType.SeasonRetail then
		var_15_3 = 0

		return false
	end

	if FightController.instance:isReplayMode(var_15_0) and not var_15_3 then
		if var_15_1.type == DungeonEnum.EpisodeType.Season then
			local var_15_4 = SeasonConfig.instance:getSeasonEpisodeCos(var_15_2)

			for iter_15_0, iter_15_1 in pairs(var_15_4) do
				if iter_15_1.episodeId == var_15_0 then
					var_15_3 = iter_15_1.layer

					break
				end
			end
		elseif var_15_1.type == DungeonEnum.EpisodeType.SeasonRetail then
			var_15_3 = 0
		elseif var_15_1.type == DungeonEnum.EpisodeType.SeasonSpecial then
			local var_15_5 = SeasonConfig.instance:getSeasonSpecialCos(var_15_2)

			for iter_15_2, iter_15_3 in pairs(var_15_5) do
				if iter_15_3.episodeId == var_15_0 then
					var_15_3 = iter_15_3.layer

					break
				end
			end
		end

		Activity104Model.instance:setBattleFinishLayer(var_15_3)
	end

	GameSceneMgr.instance:closeScene(nil, nil, nil, true)
	Activity104Model.instance:enterAct104Battle(var_15_0, var_15_3)

	return true
end

function var_0_0.enterActivity11604(arg_16_0, arg_16_1)
	local var_16_0 = DungeonModel.instance.curSendEpisodeId
	local var_16_1, var_16_2 = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(var_16_0)

	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(arg_16_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.V1a4_BossRushMainView)
		VersionActivity1_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			BossRushController.instance:openMainView({
				isOpenLevelDetail = true,
				stage = var_16_1,
				layer = var_16_2
			})
		end, nil, VersionActivity1_6Enum.ActivityId.BossRush)
	end)
end

function var_0_0.activate()
	return
end

return var_0_0
