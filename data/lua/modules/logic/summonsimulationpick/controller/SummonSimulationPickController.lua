module("modules.logic.summonsimulationpick.controller.SummonSimulationPickController", package.seeall)

local var_0_0 = class("SummonSimulationPickController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.reInit(arg_4_0)
	return
end

function var_0_0.getActivityInfo(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	SummonSimulationPickRpc.instance:getInfo(arg_5_1, arg_5_2, arg_5_3)
end

function var_0_0.setCurActivityId(arg_6_0, arg_6_1)
	arg_6_0._activityId = arg_6_1
end

function var_0_0.getCurrentActivityInfo(arg_7_0)
	local var_7_0 = arg_7_0._activityId

	if not var_7_0 then
		return nil
	end

	return SummonSimulationPickModel.instance:getActInfo(var_7_0)
end

function var_0_0.setCurSelectType(arg_8_0, arg_8_1)
	arg_8_0._selectType = arg_8_1
end

function var_0_0.summonSimulation(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0:setCurActivityId(arg_9_1)

	if arg_9_2 == nil then
		arg_9_2 = true
	end

	if arg_9_2 then
		local var_9_0 = SummonSimulationPickModel.instance:getActInfo(arg_9_1)
		local var_9_1 = var_9_0:haveSaveCurrent() and MessageBoxIdDefine.SummonSimulationAgain or MessageBoxIdDefine.SummonSimulationNoSaveAgain
		local var_9_2 = var_9_0.maxCount
		local var_9_3 = var_9_0.leftTimes

		GameFacade.showMessageBox(var_9_1, MsgBoxEnum.BoxType.Yes_No, arg_9_0.realSummonSimulation, nil, nil, arg_9_0, nil, nil, var_9_3, var_9_2)

		return
	end

	arg_9_0:realSummonSimulation()
end

function var_0_0.realSummonSimulation(arg_10_0)
	local var_10_0 = arg_10_0._activityId

	arg_10_0:registerCallback(SummonSimulationEvent.onSummonSimulation, arg_10_0.onSummonSimulationSuccess, arg_10_0)
	SummonSimulationPickRpc.instance:summonSimulation(var_10_0)
end

function var_0_0.onSummonSimulationSuccess(arg_11_0, arg_11_1)
	SummonController.instance:registerCallback(SummonEvent.summonShowBlackScreen, arg_11_0.onReceiveShowBlackScreen, arg_11_0)
	SummonController.instance:registerCallback(SummonEvent.summonCloseBlackScreen, arg_11_0.onReceiveCloseBlackScreen, arg_11_0)
	SummonController.instance:registerCallback(SummonEvent.summonMainCloseImmediately, arg_11_0.closeView, arg_11_0)

	local var_11_0 = SummonSimulationPickModel.instance:getActInfo(arg_11_1).currentHeroIds

	arg_11_0:setCurrentSummonActivityId(arg_11_1)
	SummonController.instance:doVirtualSummonBehavior(var_11_0, true, true, arg_11_0.backHome, arg_11_0)
	arg_11_0:unregisterCallback(SummonSimulationEvent.onSummonSimulation, arg_11_0.onSummonSimulationSuccess, arg_11_0)
end

function var_0_0.saveResult(arg_12_0, arg_12_1)
	arg_12_0:setCurActivityId(arg_12_1)

	local var_12_0 = MessageBoxIdDefine.SummonSimulationSave

	GameFacade.showMessageBox(var_12_0, MsgBoxEnum.BoxType.Yes_No, arg_12_0.realSaveResult, nil, nil, arg_12_0)
end

function var_0_0.realSaveResult(arg_13_0)
	local var_13_0 = arg_13_0:getCurrentSummonActivityId()

	SummonSimulationPickRpc.instance:saveResult(var_13_0)
end

function var_0_0.selectResult(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	arg_14_0:setCurActivityId(arg_14_1)
	arg_14_0:setCurSelectType(arg_14_2)

	arg_14_3 = arg_14_3 or true

	if arg_14_3 then
		local var_14_0 = SummonSimulationPickModel.instance:getActInfo(arg_14_1).leftTimes
		local var_14_1 = MessageBoxIdDefine.SummonSimulationSelectWithLeftTime

		if var_14_0 <= 0 then
			var_14_1 = arg_14_2 == SummonSimulationEnum.SaveType.Saved and MessageBoxIdDefine.SummonSimulationSelectSaved or MessageBoxIdDefine.SummonSimulationSelectCurrent
		end

		GameFacade.showMessageBox(var_14_1, MsgBoxEnum.BoxType.Yes_No, arg_14_0.realSelectResult, nil, nil, arg_14_0, nil, nil, var_14_0)

		return
	end

	arg_14_0:realSelectResult()
end

function var_0_0.realSelectResult(arg_15_0)
	local var_15_0 = arg_15_0._activityId
	local var_15_1 = arg_15_0._selectType

	CharacterModel.instance:setGainHeroViewShowState(false)
	CharacterModel.instance:setGainHeroViewNewShowState(true)
	SummonSimulationPickRpc.instance:selectResult(var_15_0, var_15_1)
	arg_15_0:registerCallback(SummonSimulationEvent.onSelectResult, arg_15_0.onSelectResult, arg_15_0)
end

function var_0_0.onSelectResult(arg_16_0)
	arg_16_0:startBlack(true)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_16_0.onViewOpen, arg_16_0)
end

function var_0_0.trySummonSimulation(arg_17_0, arg_17_1)
	local var_17_0 = SummonSimulationPickModel.instance:getActInfo(arg_17_1)

	if not var_17_0.isSelect and var_17_0.leftTimes < var_17_0.maxCount then
		arg_17_0:setCurrentSummonActivityId(arg_17_1)

		local var_17_1 = #var_17_0.currentHeroIds > 0 and var_17_0.currentHeroIds or var_17_0.saveHeroIds
		local var_17_2 = SummonController.instance:getVirtualSummonResult(var_17_1, false, false)

		ViewMgr.instance:openView(ViewName.SummonSimulationResultView, {
			isReprint = true,
			summonResultList = var_17_2
		})

		return
	end

	var_0_0.instance:summonSimulation(arg_17_1, false)
end

function var_0_0.startBlack(arg_18_0, arg_18_1)
	if arg_18_1 then
		ViewMgr.instance:openView(ViewName.LoadingBlackView, nil, true)
	else
		GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.LoadingBlackView)
		GameSceneMgr.instance:showLoading(SceneType.Main)
	end
end

function var_0_0.endBlack(arg_19_0, arg_19_1)
	if arg_19_1 then
		ViewMgr.instance:closeView(ViewName.LoadingBlackView, true)
	else
		GameSceneMgr.instance:hideLoading(SceneType.Main)
	end
end

function var_0_0.closeView(arg_20_0)
	arg_20_0:endBlack()
	arg_20_0:unregisterSceneEvent()
	ViewMgr.instance:closeAllViews({
		ViewName.SummonView
	})
end

function var_0_0.setCurrentSummonActivityId(arg_21_0, arg_21_1)
	arg_21_0._currentActivityId = arg_21_1
end

function var_0_0.getCurrentSummonActivityId(arg_22_0)
	return arg_22_0._currentActivityId
end

function var_0_0.unregisterSceneEvent(arg_23_0)
	SummonController.instance:unregisterCallback(SummonEvent.summonShowBlackScreen, arg_23_0.onReceiveShowBlackScreen, arg_23_0)
	SummonController.instance:unregisterCallback(SummonEvent.summonCloseBlackScreen, arg_23_0.onReceiveCloseBlackScreen, arg_23_0)
	SummonController.instance:unregisterCallback(SummonEvent.summonMainCloseImmediately, arg_23_0.closeView, arg_23_0)
end

function var_0_0.backHome(arg_24_0)
	local var_24_0 = VirtualSummonScene.instance:isOpen()
	local var_24_1 = ViewMgr.instance:isOpen(ViewName.BackpackView)

	if var_24_0 and not var_24_1 then
		arg_24_0:startBlack(true)
	end

	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Main then
		MainController.instance:enterMainScene(true)
	end

	VirtualSummonScene.instance:close(true)

	if not var_24_1 then
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_24_0.onViewOpen, arg_24_0)
		BackpackController.instance:enterItemBackpack(ItemEnum.CategoryType.UseType)
	end
end

function var_0_0.onViewClose(arg_25_0, arg_25_1)
	if arg_25_1 == ViewName.CommonPropView then
		arg_25_0:endBlack(true)
	end
end

function var_0_0.onViewOpen(arg_26_0, arg_26_1)
	if arg_26_1 == ViewName.BackpackView or arg_26_1 == ViewName.CharacterGetView or arg_26_1 == ViewName.CommonPropView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, arg_26_0.onViewOpen, arg_26_0)
		arg_26_0:endBlack(true)
	end
end

function var_0_0.openSummonTips(arg_27_0, arg_27_1)
	logNormal("Click SummonSimulationTips actId: " .. arg_27_1)

	local var_27_0 = SummonSimulationPickConfig.instance:getSummonConfigById(arg_27_1)
	local var_27_1 = SummonConfig.instance:getSummonPool(var_27_0.poolId)

	SummonMainController.instance:openSummonDetail(var_27_1, nil, var_27_0.activityId)
end

function var_0_0.onReceiveShowBlackScreen(arg_28_0)
	logNormal("SummonSimulationPickController onReceiveShowBlackScreen")
	arg_28_0:startBlack()
	TaskDispatcher.runDelay(arg_28_0.afterBlackLoading, arg_28_0, 0.3)
end

function var_0_0.afterBlackLoading(arg_29_0)
	logNormal("SummonSimulationPickController afterBlackLoading")
	TaskDispatcher.cancelTask(arg_29_0.afterBlackLoading, arg_29_0)
	SummonController.instance:onFirstLoadSceneBlock()
end

function var_0_0.onReceiveCloseBlackScreen(arg_30_0)
	logNormal("SummonSimulationPickController onReceiveCloseBlackScreen")
	arg_30_0:closeView()
end

var_0_0.instance = var_0_0.New()

return var_0_0
