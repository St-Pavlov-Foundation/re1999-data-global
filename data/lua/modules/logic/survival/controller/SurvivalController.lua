module("modules.logic.survival.controller.SurvivalController", package.seeall)

local var_0_0 = class("SurvivalController", BaseController)

function var_0_0.reInit(arg_1_0)
	if arg_1_0._settleFlow then
		arg_1_0._settleFlow:destroy()

		arg_1_0._settleFlow = nil
	end
end

function var_0_0.addConstEvents(arg_2_0)
	OpenController.instance:registerCallback(OpenEvent.GetOpenInfoSuccess, arg_2_0._onGetOpenInfoSuccess, arg_2_0)
	MainController.instance:registerCallback(MainEvent.OnFuncUnlockRefresh, arg_2_0._onGetOpenInfoSuccess, arg_2_0)
	OpenController.instance:registerCallback(OpenEvent.NewFuncUnlock, arg_2_0._newFuncUnlock, arg_2_0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, arg_2_0._checkActivityInfo, arg_2_0)

	if isDebugBuild then
		GMController.instance:registerCallback(GMController.Event.OnRecvGMMsg, arg_2_0._onRecvGMMsg, arg_2_0)
	end
end

function var_0_0._onGetOpenInfoSuccess(arg_3_0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Survival) then
		arg_3_0:_getInfo()
	end
end

function var_0_0._newFuncUnlock(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		if iter_4_1 == OpenEnum.UnlockFunc.Survival then
			arg_4_0:_getInfo()

			break
		end
	end
end

function var_0_0._checkActivityInfo(arg_5_0, arg_5_1)
	if not arg_5_1 or arg_5_1 == VersionActivity2_8Enum.ActivityId.Survival then
		arg_5_0:_getInfo()
	end
end

function var_0_0._getInfo(arg_6_0)
	if not ActivityHelper.isOpen(VersionActivity2_8Enum.ActivityId.Survival) then
		return
	end

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Survival) then
		return
	end

	SurvivalOutSideRpc.instance:sendSurvivalOutSideGetInfo()
end

function var_0_0.enterSurvivalMap(arg_7_0, arg_7_1)
	SurvivalInteriorRpc.instance:sendEnterSurvival(arg_7_1, arg_7_0._onEnterSurvival, arg_7_0)
end

function var_0_0._onRecvGMMsg(arg_8_0)
	SurvivalMapHelper.instance:tryStartFlow("")
end

function var_0_0._onEnterSurvival(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if arg_9_2 == 0 then
		if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Survival then
			GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.SurvivalLoadingView)
			GameSceneMgr.instance:startScene(SceneType.Survival, 280001, 280001, true, true)
		else
			logError("重复进入探索场景")
		end
	elseif GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		arg_9_0:exitMap()
	end
end

function var_0_0.enterShelterMap(arg_10_0, arg_10_1)
	arg_10_0._isExitFight = arg_10_1

	if SurvivalModel.instance:getSurvivalSettleInfo() ~= nil then
		arg_10_0:enterSurvivalShelterScene()

		return
	end

	SurvivalWeekRpc.instance:sendSurvivalGetWeekInfo(arg_10_0._onEnterShelter, arg_10_0)
end

function var_0_0._onEnterShelter(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if arg_11_2 == 0 then
		if SurvivalShelterModel.instance:getWeekInfo().inSurvival then
			arg_11_0:enterSurvivalMap()
		else
			arg_11_0:enterSurvivalShelterScene()
		end
	end
end

function var_0_0.enterSurvivalShelterScene(arg_12_0)
	local var_12_0 = SurvivalShelterModel.instance:getWeekInfo().intrudeBox.fight

	if arg_12_0._isExitFight and var_12_0 and var_12_0:isFighting() then
		SurvivalModel.instance:setBossFightLastIndex(var_12_0.currRound - 1)

		local var_12_1 = GameSceneMgr.instance:getPreSceneType()
		local var_12_2 = GameSceneMgr.instance:getPreSceneId()
		local var_12_3 = GameSceneMgr.instance:getPreLevelId()

		GameSceneMgr.instance:closeScene(nil, nil, nil, true)
		GameSceneMgr.instance:setPrevScene(var_12_1, var_12_2, var_12_3)
		arg_12_0:tryEnterShelterFight()
	elseif GameSceneMgr.instance:getCurSceneType() ~= SceneType.SurvivalShelter then
		GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.SurvivalLoadingView)
		GameSceneMgr.instance:startScene(SceneType.SurvivalShelter, 280001, 280001, true, true)
	else
		logError("重复加载避难所场景")
	end
end

function var_0_0.showToast(arg_13_0, arg_13_1)
	if not ViewMgr.instance:isOpen(ViewName.SurvivalToastView) then
		table.insert(SurvivalMapModel.instance.showToastList, arg_13_1)
		ViewMgr.instance:openView(ViewName.SurvivalToastView)
	elseif ViewMgr.instance:isOpening(ViewName.SurvivalToastView) then
		table.insert(SurvivalMapModel.instance.showToastList, arg_13_1)
	else
		arg_13_0:dispatchEvent(SurvivalEvent.ShowToast, arg_13_1)
	end
end

function var_0_0.exitMap(arg_14_0)
	local var_14_0 = SurvivalModel.instance:getOutSideInfo()
	local var_14_1 = SurvivalShelterModel.instance:getWeekInfo()
	local var_14_2 = var_14_1 and var_14_1.inSurvival
	local var_14_3 = GameSceneMgr.instance:getCurSceneType()

	DungeonModel.instance.curSendEpisodeId = nil

	if var_14_3 == SceneType.Survival and var_14_0.inWeek and not var_14_2 then
		arg_14_0:enterShelterMap()

		return
	end

	MainController.instance:enterMainScene()
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_8EnterView)
		VersionActivity2_8EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, VersionActivity2_8Enum.ActivityId.Survival, true)
		ViewMgr.instance:openView(ViewName.SurvivalView)
	end)
end

function var_0_0.openEquipView(arg_16_0)
	SurvivalWeekRpc.instance:sendSurvivalGetEquipInfo(arg_16_0.onRecvEquipInfo, arg_16_0)
end

function var_0_0.onRecvEquipInfo(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	ViewMgr.instance:openView(ViewName.SurvivalEquipView)
end

function var_0_0.tryEnterSurvivalFight(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0._callback = arg_18_1
	arg_18_0._callobj = arg_18_2

	local var_18_0 = SurvivalModel.instance:getOutSideInfo()

	if not var_18_0 or not var_18_0.inWeek then
		logError("不在避难所中，重连不了战斗！！！！")
		arg_18_0:callBackReconnectFight()

		return
	end

	SurvivalWeekRpc.instance:sendSurvivalGetWeekInfo(arg_18_0._onRecvWeekInfo, arg_18_0)
end

function var_0_0._onRecvWeekInfo(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	if arg_19_2 == 0 then
		local var_19_0 = SurvivalShelterModel.instance:getWeekInfo()

		if var_19_0.inSurvival then
			SurvivalInteriorRpc.instance:sendEnterSurvival(nil, arg_19_0._onRecvMapInfo, arg_19_0)
		else
			local var_19_1 = var_19_0.intrudeBox.fight.fightCo
			local var_19_2 = var_19_1 and var_19_1.battleId or 0

			FightController.instance:setFightParamByEpisodeBattleId(SurvivalEnum.Shelter_EpisodeId, var_19_2)
			arg_19_0:callBackReconnectFight()
		end
	else
		arg_19_0:callBackReconnectFight()
	end
end

function var_0_0._onRecvMapInfo(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	if arg_20_2 == 0 then
		local var_20_0 = SurvivalMapModel.instance:getSceneMo().battleInfo.battleId

		if var_20_0 == 0 then
			logError("没有battleId，为什么会有战斗！！！！")
		else
			FightController.instance:setFightParamByEpisodeBattleId(SurvivalEnum.Survival_EpisodeId, var_20_0)
		end

		arg_20_0:callBackReconnectFight()
	else
		arg_20_0:callBackReconnectFight()
	end
end

function var_0_0.callBackReconnectFight(arg_21_0)
	if arg_21_0._callback then
		arg_21_0._callback(arg_21_0._callobj)
	end

	arg_21_0._callback = nil
	arg_21_0._callobj = nil
end

function var_0_0.openDecreeSelectView(arg_22_0)
	local var_22_0 = SurvivalShelterModel.instance:getWeekInfo():getDecreeBox()
	local var_22_1

	for iter_22_0 = 1, 3 do
		local var_22_2 = var_22_0:getDecreeInfo(iter_22_0)

		if not var_22_2 or var_22_2:isCurPolicyEmpty() then
			var_22_1 = iter_22_0

			break
		end
	end

	if not var_22_1 then
		return
	end

	local var_22_3 = var_22_0:getDecreeInfo(var_22_1)

	if var_22_3 and var_22_3:hasOptions() then
		ViewMgr.instance:openView(ViewName.SurvivalDecreeSelectView, {
			decreeInfo = var_22_3
		})
	else
		SurvivalWeekRpc.instance:sendSurvivalDecreePromulgateRequest(var_22_1, arg_22_0._openDecreeSelectView, arg_22_0)
	end
end

function var_0_0._openDecreeSelectView(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	if arg_23_2 == 0 then
		local var_23_0 = SurvivalShelterModel.instance:getWeekInfo():getDecreeBox():getDecreeInfo(arg_23_3.decree.no)

		ViewMgr.instance:openView(ViewName.SurvivalDecreeSelectView, {
			decreeInfo = var_23_0
		})
	end
end

function var_0_0.startDecreeVote(arg_24_0, arg_24_1)
	ViewMgr.instance:closeAllModalViews()
	ViewMgr.instance:closeAllPopupViews()
	PopupController.instance:setPause(ViewName.SurvivalDecreeVoteView, true)

	if not arg_24_1 then
		local var_24_0 = SurvivalShelterModel.instance:getWeekInfo():getDecreeBox()
		local var_24_1, var_24_2 = var_24_0:isCurAllPolicyNotFinish()

		arg_24_1 = var_24_0:getDecreeInfo(var_24_2)
	end

	ViewMgr.instance:openView(ViewName.SurvivalDecreeVoteView, {
		decreeInfo = arg_24_1
	})
end

function var_0_0.enterSurvival(arg_25_0)
	local var_25_0 = SurvivalShelterModel.instance:getWeekInfo()

	if var_25_0:isInFight() then
		GameFacade.showMessageBox(MessageBoxIdDefine.SurvivalHaveBossFightSure, MsgBoxEnum.BoxType.Yes_No, arg_25_0._sendAbandon, nil, nil, arg_25_0, nil, nil)

		return
	end

	if var_25_0:isNpcWillLeave() then
		GameFacade.showMessageBox(MessageBoxIdDefine.SurvivalNpcTips, MsgBoxEnum.BoxType.Yes_No, arg_25_0.openSurvivalInitTeamView, nil, nil, arg_25_0, nil, nil)

		return
	end

	arg_25_0:openSurvivalInitTeamView()
end

function var_0_0.openSurvivalInitTeamView(arg_26_0)
	SurvivalMapModel.instance:getInitGroup():init()
	ViewMgr.instance:openView(ViewName.SurvivalInitTeamView)
end

function var_0_0._sendAbandon(arg_27_0)
	UIBlockHelper.instance:startBlock(SurvivalEnum.SurvivalIntrudeAbandonBlock)
	SurvivalWeekRpc.instance:sendSurvivalIntrudeAbandonExterminateRequest()
end

function var_0_0.startNewWeek(arg_28_0)
	local var_28_0 = SurvivalModel.instance:getOutSideInfo()

	if var_28_0 then
		var_28_0.inWeek = true
	end
end

function var_0_0.enterSurvivalSettle(arg_29_0)
	local var_29_0 = SurvivalModel.instance:getSurvivalSettleInfo()

	if var_29_0 ~= nil then
		ViewMgr.instance:openView(ViewName.SurvivalCeremonyClosingView, {
			isWin = var_29_0.win,
			score = var_29_0.score,
			report = var_29_0.report
		})
		SurvivalModel.instance:setSurvivalSettleInfo(nil)
	end
end

function var_0_0.tryEnterShelterFight(arg_30_0, arg_30_1, arg_30_2)
	arg_30_0._shelterCallBack = arg_30_1
	arg_30_0._shelterCallObj = arg_30_2

	HeroGroupRpc.instance:sendGetHeroGroupSnapshotListRequest(ModuleEnum.HeroGroupSnapshotType.Shelter, arg_30_0._onRecvMsg, arg_30_0)
end

function var_0_0._onRecvMsg(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	if arg_31_2 == 0 then
		local var_31_0 = SurvivalShelterModel.instance:getWeekInfo().intrudeBox.fight
		local var_31_1 = var_31_0.fightCo
		local var_31_2 = SurvivalEnum.Shelter_EpisodeId
		local var_31_3 = DungeonConfig.instance:getEpisodeCO(var_31_2)
		local var_31_4 = SurvivalModel.instance:getBossFightLastIndex()
		local var_31_5 = var_31_4 == nil and var_31_0.currRound or var_31_4

		HeroGroupSnapshotModel.instance:setSelectIndex(ModuleEnum.HeroGroupSnapshotType.Shelter, var_31_5)

		local var_31_6 = HeroGroupSnapshotModel.instance:getHeroGroupInfo(ModuleEnum.HeroGroupSnapshotType.Shelter, var_31_0.currRound)

		if var_31_6 then
			for iter_31_0 = 1, #var_31_6.heroList do
				local var_31_7 = var_31_0:getUseRoundByHeroUid(var_31_6.heroList[iter_31_0])

				if var_31_7 and var_31_7 ~= var_31_0.currRound then
					var_31_6.heroList[iter_31_0] = "0"
				end
			end
		end

		DungeonFightController.instance:enterFightByBattleId(var_31_3.chapterId, var_31_2, var_31_1.battleId)
		arg_31_0:callShelterBackFight()
	else
		arg_31_0:callShelterBackFight()
	end
end

function var_0_0.callShelterBackFight(arg_32_0)
	if arg_32_0._shelterCallBack then
		arg_32_0._shelterCallBack(arg_32_0._shelterCallObj)
	end

	arg_32_0._shelterCallBack = nil
	arg_32_0._shelterCallObj = nil
end

function var_0_0.playSettleWork(arg_33_0, arg_33_1)
	if arg_33_0._settleFlow then
		arg_33_0._settleFlow:destroy()

		arg_33_0._settleFlow = nil
	end

	arg_33_0._settleFlow = FlowSequence.New()

	arg_33_0._settleFlow:addWork(SurvivalSettleWeekPushWork.New(arg_33_1))
	arg_33_0._settleFlow:start()
end

function var_0_0.tryShowTaskEventPanel(arg_34_0, arg_34_1, arg_34_2)
	if arg_34_1 ~= SurvivalEnum.TaskModule.StoryTask then
		return
	end

	ViewMgr.instance:openView(ViewName.SurvivalEventPanelView, {
		moduleId = arg_34_1,
		taskId = arg_34_2
	})
end

var_0_0.instance = var_0_0.New()

return var_0_0
