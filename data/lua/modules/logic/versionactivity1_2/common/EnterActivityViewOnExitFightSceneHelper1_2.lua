module("modules.logic.versionactivity1_2.common.EnterActivityViewOnExitFightSceneHelper1_2", package.seeall)

local var_0_0 = EnterActivityViewOnExitFightSceneHelper

function var_0_0.activate()
	return
end

function var_0_0.enterFightAgain11208()
	local var_2_0 = DungeonModel.instance.curSendEpisodeId
	local var_2_1 = DungeonConfig.instance:getEpisodeCO(var_2_0)

	if FightController.instance:isReplayMode(var_2_0) then
		if VersionActivity1_2DungeonModel.instance.newSp and tabletool.len(VersionActivity1_2DungeonModel.instance.newSp) > 0 then
			VersionActivity1_2DungeonModel.instance.newSp = nil

			return false
		else
			var_0_0.enterFightAgain()
		end
	else
		var_0_0.enterFightAgain()
	end

	return true
end

function var_0_0.enterActivity11208(arg_3_0, arg_3_1)
	var_0_0.enterVersionActivityDungeonCommon(var_0_0._enterActivityDungeonAterFight11208, arg_3_0, arg_3_1)
end

function var_0_0._enterActivityDungeonAterFight11208(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1.episodeId
	local var_4_1 = DungeonConfig.instance:getEpisodeCO(var_4_0)

	if not var_4_1 then
		return
	end

	GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_2DungeonView)
	PermanentController.instance:jump2Activity(VersionActivity1_2Enum.ActivityId.EnterView)

	if var_4_1.chapterId == 12701 or var_4_1.chapterId == 12102 then
		VersionActivity1_2DungeonController.instance:openDungeonView()
	else
		VersionActivity1_2DungeonController.instance:openDungeonView(var_4_1.chapterId, var_4_0)
	end
end

function var_0_0.enterActivity11203(arg_5_0, arg_5_1)
	DungeonModel.instance.versionActivityChapterType = nil
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(arg_5_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.YaXianMapView)
		PermanentController.instance:jump2Activity(VersionActivity1_2Enum.ActivityId.EnterView)
		Activity115Rpc.instance:sendGetAct115InfoRequest(YaXianEnum.ActivityId, function()
			local var_7_0 = YaXianModel.instance:getCurrentMapInfo()
			local var_7_1 = var_7_0 and var_7_0.episodeCo.chapterId

			ViewMgr.instance:openView(ViewName.YaXianMapView, {
				chapterId = var_7_1
			})
			YaXianDungeonController.instance:openGameAfterFight()
		end)
	end)
end

function var_0_0.enterActivity11200(arg_8_0, arg_8_1)
	var_0_0.enterVersionActivityDungeonCommon(var_0_0._enterActivityDungeonAterFight11200, arg_8_0, arg_8_1)
end

function var_0_0.checkFightAfterStory11200(arg_9_0, arg_9_1, arg_9_2)
	if (var_0_0.recordMO and var_0_0.recordMO.fightResult) ~= 1 then
		return
	end

	local var_9_0 = DungeonModel.instance.curSendEpisodeId

	if not var_9_0 then
		return
	end

	local var_9_1 = DungeonConfig.instance:getEpisodeCO(var_9_0)

	if not var_9_1 or var_9_1.type ~= DungeonEnum.EpisodeType.Season then
		return
	end

	local var_9_2 = Activity104Model.instance:getBattleFinishLayer()
	local var_9_3 = Activity104Enum.SeasonType.Season2

	if Activity104Model.instance:isEpisodeAfterStory(var_9_3, var_9_2) then
		return
	end

	local var_9_4 = SeasonConfig.instance:getSeasonEpisodeCo(var_9_3, var_9_2)

	if not var_9_4 or var_9_4.afterStoryId == 0 then
		return
	end

	StoryController.instance:playStory(var_9_4.afterStoryId, nil, arg_9_0, arg_9_1, arg_9_2)

	return true
end

function var_0_0._enterActivityDungeonAterFight11200(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1.episodeId
	local var_10_1 = arg_10_1.exitFightGroup

	if not var_10_0 then
		return
	end

	VersionActivity1_2EnterController.instance:directOpenVersionActivity1_2EnterView()

	local var_10_2 = Activity104Model.instance:getBattleFinishLayer()
	local var_10_3 = Activity104Enum.SeasonType.Season2
	local var_10_4 = var_0_0.recordMO and var_0_0.recordMO.fightResult
	local var_10_5 = DungeonConfig.instance:getEpisodeCO(var_10_0)
	local var_10_6 = var_10_5 and var_10_5.type
	local var_10_7 = Activity104Model.instance:canPlayStageLevelup(var_10_4, var_10_6, var_10_1, var_10_3, var_10_2)
	local var_10_8
	local var_10_9
	local var_10_10 = Activity104Model.instance:canMarkFightAfterStory(var_10_4, var_10_6, var_10_1, var_10_3, var_10_2)

	if var_10_10 then
		Activity104Rpc.instance:sendMarkEpisodeAfterStoryRequest(var_10_3, var_10_2)
	end

	if var_10_5 then
		if not var_10_4 or var_10_4 == -1 or var_10_4 == 0 then
			if var_10_6 == DungeonEnum.EpisodeType.Season then
				var_10_8 = Activity104Enum.JumpId.Market
				var_10_9 = {
					tarLayer = var_10_2
				}
			elseif var_10_6 == DungeonEnum.EpisodeType.SeasonRetail then
				var_10_8 = Activity104Enum.JumpId.Retail
			elseif var_10_6 == DungeonEnum.EpisodeType.SeasonSpecial then
				var_10_8 = Activity104Enum.JumpId.Discount
				var_10_9 = {
					defaultSelectLayer = var_10_2,
					directOpenLayer = var_10_2
				}
			end
		elseif var_10_4 == 1 then
			if not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonUTTU) or not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonDiscount) then
				if var_10_6 == DungeonEnum.EpisodeType.Season then
					if not var_10_7 then
						local var_10_11 = var_10_2 + 1

						if SeasonConfig.instance:getSeasonEpisodeCo(Activity104Enum.SeasonType.Season2, var_10_11) then
							var_10_8 = Activity104Enum.JumpId.Market
							var_10_9 = {
								tarLayer = var_10_11
							}
						end
					end
				elseif var_10_6 == DungeonEnum.EpisodeType.SeasonRetail then
					var_10_8 = Activity104Enum.JumpId.Retail
				elseif var_10_6 == DungeonEnum.EpisodeType.SeasonSpecial then
					var_10_8 = Activity104Enum.JumpId.Discount
					var_10_9 = {
						defaultSelectLayer = var_10_2
					}
				end
			end

			if var_10_10 and var_10_2 == 2 then
				var_10_8 = nil
				var_10_9 = nil
			end
		elseif var_10_6 == DungeonEnum.EpisodeType.SeasonSpecial then
			var_10_8 = Activity104Enum.JumpId.Discount
		end
	else
		logError(string.format("找不到对应关卡表,id:%s", var_10_0))
	end

	Activity104Controller.instance:openSeasonMainView({
		levelUpStage = var_10_7,
		jumpId = var_10_8,
		jumpParam = var_10_9
	})
end

function var_0_0.enterFightAgain11200()
	local var_11_0 = DungeonModel.instance.curSendEpisodeId
	local var_11_1 = DungeonConfig.instance:getEpisodeCO(var_11_0)
	local var_11_2 = Activity104Enum.SeasonType.Season2
	local var_11_3 = Activity104Model.instance:getBattleFinishLayer()

	if var_11_1.type == DungeonEnum.EpisodeType.SeasonRetail then
		var_11_3 = 0

		return false
	end

	Activity104Rpc.instance:sendBeforeStartAct104BattleRequest(var_11_2, var_11_3, var_11_0, var_0_0.enterFightAgain11200RpcCallback, nil)

	return true
end

function var_0_0.enterFightAgain11200RpcCallback(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 ~= 0 then
		MainController.instance:enterMainScene(true)
	else
		var_0_0.enterFightAgain()
	end
end

function var_0_0.enterActivity11202(arg_13_0, arg_13_1)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(arg_13_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.Activity114View)
		PermanentController.instance:jump2Activity(VersionActivity1_2Enum.ActivityId.EnterView)

		local var_14_0

		if Activity114Model.instance.serverData.isEnterSchool and Activity114Model.instance.serverData.battleEventId <= 0 then
			var_14_0 = {
				defaultTabIds = {
					[2] = Activity114Enum.TabIndex.MainView
				}
			}
		end

		ViewMgr.instance:openView(ViewName.Activity114View, var_14_0)
	end)
end

function var_0_0.enterActivity11206(arg_15_0, arg_15_1)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(arg_15_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.Activity119View)
		VersionActivity1_2EnterController.instance:directOpenVersionActivity1_2EnterView()
		Activity119Controller.instance:openAct119View()
	end)
end

return var_0_0
