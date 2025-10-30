module("modules.logic.versionactivity3_0.common.EnterActivityViewOnExitFightSceneHelper3_0", package.seeall)

local var_0_0 = EnterActivityViewOnExitFightSceneHelper

if GameBranchMgr.instance:isOnVer(3, 0) and SettingsModel.instance:isOverseas() then
	local function var_0_1(arg_1_0)
		local var_1_0 = VersionActivity3_0Enum.ActivityId.Reactivity

		arg_1_0:directOpenVersionActivityEnterView(var_1_0)
	end

	local function var_0_2(arg_2_0, arg_2_1)
		local var_2_0 = arg_2_1.episodeId
		local var_2_1 = arg_2_1.episodeCo

		if not var_2_1 then
			return
		end

		if var_0_0.sequence then
			var_0_0.sequence:destroy()

			var_0_0.sequence = nil
		end

		local var_2_2 = false
		local var_2_3 = ViewName.VersionActivity2_3DungeonMapLevelView
		local var_2_4 = ViewName.VersionActivity2_3DungeonMapView
		local var_2_5 = ViewName.VersionActivity3_0EnterView

		if var_2_1.chapterId == VersionActivity2_3DungeonEnum.DungeonChapterId.ElementFight then
			DungeonMapModel.instance.lastElementBattleId = var_2_0
			var_2_0 = VersionActivity2_3DungeonModel.instance:getLastEpisodeId()

			if var_2_0 then
				VersionActivity2_3DungeonModel.instance:setLastEpisodeId(nil)
			else
				var_2_0 = DungeonConfig.instance:getActivityElementFightEpisodeToNormalEpisodeId(var_2_1, VersionActivity2_3DungeonEnum.DungeonChapterId.Story)
			end

			GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, var_2_4)
		elseif DungeonModel.instance.curSendEpisodePass then
			var_2_2 = false

			GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, var_2_4)
		else
			var_2_2 = true

			GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, var_2_3)
		end

		local var_2_6 = FlowSequence.New()

		var_2_6:addWork(OpenViewWork.New({
			openFunction = var_0_1,
			openFunctionObj = VersionActivity3_0EnterController.instance,
			waitOpenViewName = var_2_5
		}))
		var_2_6:registerDoneListener(function()
			if var_2_2 then
				VersionActivity2_3DungeonController.instance:openVersionActivityDungeonMapView(nil, var_2_0, function()
					ViewMgr.instance:openView(var_2_3, {
						episodeId = var_2_0
					})
				end, nil)
			else
				VersionActivity2_3DungeonController.instance:openVersionActivityDungeonMapView(nil, var_2_0)
			end
		end)
		var_2_6:start()

		var_0_0.sequence = var_2_6
	end

	function var_0_0.enterActivity12302(arg_5_0, arg_5_1)
		var_0_0.enterVersionActivityDungeonCommon(var_0_2, arg_5_0, arg_5_1)
	end
end

function var_0_0.activate()
	return
end

function var_0_0.enterActivity13000(arg_7_0, arg_7_1)
	var_0_0.enterVersionActivityDungeonCommon(var_0_0._enterActivityDungeonAterFight13000, arg_7_0, arg_7_1)
end

function var_0_0.checkFightAfterStory13000(arg_8_0, arg_8_1, arg_8_2)
	if (var_0_0.recordMO and var_0_0.recordMO.fightResult) ~= 1 then
		return
	end

	local var_8_0 = DungeonModel.instance.curSendEpisodeId

	if not var_8_0 then
		return
	end

	local var_8_1 = DungeonConfig.instance:getEpisodeCO(var_8_0)

	if not var_8_1 or var_8_1.type ~= DungeonEnum.EpisodeType.Season then
		return
	end

	local var_8_2 = Activity104Model.instance:getBattleFinishLayer()
	local var_8_3 = Activity104Model.instance:getCurSeasonId()

	if Activity104Model.instance:isEpisodeAfterStory(var_8_3, var_8_2) then
		return
	end

	local var_8_4 = SeasonConfig.instance:getSeasonEpisodeCo(var_8_3, var_8_2)

	if not var_8_4 or var_8_4.afterStoryId == 0 then
		return
	end

	StoryController.instance:playStory(var_8_4.afterStoryId, nil, arg_8_0, arg_8_1, arg_8_2)

	return true
end

function var_0_0._enterActivityDungeonAterFight13000(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1.episodeId
	local var_9_1 = arg_9_1.exitFightGroup

	if not var_9_0 then
		return
	end

	local var_9_2 = Activity104Model.instance:getBattleFinishLayer()
	local var_9_3 = Activity104Model.instance:getCurSeasonId()
	local var_9_4 = var_0_0.recordMO and var_0_0.recordMO.fightResult
	local var_9_5 = DungeonConfig.instance:getEpisodeCO(var_9_0)
	local var_9_6 = var_9_5 and var_9_5.type
	local var_9_7 = Activity104Model.instance:canPlayStageLevelup(var_9_4, var_9_6, var_9_1, var_9_3, var_9_2)
	local var_9_8
	local var_9_9
	local var_9_10 = Activity104Model.instance:canMarkFightAfterStory(var_9_4, var_9_6, var_9_1, var_9_3, var_9_2)

	if var_9_10 then
		Activity104Rpc.instance:sendMarkEpisodeAfterStoryRequest(var_9_3, var_9_2)
	end

	if var_9_5 then
		if not var_9_4 or var_9_4 == -1 or var_9_4 == 0 then
			if var_9_6 == DungeonEnum.EpisodeType.Season then
				var_9_8 = Activity104Enum.JumpId.Market
				var_9_9 = {
					tarLayer = var_9_2
				}
			elseif var_9_6 == DungeonEnum.EpisodeType.SeasonRetail then
				var_9_8 = Activity104Enum.JumpId.Retail
			elseif var_9_6 == DungeonEnum.EpisodeType.SeasonSpecial then
				var_9_8 = Activity104Enum.JumpId.Discount
				var_9_9 = {
					defaultSelectLayer = var_9_2,
					directOpenLayer = var_9_2
				}
			end
		elseif var_9_4 == 1 then
			if not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonUTTU) or not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonDiscount) then
				if var_9_6 == DungeonEnum.EpisodeType.Season then
					if not var_9_7 then
						local var_9_11 = var_9_2 + 1

						if SeasonConfig.instance:getSeasonEpisodeCo(var_9_3, var_9_11) then
							var_9_8 = Activity104Enum.JumpId.Market
							var_9_9 = {
								tarLayer = var_9_11
							}
						end
					end
				elseif var_9_6 == DungeonEnum.EpisodeType.SeasonRetail then
					var_9_8 = Activity104Enum.JumpId.Retail
				elseif var_9_6 == DungeonEnum.EpisodeType.SeasonSpecial then
					var_9_8 = Activity104Enum.JumpId.Discount
				end
			end

			if var_9_10 and var_9_2 == 1 then
				var_9_8 = nil
				var_9_9 = nil
			end
		elseif var_9_6 == DungeonEnum.EpisodeType.SeasonSpecial then
			var_9_8 = Activity104Enum.JumpId.Discount
		end
	else
		logError(string.format("找不到对应关卡表,id:%s", var_9_0))
	end

	local var_9_12 = Activity104Enum.ViewName.MainView
	local var_9_13 = SeasonViewHelper.getViewName(var_9_3, var_9_12, true)

	GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, var_9_13)

	local function var_9_14()
		Activity104Controller.instance:openSeasonMainView({
			levelUpStage = var_9_7,
			jumpId = var_9_8,
			jumpParam = var_9_9
		})
	end

	VersionActivity3_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(var_9_14, nil, var_9_3, true)
end

function var_0_0.enterFightAgain13000()
	local var_11_0 = DungeonModel.instance.curSendEpisodeId
	local var_11_1 = DungeonConfig.instance:getEpisodeCO(var_11_0)
	local var_11_2 = Activity104Model.instance:getCurSeasonId()
	local var_11_3 = Activity104Model.instance:getBattleFinishLayer()

	if var_11_1.type == DungeonEnum.EpisodeType.SeasonRetail then
		var_11_3 = 0

		return false
	end

	if FightController.instance:isReplayMode(var_11_0) and not var_11_3 then
		if var_11_1.type == DungeonEnum.EpisodeType.Season then
			local var_11_4 = SeasonConfig.instance:getSeasonEpisodeCos(var_11_2)

			for iter_11_0, iter_11_1 in pairs(var_11_4) do
				if iter_11_1.episodeId == var_11_0 then
					var_11_3 = iter_11_1.layer

					break
				end
			end
		elseif var_11_1.type == DungeonEnum.EpisodeType.SeasonRetail then
			var_11_3 = 0
		elseif var_11_1.type == DungeonEnum.EpisodeType.SeasonSpecial then
			local var_11_5 = SeasonConfig.instance:getSeasonSpecialCos(var_11_2)

			for iter_11_2, iter_11_3 in pairs(var_11_5) do
				if iter_11_3.episodeId == var_11_0 then
					var_11_3 = iter_11_3.layer

					break
				end
			end
		end

		Activity104Model.instance:setBattleFinishLayer(var_11_3)
	end

	GameSceneMgr.instance:closeScene(nil, nil, nil, true)
	Activity104Model.instance:enterAct104Battle(var_11_0, var_11_3)

	return true
end

function var_0_0._enterActivityDungeonAterFight12618(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1.episodeId
	local var_12_1 = arg_12_1.exitFightGroup

	if not var_12_0 then
		return
	end

	local var_12_2 = Season166Model.instance:getBattleContext()

	if not var_12_2 then
		return false
	end

	local var_12_3 = var_12_2.trainId
	local var_12_4 = var_12_2.baseId
	local var_12_5 = var_12_2.actId
	local var_12_6 = var_0_0.recordMO and var_0_0.recordMO.fightResult
	local var_12_7 = DungeonConfig.instance:getEpisodeCO(var_12_0)
	local var_12_8 = var_12_7 and var_12_7.type
	local var_12_9
	local var_12_10

	if var_12_7 then
		if not var_12_6 or var_12_6 == -1 or var_12_6 == 0 then
			if var_12_8 == DungeonEnum.EpisodeType.Season166Base then
				var_12_9 = Season166Enum.JumpId.BaseSpotEpisode
				var_12_10 = {
					baseId = var_12_4
				}
			elseif var_12_8 == DungeonEnum.EpisodeType.Season166Train then
				var_12_9 = Season166Enum.JumpId.TrainEpisode
				var_12_10 = {
					trainId = var_12_3
				}
			elseif var_12_8 == DungeonEnum.EpisodeType.Season166Teach then
				var_12_9 = Season166Enum.JumpId.TeachView
			end
		elseif var_12_6 == 1 then
			if var_12_8 == DungeonEnum.EpisodeType.Season166Base then
				var_12_9 = Season166Enum.JumpId.MainView
			elseif var_12_8 == DungeonEnum.EpisodeType.Season166Train then
				var_12_9 = Season166Enum.JumpId.TrainView
			elseif var_12_8 == DungeonEnum.EpisodeType.Season166Teach then
				var_12_9 = Season166Enum.JumpId.TeachView
			end
		end
	else
		logError(string.format("找不到对应关卡表,id:%s", var_12_0))
	end

	VersionActivity3_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		Season166Controller.instance:openSeasonView({
			actId = var_12_5,
			jumpId = var_12_9,
			jumpParam = var_12_10
		})
	end, nil, VersionActivity3_0Enum.ActivityId.Season)
end

function var_0_0.enterActivity13016(arg_14_0, arg_14_1)
	local var_14_0 = DungeonModel.instance.curSendEpisodeId
	local var_14_1, var_14_2 = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(var_14_0)

	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(arg_14_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.V1a4_BossRushMainView)
		VersionActivity3_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			BossRushController.instance:openMainView({
				isOpenLevelDetail = true,
				stage = var_14_1,
				layer = var_14_2
			})
		end, nil, BossRushConfig.instance:getActivityId(), true)
	end)
end

function var_0_0.enterActivity13015(arg_17_0, arg_17_1)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId

	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(arg_17_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity3_0EnterView)

		local var_18_0 = ActivityConfig.instance:getActivityCo(VersionActivity3_0Enum.ActivityId.KaRong)

		if DungeonModel.instance.lastSendEpisodeId == var_18_0.tryoutEpisode then
			VersionActivity3_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, VersionActivity3_0Enum.ActivityId.KaRong, true)
		else
			local function var_18_1()
				RoleActivityController.instance:enterActivity(VersionActivity3_0Enum.ActivityId.KaRong)
			end

			VersionActivity3_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(var_18_1, nil, VersionActivity3_0Enum.ActivityId.KaRong, true)
		end
	end)
end

function var_0_0.enterActivity13011(arg_20_0, arg_20_1)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId

	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(arg_20_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity3_0EnterView)

		local var_21_0 = ActivityConfig.instance:getActivityCo(VersionActivity3_0Enum.ActivityId.MaLiAnNa)

		if DungeonModel.instance.lastSendEpisodeId == var_21_0.tryoutEpisode then
			VersionActivity3_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, VersionActivity3_0Enum.ActivityId.MaLiAnNa, true)
		else
			local function var_21_1()
				RoleActivityController.instance:enterActivity(VersionActivity3_0Enum.ActivityId.MaLiAnNa)
			end

			VersionActivity3_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(var_21_1, nil, VersionActivity3_0Enum.ActivityId.MaLiAnNa, true)
		end
	end)
end

return var_0_0
