module("modules.logic.versionactivity1_3.common.EnterActivityViewOnExitFightSceneHelper1_3", package.seeall)

local var_0_0 = EnterActivityViewOnExitFightSceneHelper

function var_0_0.enterActivity11302(arg_1_0, arg_1_1)
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
		if not var_1_3 then
			return
		end

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_3DungeonMapLevelView)
		PermanentController.instance:jump2Activity(VersionActivity1_3Enum.ActivityId.EnterView)

		if var_1_3.chapterId == VersionActivity1_3DungeonEnum.DungeonChapterId.ElementFight then
			GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_3DungeonMapView)

			DungeonMapModel.instance.lastElementBattleId = var_1_1
			var_1_1 = DungeonConfig.instance:getActivityElementFightEpisodeToNormalEpisodeId(var_1_3, VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei)

			VersionActivity1_3DungeonController.instance:openVersionActivityDungeonMapView(nil, var_1_1)
		elseif var_1_3.chapterId == VersionActivity1_3DungeonEnum.DungeonChapterId.Daily then
			GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_3DungeonMapView)

			local var_2_0, var_2_1 = Activity126Model.instance:getRemainNum()

			if var_2_0 > 0 then
				DungeonMapModel.instance.lastElementBattleId = var_1_1
			end

			var_1_1 = VersionActivity1_3DungeonController.instance.dailyFromEpisodeId or VersionActivity1_3DungeonEnum.DailyEpisodeId

			VersionActivity1_3DungeonController.instance:openVersionActivityDungeonMapView(nil, var_1_1)
		elseif DungeonModel.instance.curSendEpisodePass then
			GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_3DungeonMapView)
			VersionActivity1_3DungeonController.instance:openVersionActivityDungeonMapView(nil, var_1_1)
		else
			GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_3DungeonMapLevelView)
			VersionActivity1_3DungeonController.instance:openVersionActivityDungeonMapView(var_1_0, var_1_1, function()
				ViewMgr.instance:openView(ViewName.VersionActivity1_3DungeonMapLevelView, {
					episodeId = var_1_1
				})
			end, nil, {
				needSelectFocusItem = true
			})
		end
	end)
end

function var_0_0.enterActivity11304(arg_4_0, arg_4_1)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(arg_4_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.Activity1_3ChessGameView)
		PermanentController.instance:jump2Activity(VersionActivity1_3Enum.ActivityId.EnterView)
		Activity1_3ChessController.instance:openMapView(nil, Va3ChessController.instance.openGameAfterFight, Va3ChessController.instance, arg_4_1)
	end)
end

function var_0_0.enterActivity11306(arg_6_0, arg_6_1)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(arg_6_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.JiaLaBoNaGameView)
		PermanentController.instance:jump2Activity(VersionActivity1_3Enum.ActivityId.EnterView)

		local var_7_0 = Activity120Model.instance:getCurEpisodeId()

		JiaLaBoNaController.instance:openMapView(var_7_0, Va3ChessController.instance.openGameAfterFight, Va3ChessController.instance, arg_6_1)
	end)
end

function var_0_0.enterActivity11307(arg_8_0, arg_8_1)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(arg_8_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.Activity1_3_119View)
		VersionActivity1_3EnterController.instance:directOpenVersionActivityEnterView()
		Activity1_3_119Controller.instance:openView()
	end)
end

function var_0_0.enterActivity11300(arg_10_0, arg_10_1)
	var_0_0.enterVersionActivityDungeonCommon(var_0_0._enterActivityDungeonAterFight11300, arg_10_0, arg_10_1)
end

function var_0_0.checkFightAfterStory11300(arg_11_0, arg_11_1, arg_11_2)
	if (var_0_0.recordMO and var_0_0.recordMO.fightResult) ~= 1 then
		return
	end

	local var_11_0 = DungeonModel.instance.curSendEpisodeId

	if not var_11_0 then
		return
	end

	local var_11_1 = DungeonConfig.instance:getEpisodeCO(var_11_0)

	if not var_11_1 or var_11_1.type ~= DungeonEnum.EpisodeType.Season then
		return
	end

	local var_11_2 = Activity104Model.instance:getBattleFinishLayer()
	local var_11_3 = Activity104Model.instance:getCurSeasonId()

	if Activity104Model.instance:isEpisodeAfterStory(var_11_3, var_11_2) then
		return
	end

	local var_11_4 = SeasonConfig.instance:getSeasonEpisodeCo(var_11_3, var_11_2)

	if not var_11_4 or var_11_4.afterStoryId == 0 then
		return
	end

	StoryController.instance:playStory(var_11_4.afterStoryId, nil, arg_11_0, arg_11_1, arg_11_2)

	return true
end

function var_0_0._enterActivityDungeonAterFight11300(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1.episodeId
	local var_12_1 = arg_12_1.exitFightGroup

	if not var_12_0 then
		return
	end

	VersionActivity1_3EnterController.instance:directOpenVersionActivityEnterView()

	local var_12_2 = Activity104Model.instance:getBattleFinishLayer()
	local var_12_3 = Activity104Model.instance:getCurSeasonId()
	local var_12_4 = var_0_0.recordMO and var_0_0.recordMO.fightResult
	local var_12_5 = DungeonConfig.instance:getEpisodeCO(var_12_0)
	local var_12_6 = var_12_5 and var_12_5.type
	local var_12_7 = Activity104Model.instance:canPlayStageLevelup(var_12_4, var_12_6, var_12_1, var_12_3, var_12_2)
	local var_12_8
	local var_12_9
	local var_12_10 = Activity104Model.instance:canMarkFightAfterStory(var_12_4, var_12_6, var_12_1, var_12_3, var_12_2)

	if var_12_10 then
		Activity104Rpc.instance:sendMarkEpisodeAfterStoryRequest(var_12_3, var_12_2)
	end

	if var_12_5 then
		if not var_12_4 or var_12_4 == -1 or var_12_4 == 0 then
			if var_12_6 == DungeonEnum.EpisodeType.Season then
				var_12_8 = Activity104Enum.JumpId.Market
				var_12_9 = {
					tarLayer = var_12_2
				}
			elseif var_12_6 == DungeonEnum.EpisodeType.SeasonRetail then
				var_12_8 = Activity104Enum.JumpId.Retail
			elseif var_12_6 == DungeonEnum.EpisodeType.SeasonSpecial then
				var_12_8 = Activity104Enum.JumpId.Discount
				var_12_9 = {
					defaultSelectLayer = var_12_2,
					directOpenLayer = var_12_2
				}
			end
		elseif var_12_4 == 1 then
			if not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonUTTU) or not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonDiscount) then
				if var_12_6 == DungeonEnum.EpisodeType.Season then
					if not var_12_7 then
						local var_12_11 = var_12_2 + 1

						if SeasonConfig.instance:getSeasonEpisodeCo(var_12_3, var_12_11) then
							var_12_8 = Activity104Enum.JumpId.Market
							var_12_9 = {
								tarLayer = var_12_11
							}
						end
					end
				elseif var_12_6 == DungeonEnum.EpisodeType.SeasonRetail then
					var_12_8 = Activity104Enum.JumpId.Retail
				elseif var_12_6 == DungeonEnum.EpisodeType.SeasonSpecial then
					var_12_8 = Activity104Enum.JumpId.Discount
					var_12_9 = {
						defaultSelectLayer = var_12_2
					}
				end
			end

			if var_12_10 and var_12_2 == 2 then
				var_12_8 = nil
				var_12_9 = nil
			end
		elseif var_12_6 == DungeonEnum.EpisodeType.SeasonSpecial then
			var_12_8 = Activity104Enum.JumpId.Discount
		end
	else
		logError(string.format("找不到对应关卡表,id:%s", var_12_0))
	end

	Activity104Controller.instance:openSeasonMainView({
		levelUpStage = var_12_7,
		jumpId = var_12_8,
		jumpParam = var_12_9
	})
end

function var_0_0.enterFightAgain11300()
	local var_13_0 = DungeonModel.instance.curSendEpisodeId
	local var_13_1 = DungeonConfig.instance:getEpisodeCO(var_13_0)
	local var_13_2 = Activity104Model.instance:getCurSeasonId()
	local var_13_3 = Activity104Model.instance:getBattleFinishLayer()

	if var_13_1.type == DungeonEnum.EpisodeType.SeasonRetail then
		var_13_3 = 0

		return false
	end

	if FightController.instance:isReplayMode(var_13_0) and not var_13_3 then
		if var_13_1.type == DungeonEnum.EpisodeType.Season then
			local var_13_4 = SeasonConfig.instance:getSeasonEpisodeCos(var_13_2)

			for iter_13_0, iter_13_1 in pairs(var_13_4) do
				if iter_13_1.episodeId == var_13_0 then
					var_13_3 = iter_13_1.layer

					break
				end
			end
		elseif var_13_1.type == DungeonEnum.EpisodeType.SeasonRetail then
			var_13_3 = 0
		elseif var_13_1.type == DungeonEnum.EpisodeType.SeasonSpecial then
			local var_13_5 = SeasonConfig.instance:getSeasonSpecialCos(var_13_2)

			for iter_13_2, iter_13_3 in pairs(var_13_5) do
				if iter_13_3.episodeId == var_13_0 then
					var_13_3 = iter_13_3.layer

					break
				end
			end
		end

		Activity104Model.instance:setBattleFinishLayer(var_13_3)
	end

	Activity104Rpc.instance:sendBeforeStartAct104BattleRequest(var_13_2, var_13_3, var_13_0, var_0_0.enterFightAgain11300RpcCallback, nil)

	return true
end

function var_0_0.enterFightAgain11300RpcCallback(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1 ~= 0 then
		MainController.instance:enterMainScene(true)
	else
		var_0_0.enterFightAgain()
	end
end

function var_0_0.activate()
	return
end

return var_0_0
