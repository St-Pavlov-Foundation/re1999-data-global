module("modules.logic.versionactivity1_4.common.EnterActivityViewOnExitFightSceneHelper1_4", package.seeall)

local var_0_0 = EnterActivityViewOnExitFightSceneHelper

function var_0_0.enterActivity11407(arg_1_0, arg_1_1)
	var_0_0.enterVersionActivityDungeonCommon(var_0_0._enterActivityDungeonAterFight11407, arg_1_0, arg_1_1)
end

function var_0_0._enterActivityDungeonAterFight11407(arg_2_0, arg_2_1)
	VersionActivity1_4EnterController.instance:directOpenVersionActivityEnterView()
	ViewMgr.instance:openView(ViewName.VersionActivity1_4DungeonView, {
		actId = 11407
	})
end

function var_0_0.enterActivity11400(arg_3_0, arg_3_1)
	var_0_0.enterVersionActivityDungeonCommon(var_0_0._enterActivityDungeonAterFight11400, arg_3_0, arg_3_1)
end

function var_0_0.enterActivity11414(arg_4_0, arg_4_1)
	local var_4_0 = DungeonModel.instance.curSendEpisodeId
	local var_4_1, var_4_2 = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(var_4_0)

	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(arg_4_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.V1a4_BossRushMainView)
		VersionActivity1_4EnterController.instance:openVersionActivityEnterViewIfNotOpened()
		BossRushController.instance:openMainView({
			isOpenLevelDetail = true,
			stage = var_4_1,
			layer = var_4_2
		})
	end)
end

function var_0_0.checkFightAfterStory11400(arg_6_0, arg_6_1, arg_6_2)
	if (var_0_0.recordMO and var_0_0.recordMO.fightResult) ~= 1 then
		return
	end

	local var_6_0 = DungeonModel.instance.curSendEpisodeId

	if not var_6_0 then
		return
	end

	local var_6_1 = DungeonConfig.instance:getEpisodeCO(var_6_0)

	if not var_6_1 or var_6_1.type ~= DungeonEnum.EpisodeType.Season then
		return
	end

	local var_6_2 = Activity104Model.instance:getBattleFinishLayer()
	local var_6_3 = Activity104Model.instance:getCurSeasonId()

	if Activity104Model.instance:isEpisodeAfterStory(var_6_3, var_6_2) then
		return
	end

	local var_6_4 = SeasonConfig.instance:getSeasonEpisodeCo(var_6_3, var_6_2)

	if not var_6_4 or var_6_4.afterStoryId == 0 then
		return
	end

	StoryController.instance:playStory(var_6_4.afterStoryId, nil, arg_6_0, arg_6_1, arg_6_2)

	return true
end

function var_0_0._enterActivityDungeonAterFight11400(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1.episodeId
	local var_7_1 = arg_7_1.exitFightGroup

	if not var_7_0 then
		return
	end

	VersionActivity1_4EnterController.instance:directOpenVersionActivityEnterView()

	local var_7_2 = Activity104Model.instance:getBattleFinishLayer()
	local var_7_3 = Activity104Model.instance:getCurSeasonId()
	local var_7_4 = var_0_0.recordMO and var_0_0.recordMO.fightResult
	local var_7_5 = DungeonConfig.instance:getEpisodeCO(var_7_0)
	local var_7_6 = var_7_5 and var_7_5.type
	local var_7_7 = Activity104Model.instance:canPlayStageLevelup(var_7_4, var_7_6, var_7_1, var_7_3, var_7_2)
	local var_7_8
	local var_7_9
	local var_7_10 = Activity104Model.instance:canMarkFightAfterStory(var_7_4, var_7_6, var_7_1, var_7_3, var_7_2)

	if var_7_10 then
		Activity104Rpc.instance:sendMarkEpisodeAfterStoryRequest(var_7_3, var_7_2)
	end

	if var_7_5 then
		if not var_7_4 or var_7_4 == -1 or var_7_4 == 0 then
			if var_7_6 == DungeonEnum.EpisodeType.Season then
				var_7_8 = Activity104Enum.JumpId.Market
				var_7_9 = {
					tarLayer = var_7_2
				}
			elseif var_7_6 == DungeonEnum.EpisodeType.SeasonRetail then
				var_7_8 = Activity104Enum.JumpId.Retail
			elseif var_7_6 == DungeonEnum.EpisodeType.SeasonSpecial then
				var_7_8 = Activity104Enum.JumpId.Discount
				var_7_9 = {
					defaultSelectLayer = var_7_2,
					directOpenLayer = var_7_2
				}
			end
		elseif var_7_4 == 1 then
			if not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonUTTU) or not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonDiscount) then
				if var_7_6 == DungeonEnum.EpisodeType.Season then
					if not var_7_7 then
						local var_7_11 = var_7_2 + 1

						if SeasonConfig.instance:getSeasonEpisodeCo(var_7_3, var_7_11) then
							var_7_8 = Activity104Enum.JumpId.Market
							var_7_9 = {
								tarLayer = var_7_11
							}
						end
					end
				elseif var_7_6 == DungeonEnum.EpisodeType.SeasonRetail then
					var_7_8 = Activity104Enum.JumpId.Retail
				elseif var_7_6 == DungeonEnum.EpisodeType.SeasonSpecial then
					var_7_8 = Activity104Enum.JumpId.Discount
					var_7_9 = {
						defaultSelectLayer = var_7_2
					}
				end
			end

			if var_7_10 and var_7_2 == 2 then
				var_7_8 = nil
				var_7_9 = nil
			end
		elseif var_7_6 == DungeonEnum.EpisodeType.SeasonSpecial then
			var_7_8 = Activity104Enum.JumpId.Discount
		end
	else
		logError(string.format("找不到对应关卡表,id:%s", var_7_0))
	end

	local var_7_12

	if var_7_8 == Activity104Enum.JumpId.Market then
		var_7_12 = Activity104Enum.ViewName.MarketView
	elseif var_7_8 == Activity104Enum.JumpId.Retail then
		var_7_12 = Activity104Enum.ViewName.RetailView
	elseif var_7_8 == Activity104Enum.JumpId.Discount then
		var_7_12 = Activity104Enum.ViewName.SpecialMarketView
	else
		var_7_12 = Activity104Enum.ViewName.MainView
	end

	local var_7_13 = SeasonViewHelper.getViewName(var_7_3, var_7_12, true)

	GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, var_7_13)
	Activity104Controller.instance:openSeasonMainView({
		levelUpStage = var_7_7,
		jumpId = var_7_8,
		jumpParam = var_7_9
	})
end

function var_0_0.enterFightAgain11400()
	local var_8_0 = DungeonModel.instance.curSendEpisodeId
	local var_8_1 = DungeonConfig.instance:getEpisodeCO(var_8_0)
	local var_8_2 = Activity104Model.instance:getCurSeasonId()
	local var_8_3 = Activity104Model.instance:getBattleFinishLayer()

	if var_8_1.type == DungeonEnum.EpisodeType.SeasonRetail then
		var_8_3 = 0

		return false
	end

	if FightController.instance:isReplayMode(var_8_0) and not var_8_3 then
		if var_8_1.type == DungeonEnum.EpisodeType.Season then
			local var_8_4 = SeasonConfig.instance:getSeasonEpisodeCos(var_8_2)

			for iter_8_0, iter_8_1 in pairs(var_8_4) do
				if iter_8_1.episodeId == var_8_0 then
					var_8_3 = iter_8_1.layer

					break
				end
			end
		elseif var_8_1.type == DungeonEnum.EpisodeType.SeasonRetail then
			var_8_3 = 0
		elseif var_8_1.type == DungeonEnum.EpisodeType.SeasonSpecial then
			local var_8_5 = SeasonConfig.instance:getSeasonSpecialCos(var_8_2)

			for iter_8_2, iter_8_3 in pairs(var_8_5) do
				if iter_8_3.episodeId == var_8_0 then
					var_8_3 = iter_8_3.layer

					break
				end
			end
		end

		Activity104Model.instance:setBattleFinishLayer(var_8_3)
	end

	Activity104Rpc.instance:sendBeforeStartAct104BattleRequest(var_8_2, var_8_3, var_8_0, var_0_0.enterFightAgain11400RpcCallback, nil)

	return true
end

function var_0_0.enterFightAgain11400RpcCallback(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 ~= 0 then
		MainController.instance:enterMainScene(true)
	else
		var_0_0.enterFightAgain()
	end
end

function var_0_0.enterActivity11403(arg_10_0, arg_10_1)
	var_0_0.enterVersionActivityDungeonCommon(var_0_0._enterActivityDungeonAterFight11403, arg_10_0, arg_10_1)
end

function var_0_0._enterActivityDungeonAterFight11403(arg_11_0, arg_11_1)
	PermanentController.instance:jump2Activity(VersionActivity1_4Enum.ActivityId.EnterView)

	local var_11_0 = Activity131Model.instance:getCurEpisodeId()

	Activity131Controller.instance:openActivity131LevelView({
		exitFromBattle = true,
		episodeId = var_11_0
	})
	Activity131Controller.instance:openActivity131GameView({
		exitFromBattle = true
	})
end

function var_0_0.activate()
	return
end

return var_0_0
