module("modules.logic.sp01.enter.controller.EnterActivityViewOnExitFightSceneHelper2_9", package.seeall)

local var_0_0 = EnterActivityViewOnExitFightSceneHelper

local function var_0_1(arg_1_0, arg_1_1)
	local var_1_0 = true
	local var_1_1 = VersionActivity2_0DungeonModel.instance
	local var_1_2 = VersionActivity2_0DungeonController.instance
	local var_1_3 = arg_1_1.episodeId
	local var_1_4 = arg_1_1.episodeCo

	if not var_1_4 then
		return
	end

	if var_0_0.sequence then
		var_0_0.sequence:destroy()

		var_0_0.sequence = nil
	end

	local var_1_5 = false

	if var_1_4.chapterId == VersionActivity2_0DungeonEnum.DungeonChapterId.ElementFight then
		DungeonMapModel.instance.lastElementBattleId = var_1_3
		var_1_3 = var_1_1:getLastEpisodeId()

		if var_1_3 then
			var_1_1:setLastEpisodeId(nil)
		else
			var_1_3 = DungeonConfig.instance:getActivityElementFightEpisodeToNormalEpisodeId(var_1_4, VersionActivity2_0DungeonEnum.DungeonChapterId.Story)
		end

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_0DungeonMapView)
	elseif DungeonModel.instance.curSendEpisodePass then
		var_1_5 = false

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_0DungeonMapView)
	else
		var_1_5 = true

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_0DungeonMapLevelView)
	end

	local var_1_6 = FlowSequence.New()

	if var_1_0 then
		PermanentController.instance:jump2Activity(VersionActivity2_0Enum.ActivityId.EnterView)
		var_1_6:addWork(OpenViewWork.New({
			openFunction = function()
				return
			end,
			waitOpenViewName = ViewName.Permanent2_0EnterView
		}))
	else
		var_1_6:addWork(OpenViewWork.New({
			openFunction = var_0_0.open2_7ReactivityEnterView,
			openFunctionObj = VersionActivityFixedHelper.getVersionActivityEnterController().instance,
			waitOpenViewName = VersionActivityFixedHelper.getVersionActivityEnterViewName()
		}))
	end

	var_1_6:registerDoneListener(function()
		if var_1_5 then
			var_1_2:openVersionActivityDungeonMapView(nil, var_1_3, function()
				ViewMgr.instance:openView(ViewName.VersionActivity2_0DungeonMapLevelView, {
					episodeId = var_1_3
				})
			end, nil)
		else
			var_1_2:openVersionActivityDungeonMapView(nil, var_1_3)
		end
	end)
	var_1_6:start()

	var_0_0.sequence = var_1_6
end

function var_0_0.enterActivity12003(arg_5_0, arg_5_1)
	var_0_0.enterVersionActivityDungeonCommon(var_0_1, arg_5_0, arg_5_1)
end

function var_0_0.activate()
	return
end

local function var_0_2(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1.episodeId
	local var_7_1 = arg_7_1.episodeCo

	if not var_7_1 then
		return
	end

	if var_0_0.sequence then
		var_0_0.sequence:destroy()

		var_0_0.sequence = nil
	end

	local var_7_2 = false

	if var_7_1.chapterId == VersionActivity2_3DungeonEnum.DungeonChapterId.ElementFight then
		DungeonMapModel.instance.lastElementBattleId = var_7_0
		var_7_0 = VersionActivity2_3DungeonModel.instance:getLastEpisodeId()

		if var_7_0 then
			VersionActivity2_3DungeonModel.instance:setLastEpisodeId(nil)
		else
			var_7_0 = DungeonConfig.instance:getActivityElementFightEpisodeToNormalEpisodeId(var_7_1, VersionActivity2_3DungeonEnum.DungeonChapterId.Story)
		end

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_3DungeonMapView)
	elseif DungeonModel.instance.curSendEpisodePass then
		var_7_2 = false

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_3DungeonMapView)
	else
		var_7_2 = true

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_3DungeonMapLevelView)
	end

	local var_7_3 = FlowSequence.New()

	var_7_3:addWork(OpenViewWork.New({
		openFunction = function()
			ViewMgr.instance:openView(ViewName.V2a3_ReactivityEnterview)
		end
	}))
	var_7_3:registerDoneListener(function()
		if var_7_2 then
			VersionActivity2_3DungeonController.instance:openVersionActivityDungeonMapView(nil, var_7_0, function()
				ViewMgr.instance:openView(ViewName.VersionActivity2_3DungeonMapLevelView, {
					episodeId = var_7_0
				})
			end, nil)
		else
			VersionActivity2_3DungeonController.instance:openVersionActivityDungeonMapView(nil, var_7_0)
		end
	end)
	var_7_3:start()

	var_0_0.sequence = var_7_3
end

function var_0_0.enterActivity130502(arg_11_0, arg_11_1)
	var_0_0.enterVersionActivityDungeonCommon(var_0_0._enterActivity130502, arg_11_0, arg_11_1)
end

function var_0_0._enterActivity130502(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1.episodeId

	if not arg_12_1.episodeCo then
		return
	end

	if var_0_0.sequence then
		var_0_0.sequence:destroy()

		var_0_0.sequence = nil
	end

	local var_12_1 = false
	local var_12_2 = ViewName.VersionActivity2_9DungeonMapLevelView
	local var_12_3 = ViewName.VersionActivity2_9DungeonMapView
	local var_12_4 = ViewName.VersionActivity2_9EnterView

	if DungeonModel.instance.curSendEpisodePass then
		var_12_1 = false

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, var_12_3)
	else
		var_12_1 = true

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, var_12_2)
	end

	local var_12_5 = FlowSequence.New()

	var_12_5:addWork(OpenViewWork.New({
		openFunction = VersionActivity2_9EnterController.directOpenVersionActivityEnterView,
		openFunctionObj = VersionActivity2_9EnterController.instance,
		waitOpenViewName = var_12_4
	}))
	var_12_5:registerDoneListener(function()
		if var_12_1 then
			VersionActivity2_9DungeonController.instance:openVersionActivityDungeonMapView(nil, var_12_0, function()
				ViewMgr.instance:openView(var_12_2, {
					episodeId = var_12_0
				})
			end, nil)
		else
			VersionActivity2_9DungeonController.instance:openVersionActivityDungeonMapView(nil, var_12_0)
		end
	end)
	var_12_5:start()

	var_0_0.sequence = var_12_5
end

function var_0_0.enterActivity12302(arg_15_0, arg_15_1)
	var_0_0.enterVersionActivityDungeonCommon(var_0_2, arg_15_0, arg_15_1)
end

function var_0_0.enterActivity130504(arg_16_0, arg_16_1)
	var_0_0.enterVersionActivityDungeonCommon(var_0_0._enterActivity130504, arg_16_0, arg_16_1)
end

function var_0_0._enterActivity130504(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1.episodeCo.type == DungeonEnum.EpisodeType.Assassin2Stealth

	if var_0_0.sequence then
		var_0_0.sequence:destroy()

		var_0_0.sequence = nil
	end

	local var_17_1 = AssassinOutsideModel.instance:isAct195Open(true)
	local var_17_2 = {}

	if var_17_1 then
		local var_17_3 = ViewName.AssassinMapView

		if var_17_0 then
			var_17_2.fightReturnStealthGame = true
			var_17_3 = ViewName.AssassinStealthGameView
		else
			local var_17_4 = AssassinOutsideModel.instance:getEnterFightQuest()
			local var_17_5 = AssassinConfig.instance:getQuestMapId(var_17_4)

			if var_17_5 then
				var_17_3 = ViewName.AssassinQuestMapView
			end

			var_17_2.questMapId = var_17_5
		end

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, var_17_3)
	end

	local var_17_6 = ViewName.VersionActivity2_9EnterView
	local var_17_7 = FlowSequence.New()

	var_17_7:addWork(OpenViewWork.New({
		openFunction = VersionActivity2_9EnterController.directOpenVersionActivityEnterView,
		openFunctionObj = VersionActivity2_9EnterController.instance,
		waitOpenViewName = var_17_6
	}))
	var_17_7:registerDoneListener(function()
		AssassinController.instance:openAssassinMapView(var_17_2)
	end)
	var_17_7:start()

	var_0_0.sequence = var_17_7
end

function var_0_0.enterActivity130505(arg_19_0, arg_19_1)
	local var_19_0 = DungeonModel.instance.curSendEpisodeId
	local var_19_1, var_19_2 = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(var_19_0)

	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(arg_19_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.V1a4_BossRushMainView)
		VersionActivity2_9EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			BossRushController.instance:openMainView({
				isOpenLevelDetail = true,
				stage = var_19_1,
				layer = var_19_2
			})
		end, nil, BossRushConfig.instance:getActivityId(), true, true)
	end)
end

function var_0_0.enterActivity130507(arg_22_0, arg_22_1)
	var_0_0.enterVersionActivityDungeonCommon(var_0_0.enterActivityDungeonAterFight130507, arg_22_0, arg_22_1)
end

function var_0_0.enterActivityDungeonAterFight130507(arg_23_0, arg_23_1)
	if var_0_0.sequence then
		var_0_0.sequence:destroy()

		var_0_0.sequence = nil
	end

	GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.OdysseyDungeonView)

	local var_23_0 = ViewName.VersionActivity2_9EnterView
	local var_23_1 = FlowSequence.New()

	var_23_1:addWork(OpenViewWork.New({
		openFunction = VersionActivity2_9EnterController.directOpenVersionActivityEnterView,
		openFunctionObj = VersionActivity2_9EnterController.instance,
		waitOpenViewName = var_23_0
	}))
	var_23_1:registerDoneListener(function()
		OdysseyDungeonController.instance:openDungeonView()
	end)
	var_23_1:start()

	var_0_0.sequence = var_23_1
end

return var_0_0
