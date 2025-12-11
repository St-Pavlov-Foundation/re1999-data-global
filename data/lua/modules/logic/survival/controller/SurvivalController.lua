module("modules.logic.survival.controller.SurvivalController", package.seeall)

local var_0_0 = class("SurvivalController", BaseController)

function var_0_0.reInit(arg_1_0)
	if arg_1_0._settleFlow then
		arg_1_0._settleFlow:destroy()

		arg_1_0._settleFlow = nil
	end

	TaskDispatcher.cancelTask(arg_1_0.onDelayPopupFinishEvent, arg_1_0)
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
	if not arg_5_1 or arg_5_1 == VersionActivity3_1Enum.ActivityId.Survival then
		arg_5_0:_getInfo()
	end
end

function var_0_0._getInfo(arg_6_0)
	if not ActivityHelper.isOpen(VersionActivity3_1Enum.ActivityId.Survival) then
		return
	end

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Survival) then
		return
	end

	SurvivalOutSideRpc.instance:sendSurvivalOutSideGetInfo()
end

function var_0_0.openSurvivalView(arg_7_0, arg_7_1)
	if arg_7_1 then
		SurvivalOutSideRpc.instance:sendSurvivalOutSideGetInfo(arg_7_0._openSurvivalView, arg_7_0)
	else
		arg_7_0:_openSurvivalView()
	end
end

function var_0_0._openSurvivalView(arg_8_0)
	ViewMgr.instance:openView(ViewName.SurvivalView)
end

function var_0_0.enterSurvivalMap(arg_9_0, arg_9_1)
	SurvivalInteriorRpc.instance:sendEnterSurvival(arg_9_1, arg_9_0._onEnterSurvival, arg_9_0)
end

function var_0_0._onRecvGMMsg(arg_10_0)
	SurvivalMapHelper.instance:tryStartFlow("")
end

function var_0_0._onEnterSurvival(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if arg_11_2 == 0 then
		if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Survival then
			GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.SurvivalLoadingView)
			GameSceneMgr.instance:startScene(SceneType.Survival, 280001, 280001, true, true)
		else
			logError("重复进入探索场景")
		end
	elseif GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		arg_11_0:exitMap()
	end
end

function var_0_0.enterShelterMap(arg_12_0, arg_12_1)
	arg_12_0._isExitFight = arg_12_1

	if SurvivalModel.instance:getSurvivalSettleInfo() ~= nil and arg_12_0._isExitFight then
		arg_12_0:enterSurvivalShelterScene()

		return
	end

	SurvivalWeekRpc.instance:sendSurvivalGetWeekInfo(arg_12_0._onEnterShelter, arg_12_0)
end

function var_0_0._onEnterShelter(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if arg_13_2 == 0 then
		if SurvivalShelterModel.instance:getWeekInfo().inSurvival then
			arg_13_0:enterSurvivalMap()
		else
			arg_13_0:enterSurvivalShelterScene()
		end
	end
end

function var_0_0.enterSurvivalShelterScene(arg_14_0)
	local var_14_0 = SurvivalShelterModel.instance:getWeekInfo().intrudeBox.fight
	local var_14_1 = SurvivalModel.instance:getSurvivalSettleInfo()

	if arg_14_0._isExitFight and var_14_0 and var_14_0:isFighting() and not var_14_1 then
		SurvivalModel.instance:setBossFightLastIndex(var_14_0.currRound - 1)

		local var_14_2 = GameSceneMgr.instance:getPreSceneType()
		local var_14_3 = GameSceneMgr.instance:getPreSceneId()
		local var_14_4 = GameSceneMgr.instance:getPreLevelId()

		GameSceneMgr.instance:closeScene(nil, nil, nil, true)
		GameSceneMgr.instance:setPrevScene(var_14_2, var_14_3, var_14_4)
		arg_14_0:tryEnterShelterFight()
	elseif var_0_0.instance:isPlaySummaryAct() then
		if GameSceneMgr.instance:getCurSceneType() ~= SceneType.SurvivalSummaryAct then
			GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.SurvivalLoadingView)
			GameSceneMgr.instance:startScene(SceneType.SurvivalSummaryAct, 280001, 280001, true, true)
		else
			logError("重复加载SurvivalSummaryAct场景")
		end
	elseif GameSceneMgr.instance:getCurSceneType() ~= SceneType.SurvivalShelter then
		GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.SurvivalLoadingView)
		GameSceneMgr.instance:startScene(SceneType.SurvivalShelter, 280001, 280001, true, true)
	else
		logError("重复加载避难所场景")
	end
end

function var_0_0.showToast(arg_15_0, arg_15_1)
	if not ViewMgr.instance:isOpen(ViewName.SurvivalToastView) then
		table.insert(SurvivalMapModel.instance.showToastList, arg_15_1)
		ViewMgr.instance:openView(ViewName.SurvivalToastView)
	elseif ViewMgr.instance:isOpening(ViewName.SurvivalToastView) then
		table.insert(SurvivalMapModel.instance.showToastList, arg_15_1)
	else
		arg_15_0:dispatchEvent(SurvivalEvent.ShowToast, arg_15_1)
	end
end

function var_0_0.exitMap(arg_16_0)
	local var_16_0 = GameSceneMgr.instance:getCurSceneType()

	if var_16_0 == SceneType.SurvivalSummaryAct then
		arg_16_0:enterSurvivalShelterScene()

		return
	end

	local var_16_1 = SurvivalModel.instance:getOutSideInfo()
	local var_16_2 = SurvivalShelterModel.instance:getWeekInfo()
	local var_16_3 = var_16_2 and var_16_2.inSurvival

	DungeonModel.instance.curSendEpisodeId = nil

	if var_16_0 == SceneType.Survival and var_16_1.inWeek and not var_16_3 then
		arg_16_0:enterShelterMap()

		return
	end

	MainController.instance:enterMainScene()
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.SurvivalView)
		VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(nil, nil, VersionActivity3_1Enum.ActivityId.Survival, true)
		var_0_0.instance:openSurvivalView(true)
	end)
end

function var_0_0.openEquipView(arg_18_0)
	SurvivalWeekRpc.instance:sendSurvivalGetEquipInfo(arg_18_0.onRecvEquipInfo, arg_18_0)
end

function var_0_0.onRecvEquipInfo(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	ViewMgr.instance:openView(ViewName.SurvivalEquipView)
end

function var_0_0.tryEnterSurvivalFight(arg_20_0, arg_20_1, arg_20_2)
	arg_20_0._callback = arg_20_1
	arg_20_0._callobj = arg_20_2

	local var_20_0 = SurvivalModel.instance:getOutSideInfo()

	if not var_20_0 or not var_20_0.inWeek then
		logError("不在避难所中，重连不了战斗！！！！")
		arg_20_0:callBackReconnectFight()

		return
	end

	SurvivalWeekRpc.instance:sendSurvivalGetWeekInfo(arg_20_0._onRecvWeekInfo, arg_20_0)
end

function var_0_0._onRecvWeekInfo(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	if arg_21_2 == 0 then
		local var_21_0 = SurvivalShelterModel.instance:getWeekInfo()

		if var_21_0.inSurvival then
			SurvivalInteriorRpc.instance:sendEnterSurvival(nil, arg_21_0._onRecvMapInfo, arg_21_0)
		else
			local var_21_1 = var_21_0.intrudeBox.fight.fightCo
			local var_21_2 = var_21_1 and var_21_1.battleId or 0

			FightController.instance:setFightParamByEpisodeBattleId(SurvivalConst.Shelter_EpisodeId, var_21_2)
			arg_21_0:callBackReconnectFight()
		end
	else
		arg_21_0:callBackReconnectFight()
	end
end

function var_0_0._onRecvMapInfo(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	if arg_22_2 == 0 then
		local var_22_0 = SurvivalMapModel.instance:getSceneMo().battleInfo.battleId

		if var_22_0 == 0 then
			logError("没有battleId，为什么会有战斗！！！！")
		else
			FightController.instance:setFightParamByEpisodeBattleId(SurvivalConst.Survival_EpisodeId, var_22_0)
		end

		arg_22_0:callBackReconnectFight()
	else
		arg_22_0:callBackReconnectFight()
	end
end

function var_0_0.callBackReconnectFight(arg_23_0)
	if arg_23_0._callback then
		arg_23_0._callback(arg_23_0._callobj)
	end

	arg_23_0._callback = nil
	arg_23_0._callobj = nil
end

function var_0_0.openDecreeSelectView(arg_24_0)
	local var_24_0 = SurvivalShelterModel.instance:getWeekInfo():getDecreeBox()
	local var_24_1

	for iter_24_0 = 1, 3 do
		local var_24_2 = var_24_0:getDecreeInfo(iter_24_0)

		if not var_24_2 or var_24_2:isCurPolicyEmpty() then
			var_24_1 = iter_24_0

			break
		end
	end

	if not var_24_1 then
		return
	end

	local var_24_3 = var_24_0:getDecreeInfo(var_24_1)

	if var_24_3 and var_24_3:hasOptions() then
		ViewMgr.instance:openView(ViewName.SurvivalDecreeSelectView, {
			decreeInfo = var_24_3
		})
	else
		SurvivalWeekRpc.instance:sendSurvivalDecreePromulgateRequest(var_24_1, arg_24_0._openDecreeSelectView, arg_24_0)
	end
end

function var_0_0._openDecreeSelectView(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	if arg_25_2 == 0 then
		local var_25_0 = SurvivalShelterModel.instance:getWeekInfo():getDecreeBox():getDecreeInfo(arg_25_3.decree.no)

		ViewMgr.instance:openView(ViewName.SurvivalDecreeSelectView, {
			decreeInfo = var_25_0
		})
	end
end

function var_0_0.startDecreeVote(arg_26_0, arg_26_1)
	ViewMgr.instance:closeAllModalViews()
	ViewMgr.instance:closeAllPopupViews()
	PopupController.instance:setPause(ViewName.SurvivalDecreeVoteView, true)

	if not arg_26_1 then
		local var_26_0 = SurvivalShelterModel.instance:getWeekInfo():getDecreeBox()
		local var_26_1, var_26_2 = var_26_0:isCurAllPolicyNotFinish()

		arg_26_1 = var_26_0:getDecreeInfo(var_26_2)
	end

	ViewMgr.instance:openView(ViewName.SurvivalDecreeVoteView, {
		decreeInfo = arg_26_1
	})
end

function var_0_0.enterSurvival(arg_27_0)
	if SurvivalShelterModel.instance:getWeekInfo():isInFight() then
		GameFacade.showMessageBox(MessageBoxIdDefine.SurvivalHaveBossFightSure, MsgBoxEnum.BoxType.Yes_No, arg_27_0._sendAbandon, nil, nil, arg_27_0, nil, nil)

		return
	end

	arg_27_0:openSurvivalInitTeamView()
end

function var_0_0.openSurvivalInitTeamView(arg_28_0)
	SurvivalMapModel.instance:getInitGroup():init()
	ViewMgr.instance:openView(ViewName.SurvivalInitTeamView)
end

function var_0_0._sendAbandon(arg_29_0)
	UIBlockHelper.instance:startBlock(SurvivalEnum.SurvivalIntrudeAbandonBlock)
	SurvivalWeekRpc.instance:sendSurvivalIntrudeAbandonExterminateRequest()
end

function var_0_0.startNewWeek(arg_30_0)
	local var_30_0 = SurvivalModel.instance:getOutSideInfo()

	if var_30_0 then
		var_30_0.inWeek = true
	end
end

function var_0_0.enterSurvivalSettle(arg_31_0)
	local var_31_0 = SurvivalModel.instance:getSurvivalSettleInfo()

	if var_31_0 ~= nil then
		ViewMgr.instance:openView(ViewName.SurvivalCeremonyClosingView, {
			isWin = var_31_0.win,
			score = var_31_0.score,
			report = var_31_0.report
		})
		SurvivalModel.instance:setSurvivalSettleInfo(nil)
	end
end

function var_0_0.tryEnterShelterFight(arg_32_0, arg_32_1, arg_32_2)
	arg_32_0._shelterCallBack = arg_32_1
	arg_32_0._shelterCallObj = arg_32_2

	HeroGroupRpc.instance:sendGetHeroGroupSnapshotListRequest(ModuleEnum.HeroGroupSnapshotType.Shelter, arg_32_0._onRecvMsg, arg_32_0)
end

function var_0_0._onRecvMsg(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	if arg_33_2 == 0 then
		local var_33_0 = SurvivalShelterModel.instance:getWeekInfo().intrudeBox.fight
		local var_33_1 = var_33_0.fightCo
		local var_33_2 = SurvivalConst.Shelter_EpisodeId
		local var_33_3 = DungeonConfig.instance:getEpisodeCO(var_33_2)
		local var_33_4 = SurvivalModel.instance:getBossFightLastIndex()
		local var_33_5 = var_33_4 == nil and var_33_0.currRound or var_33_4

		HeroGroupSnapshotModel.instance:setSelectIndex(ModuleEnum.HeroGroupSnapshotType.Shelter, var_33_5)

		local var_33_6 = HeroGroupSnapshotModel.instance:getHeroGroupInfo(ModuleEnum.HeroGroupSnapshotType.Shelter, var_33_0.currRound)

		if var_33_6 then
			for iter_33_0 = 1, #var_33_6.heroList do
				local var_33_7 = var_33_0:getUseRoundByHeroUid(var_33_6.heroList[iter_33_0])

				if var_33_7 and var_33_7 ~= var_33_0.currRound then
					var_33_6.heroList[iter_33_0] = "0"
				end
			end
		end

		DungeonFightController.instance:enterFightByBattleId(var_33_3.chapterId, var_33_2, var_33_1.battleId)
		arg_33_0:callShelterBackFight()
	else
		arg_33_0:callShelterBackFight()
	end
end

function var_0_0.callShelterBackFight(arg_34_0)
	if arg_34_0._shelterCallBack then
		arg_34_0._shelterCallBack(arg_34_0._shelterCallObj)
	end

	arg_34_0._shelterCallBack = nil
	arg_34_0._shelterCallObj = nil
end

function var_0_0.playSettleWork(arg_35_0, arg_35_1)
	if arg_35_0._settleFlow then
		arg_35_0._settleFlow:destroy()

		arg_35_0._settleFlow = nil
	end

	arg_35_0._settleFlow = FlowSequence.New()

	arg_35_0._settleFlow:addWork(SurvivalSettleWeekPushWork.New(arg_35_1))
	arg_35_0._settleFlow:start()
end

function var_0_0.tryShowTaskEventPanel(arg_36_0, arg_36_1, arg_36_2)
	if arg_36_1 ~= SurvivalEnum.TaskModule.StoryTask then
		return
	end

	ViewMgr.instance:openView(ViewName.SurvivalEventPanelView, {
		moduleId = arg_36_1,
		taskId = arg_36_2
	})
end

function var_0_0.sendOpenSurvivalRewardInheritView(arg_37_0, arg_37_1, arg_37_2)
	arg_37_0.inheritViewParam = arg_37_2 or {}
	arg_37_0.inheritViewParam.handbookType = arg_37_1

	SurvivalOutSideRpc.instance:sendSurvivalOutSideGetInfo(arg_37_0._openSurvivalRewardInheritView, arg_37_0)
end

function var_0_0._openSurvivalRewardInheritView(arg_38_0)
	ViewMgr.instance:openView(ViewName.SurvivalRewardInheritView, arg_38_0.inheritViewParam)
end

function var_0_0.isPlaySummaryAct(arg_39_0)
	return GameSceneMgr.instance:getCurSceneType() == SceneType.Survival and #SurvivalMapModel.instance.resultData.afterNpcs > 0
end

function var_0_0.playSummaryAct(arg_40_0)
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.SurvivalSummaryActView)
end

function var_0_0.onScenePopupFinish(arg_41_0)
	TaskDispatcher.runDelay(arg_41_0.onDelayPopupFinishEvent, arg_41_0, 0.767)
end

function var_0_0.onDelayPopupFinishEvent(arg_42_0)
	arg_42_0:dispatchEvent(SurvivalEvent.OnDelayPopupFinishEvent)
	SurvivalShelterModel.instance:getWeekInfo().clientData:saveDataToServer()
end

var_0_0.instance = var_0_0.New()

return var_0_0
