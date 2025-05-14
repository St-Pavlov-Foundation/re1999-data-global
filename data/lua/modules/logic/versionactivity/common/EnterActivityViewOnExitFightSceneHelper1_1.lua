module("modules.logic.versionactivity.common.EnterActivityViewOnExitFightSceneHelper1_1", package.seeall)

local var_0_0 = EnterActivityViewOnExitFightSceneHelper

function var_0_0.enterActivity11104(arg_1_0, arg_1_1)
	local var_1_0 = DungeonModel.instance.curSendChapterId
	local var_1_1 = DungeonModel.instance.curSendEpisodeId
	local var_1_2 = FightController.instance:isReplayMode(var_1_1)
	local var_1_3 = DungeonConfig.instance:getEpisodeCO(var_1_1)

	if not arg_1_1 and var_1_2 then
		local var_1_4 = JumpModel.instance:getRecordFarmItem()

		if FightSuccView.checkRecordFarmItem(var_1_1, var_1_4) then
			if not (ItemModel.instance:getItemQuantity(var_1_4.type, var_1_4.id) >= var_1_4.quantity) then
				GameSceneMgr.instance:closeScene(nil, nil, nil, true)
				DungeonFightController.instance:enterFight(var_1_3.chapterId, var_1_1, DungeonModel.instance.curSelectTicketId)

				return
			end
		else
			GameSceneMgr.instance:closeScene(nil, nil, nil, true)
			DungeonFightController.instance:enterFight(var_1_3.chapterId, var_1_1, DungeonModel.instance.curSelectTicketId)

			return
		end
	end

	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(arg_1_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivityDungeonMapLevelView)
		PermanentController.instance:jump2Activity(VersionActivityEnum.ActivityId.Act105)

		if var_1_3.chapterId == VersionActivityEnum.DungeonChapterId.ElementFight then
			GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivityDungeonMapView)

			DungeonMapModel.instance.lastElementBattleId = var_1_1
			var_1_1 = DungeonConfig.instance:getElementFightEpisodeToNormalEpisodeId(var_1_3)

			VersionActivityDungeonController.instance:openVersionActivityDungeonMapView(nil, var_1_1)
		elseif DungeonModel.instance.curSendEpisodePass then
			GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivityDungeonMapView)
			VersionActivityDungeonController.instance:openVersionActivityDungeonMapView(nil, var_1_1)
		else
			GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivityDungeonMapLevelView)
			VersionActivityDungeonController.instance:openVersionActivityDungeonMapView(var_1_0, var_1_1, function()
				ViewMgr.instance:openView(ViewName.VersionActivityDungeonMapLevelView, {
					episodeId = var_1_1
				})
			end)
		end
	end)
end

function var_0_0.enterActivity11103(arg_4_0, arg_4_1)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(arg_4_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivityEnterView)
		VersionActivityController.instance:directOpenVersionActivityEnterView()
		Activity109ChessController.instance:openGameAfterFight(arg_4_1)
	end)
end

function var_0_0.enterActivity11100(arg_6_0, arg_6_1)
	var_0_0.enterVersionActivityDungeonCommon(var_0_0._enterActivityDungeonAterFight11100, arg_6_0, arg_6_1)
end

function var_0_0.checkFightAfterStory11100(arg_7_0, arg_7_1, arg_7_2)
	if (var_0_0.recordMO and var_0_0.recordMO.fightResult) ~= 1 then
		return
	end

	local var_7_0 = DungeonModel.instance.curSendEpisodeId
	local var_7_1 = DungeonConfig.instance:getEpisodeCO(var_7_0)

	if not var_7_1 or var_7_1.type ~= DungeonEnum.EpisodeType.Season then
		return
	end

	local var_7_2 = Activity104Model.instance.battleFinishLayer

	if Activity104Model.instance:isEpisodeAfterStory(Activity104Enum.SeasonType.Season1, var_7_2) then
		return
	end

	local var_7_3 = SeasonConfig.instance:getSeasonEpisodeCo(Activity104Enum.SeasonType.Season1, var_7_2)

	if not var_7_3 or var_7_3.afterStoryId == 0 then
		return
	end

	StoryController.instance:playStory(var_7_3.afterStoryId, nil, arg_7_0, arg_7_1, arg_7_2)

	return true
end

function var_0_0._enterActivityDungeonAterFight11100(arg_8_0, arg_8_1)
	VersionActivityController.instance:directOpenVersionActivityEnterView()

	local var_8_0 = Activity104Model.instance.battleFinishLayer
	local var_8_1 = Activity104Enum.SeasonType.Season1
	local var_8_2 = var_0_0.recordMO and var_0_0.recordMO.fightResult
	local var_8_3 = arg_8_1.episodeId
	local var_8_4 = arg_8_1.exitFightGroup
	local var_8_5 = DungeonConfig.instance:getEpisodeCO(var_8_3)
	local var_8_6 = var_8_5 and var_8_5.type
	local var_8_7 = Activity104Model.instance:canPlayStageLevelup(var_8_2, var_8_6, var_8_4, var_8_1, var_8_0)

	Activity104Controller.instance:openSeasonMainView({
		levelUpStage = var_8_7
	})

	if Activity104Model.instance:canMarkFightAfterStory(var_8_2, var_8_6, var_8_4, var_8_1, var_8_0) then
		Activity104Rpc.instance:sendMarkEpisodeAfterStoryRequest(var_8_1, var_8_0)
	end

	if not var_8_5 then
		logError("找不到对应关卡表,id:" .. var_8_3)

		return
	end

	if not var_8_2 or var_8_2 == -1 or var_8_2 == 0 then
		if var_8_6 == DungeonEnum.EpisodeType.Season then
			Activity104Controller.instance:openSeasonMarketView({
				tarLayer = var_8_0
			})

			return
		elseif var_8_6 == DungeonEnum.EpisodeType.SeasonRetail then
			Activity104Controller.instance:openSeasonRetailView({})

			return
		elseif var_8_6 == DungeonEnum.EpisodeType.SeasonSpecial then
			Activity104Controller.instance:openSeasonSpecialMarketView({
				defaultSelectLayer = var_8_0,
				directOpenLayer = var_8_0
			})

			return
		end
	end

	if var_8_2 == 1 then
		if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonUTTU) then
			return
		end

		if var_8_6 == DungeonEnum.EpisodeType.Season then
			if var_8_7 then
				return
			end

			local var_8_8 = var_8_0 + 1

			if not SeasonConfig.instance:getSeasonEpisodeCo(Activity104Enum.SeasonType.Season1, var_8_8) then
				return
			end

			Activity104Controller.instance:openSeasonMarketView({
				tarLayer = var_8_8
			})

			return
		end

		if var_8_6 == DungeonEnum.EpisodeType.SeasonRetail then
			Activity104Controller.instance:openSeasonRetailView({})

			return
		end

		if var_8_6 == DungeonEnum.EpisodeType.SeasonSpecial then
			Activity104Controller.instance:openSeasonSpecialMarketView({
				defaultSelectLayer = var_8_0
			})

			return
		end
	end

	if var_8_6 == DungeonEnum.EpisodeType.SeasonSpecial then
		Activity104Controller.instance:openSeasonSpecialMarketView()
	end
end

function var_0_0.enterFightAgain11100()
	local var_9_0 = DungeonModel.instance.curSendEpisodeId
	local var_9_1 = DungeonConfig.instance:getEpisodeCO(var_9_0)
	local var_9_2 = Activity104Enum.SeasonType.Season1
	local var_9_3 = Activity104Model.instance.battleFinishLayer

	if var_9_1.type == DungeonEnum.EpisodeType.SeasonRetail then
		var_9_3 = 0

		return false
	end

	Activity104Rpc.instance:sendBeforeStartAct104BattleRequest(var_9_2, var_9_3, var_9_0, var_0_0.enterFightAgain11100RpcCallback, nil)

	return true
end

function var_0_0.enterFightAgain11100RpcCallback(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 ~= 0 then
		MainController.instance:enterMainScene(true)
	else
		var_0_0.enterFightAgain()
	end
end

function var_0_0.activate()
	return
end

return var_0_0
