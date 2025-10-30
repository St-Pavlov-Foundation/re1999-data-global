module("modules.logic.versionactivity2_1.common.EnterActivityViewOnExitFightSceneHelper2_1", package.seeall)

local var_0_0 = EnterActivityViewOnExitFightSceneHelper

local function var_0_1(arg_1_0)
	PermanentController.instance:jump2Activity(VersionActivity2_1Enum.ActivityId.EnterView, arg_1_0)
end

function var_0_0.enterActivity12113(arg_2_0, arg_2_1)
	local var_2_0 = DungeonModel.instance.curSendEpisodeId
	local var_2_1, var_2_2 = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(var_2_0)

	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(arg_2_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.V1a4_BossRushMainView)
		VersionActivity2_1EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			BossRushController.instance:openMainView({
				isOpenLevelDetail = true,
				stage = var_2_1,
				layer = var_2_2
			})
		end, nil, BossRushConfig.instance:getActivityId())
	end)
end

function var_0_0.enterActivity12105(arg_5_0, arg_5_1)
	local var_5_0 = 12105
	local var_5_1 = true

	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(arg_5_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		if var_5_1 then
			if var_0_0.sequence then
				var_0_0.sequence:destroy()

				var_0_0.sequence = nil
			end

			if arg_5_1 then
				var_0_1()
				AergusiController.instance:openAergusiLevelView(var_5_0, false)
			else
				local var_6_0 = {
					roleActNeedReqInfo = false,
					isJumpAergusi = true,
					roleActId = var_5_0
				}

				AergusiController.instance:openAergusiLevelView(var_5_0, true)

				local var_6_1 = FlowSequence.New()

				var_6_1:addWork(OpenViewWork.New({
					openFunction = var_0_1,
					openFunctionObj = var_6_0,
					waitOpenViewName = ViewName.AergusiLevelView
				}))
				var_6_1:start()

				var_0_0.sequence = var_6_1
			end
		else
			VersionActivity2_1EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, VersionActivity2_1Enum.ActivityId.Aergusi, true)
		end
	end)
end

function var_0_0.enterActivity12114(arg_7_0, arg_7_1)
	local var_7_0 = 12114
	local var_7_1 = true

	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(arg_7_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		if var_7_1 then
			if var_0_0.sequence then
				var_0_0.sequence:destroy()

				var_0_0.sequence = nil
			end

			if arg_7_1 then
				var_0_1()
				LanShouPaController.instance:openLanShouPaMapView(var_7_0, false)
			else
				local var_8_0 = {
					isJumpLanShouPa = true,
					roleActNeedReqInfo = false,
					roleActId = var_7_0
				}

				LanShouPaController.instance:openLanShouPaMapView(var_7_0, true)

				local var_8_1 = FlowSequence.New()

				var_8_1:addWork(OpenViewWork.New({
					openFunction = var_0_1,
					openFunctionObj = var_8_0,
					waitOpenViewName = ViewName.LanShouPaMapView
				}))
				var_8_1:start()

				var_0_0.sequence = var_8_1
			end
		else
			VersionActivity2_1EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, VersionActivity2_1Enum.ActivityId.LanShouPa, true)
		end
	end)
end

function var_0_0.enterActivity12115(arg_9_0, arg_9_1)
	var_0_0.enterVersionActivityDungeonCommon(var_0_0._enterActivityDungeonAterFight12115, arg_9_0, arg_9_1)
end

local function var_0_2()
	local var_10_0 = DungeonModel.instance.curSendEpisodeId

	if not var_10_0 then
		return
	end

	local var_10_1 = DungeonConfig.instance:getEpisodeCO(var_10_0)

	if not var_10_1 then
		return false
	end

	local var_10_2 = Season123Model.instance:getBattleContext()

	if not var_10_2 then
		logNormal("Season123 checkSeason123BattleDatas no context found!")

		return false
	end

	return true, var_10_0, var_10_1, var_10_2
end

function var_0_0._enterActivityDungeonAterFight12115(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1.episodeId
	local var_11_1 = arg_11_1.exitFightGroup

	if not var_11_0 then
		return
	end

	local var_11_2 = Season123Model.instance:getBattleContext()

	if not var_11_2 then
		logNormal("Season123 checkSeason123BattleDatas no context found!")

		return false
	end

	local var_11_3 = var_11_2.layer
	local var_11_4 = var_11_2.stage
	local var_11_5 = var_11_2.actId
	local var_11_6 = var_0_0.recordMO and var_0_0.recordMO.fightResult
	local var_11_7 = DungeonConfig.instance:getEpisodeCO(var_11_0)
	local var_11_8 = var_11_7 and var_11_7.type
	local var_11_9
	local var_11_10

	if var_11_7 then
		if not var_11_6 or var_11_6 == -1 or var_11_6 == 0 then
			if var_11_8 == DungeonEnum.EpisodeType.Season123 then
				var_11_9 = Activity123Enum.JumpId.MarketNoResult
				var_11_10 = {
					tarLayer = var_11_3
				}
			elseif var_11_8 == DungeonEnum.EpisodeType.Season123Retail then
				var_11_9 = Activity123Enum.JumpId.Retail
			end
		elseif var_11_6 == 1 and (not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonUTTU) or not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonDiscount)) then
			if var_11_8 == DungeonEnum.EpisodeType.Season123 then
				local var_11_11 = var_11_3 + 1

				if Season123Config.instance:getSeasonEpisodeCo(var_11_5, var_11_4, var_11_11) then
					var_11_9 = Activity123Enum.JumpId.Market
					var_11_10 = {
						tarLayer = var_11_11
					}
				else
					var_11_9 = Activity123Enum.JumpId.MarketStageFinish
					var_11_10 = {
						stage = var_11_4
					}
				end
			elseif var_11_8 == DungeonEnum.EpisodeType.Season123Retail then
				var_11_9 = Activity123Enum.JumpId.Retail
				var_11_10 = {
					needRandom = true
				}
			end
		end
	else
		logError(string.format("找不到对应关卡表,id:%s", var_11_0))
	end

	VersionActivity2_1EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		Season123Controller.instance:openSeasonEntry({
			actId = var_11_5,
			jumpId = var_11_9,
			jumpParam = var_11_10
		})
	end, nil, VersionActivity2_1Enum.ActivityId.Season)
end

function var_0_0.checkFightAfterStory12115(arg_13_0, arg_13_1, arg_13_2)
	if (var_0_0.recordMO and var_0_0.recordMO.fightResult) ~= 1 then
		return
	end

	local var_13_0, var_13_1, var_13_2, var_13_3 = var_0_2()

	if not var_13_0 or var_13_2.type ~= DungeonEnum.EpisodeType.Season123 then
		return
	end

	local var_13_4 = var_13_3.layer
	local var_13_5 = var_13_3.actId
	local var_13_6 = var_13_3.stage

	if Season123Model.instance:isEpisodeAfterStory(var_13_5, var_13_6, var_13_4) then
		return
	end

	local var_13_7 = Season123Config.instance:getSeasonEpisodeCo(var_13_5, var_13_6, var_13_4)

	if not var_13_7 or var_13_7.afterStoryId == nil or var_13_7.afterStoryId == 0 then
		return
	end

	StoryController.instance:playStory(var_13_7.afterStoryId, nil, arg_13_0, arg_13_1, arg_13_2)

	return true
end

function var_0_0.enterFightAgain12115()
	local var_14_0, var_14_1, var_14_2, var_14_3 = var_0_2()

	if not var_14_0 or var_14_2.type == DungeonEnum.EpisodeType.Season123Retail then
		return false
	end

	local var_14_4 = var_14_3.layer
	local var_14_5 = var_14_3.stage
	local var_14_6 = var_14_3.actId

	if FightController.instance:isReplayMode(var_14_1) and not var_14_4 then
		if var_14_2.type == DungeonEnum.EpisodeType.Season123 then
			local var_14_7 = Season123Config.instance:getSeasonEpisodeStageCos(var_14_6, var_14_5)

			if not var_14_7 then
				return false
			end

			for iter_14_0, iter_14_1 in pairs(var_14_7) do
				if iter_14_1.episodeId == var_14_1 then
					var_14_4 = iter_14_1.layer

					break
				end
			end
		elseif var_14_2.type == DungeonEnum.EpisodeType.Season123Retail then
			var_14_4 = 0
		end
	end

	GameSceneMgr.instance:closeScene(nil, nil, nil, true)
	Season123EpisodeDetailController.instance:startBattle(var_14_6, var_14_5, var_14_4, var_14_1)

	return true
end

function var_0_0.enterActivity12102(arg_15_0, arg_15_1)
	var_0_0.enterVersionActivityDungeonCommon(var_0_0._enterActivity12102, arg_15_0, arg_15_1)
end

function var_0_0._enterActivity12102(arg_16_0, arg_16_1)
	local var_16_0 = true
	local var_16_1 = arg_16_1.episodeId
	local var_16_2 = arg_16_1.episodeCo

	if not var_16_2 then
		return
	end

	if var_0_0.sequence then
		var_0_0.sequence:destroy()

		var_0_0.sequence = nil
	end

	local var_16_3 = false

	if var_16_2.chapterId == VersionActivity2_1DungeonEnum.DungeonChapterId.ElementFight then
		DungeonMapModel.instance.lastElementBattleId = var_16_1
		var_16_1 = VersionActivity2_1DungeonModel.instance:getLastEpisodeId()

		if var_16_1 then
			VersionActivity2_1DungeonModel.instance:setLastEpisodeId(nil)
		else
			var_16_1 = DungeonConfig.instance:getActivityElementFightEpisodeToNormalEpisodeId(var_16_2, VersionActivity2_1DungeonEnum.DungeonChapterId.Story)
		end

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_1DungeonMapView)
	elseif DungeonModel.instance.curSendEpisodePass then
		var_16_3 = false

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_1DungeonMapView)
	else
		var_16_3 = true

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_1DungeonMapLevelView)
	end

	local var_16_4 = FlowSequence.New()

	if var_16_0 then
		var_16_4:addWork(OpenViewWork.New({
			openFunction = var_0_0._openPermanent_EnterView,
			waitOpenViewName = ViewName.VersionActivity2_1EnterView
		}))
	elseif GameBranchMgr.instance:isOnVer(2, 9) and SettingsModel.instance:isOverseas() then
		var_16_4:addWork(OpenViewWork.New({
			openFunction = function()
				ViewMgr.instance:openView(ViewName.VersionActivity3_0_v2a1_ReactivityEnterview)
			end
		}))
	else
		var_16_4:addWork(OpenViewWork.New({
			openFunction = var_0_0.open3_0ReactivityEnterView,
			openFunctionObj = VersionActivityFixedHelper.getVersionActivityEnterController(3, 0).instance,
			waitOpenViewName = VersionActivityFixedHelper.getVersionActivityEnterViewName()
		}))
	end

	var_16_4:registerDoneListener(function()
		if var_16_3 then
			VersionActivity2_1DungeonController.instance:openVersionActivityDungeonMapView(nil, var_16_1, function()
				ViewMgr.instance:openView(ViewName.VersionActivity2_1DungeonMapLevelView, {
					episodeId = var_16_1
				})
			end, nil)
		else
			VersionActivity2_1DungeonController.instance:openVersionActivityDungeonMapView(nil, var_16_1)
		end
	end)
	var_16_4:start()

	var_0_0.sequence = var_16_4
end

function var_0_0.open3_0ReactivityEnterView()
	VersionActivityFixedHelper.getVersionActivityEnterController(3, 0):directOpenVersionActivityEnterView(VersionActivity3_0Enum.ActivityId.Reactivity)
end

function var_0_0._openPermanent_EnterView()
	PermanentController.instance:jump2Activity(VersionActivity2_1Enum.ActivityId.EnterView)
end

return var_0_0
