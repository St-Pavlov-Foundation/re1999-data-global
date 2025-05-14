module("modules.logic.versionactivity2_2.act169.controller.SummonNewCustomPickChoiceController", package.seeall)

local var_0_0 = class("SummonNewCustomPickChoiceController", BaseController)

function var_0_0.onSelectActivity(arg_1_0, arg_1_1)
	SummonNewCustomPickChoiceListModel.instance:initDatas(arg_1_1)

	arg_1_0._actId = arg_1_1

	arg_1_0:dispatchEvent(SummonNewCustomPickEvent.OnCustomPickListChanged)
end

function var_0_0.trySendChoice(arg_2_0)
	local var_2_0 = SummonNewCustomPickChoiceListModel.instance:getActivityId()
	local var_2_1 = ActivityModel.instance:getActMO(var_2_0)

	if not var_2_1 or not var_2_1:isOpen() or var_2_1:isExpired() then
		GameFacade.showToast(ToastEnum.ActivityNotInOpenTime)

		return false
	end

	local var_2_2 = SummonNewCustomPickChoiceListModel.instance:getSelectIds()

	if not var_2_2 then
		GameFacade.showToast(ToastEnum.SummonCustomPickOneMoreSelect)

		return false
	end

	local var_2_3 = SummonNewCustomPickChoiceListModel.instance:getMaxSelectCount()

	if var_2_3 > #var_2_2 then
		if var_2_3 == 1 then
			GameFacade.showToast(ToastEnum.SummonCustomPickOneMoreSelect)
		end

		return false
	end

	if SummonNewCustomPickViewModel.instance:isGetReward(var_2_0) then
		GameFacade.showToast(ToastEnum.ActivityRewardHasReceive)

		return false
	end

	local var_2_4 = arg_2_0:getSelectHeroNameStr(var_2_2)
	local var_2_5, var_2_6 = arg_2_0:getConfirmParam(var_2_2)

	GameFacade.showMessageBox(var_2_5, MsgBoxEnum.BoxType.Yes_No, arg_2_0.realSendChoice, nil, nil, arg_2_0, nil, nil, var_2_4, var_2_6)
end

function var_0_0.realSendChoice(arg_3_0)
	local var_3_0 = SummonNewCustomPickChoiceListModel.instance:getSelectIds()
	local var_3_1 = SummonNewCustomPickViewModel.instance:getCurActId()
	local var_3_2 = var_3_0[1]

	SummonNewCustomPickViewRpc.instance:sendAct169SummonRequest(var_3_1, var_3_2)
end

function var_0_0.trySendSummon(arg_4_0)
	local var_4_0 = SummonNewCustomPickChoiceListModel.instance:getActivityId()
	local var_4_1 = ActivityModel.instance:getActMO(var_4_0)

	if not var_4_1 or not var_4_1:isOpen() or var_4_1:isExpired() then
		GameFacade.showToast(ToastEnum.ActivityNotInOpenTime)

		return false
	end

	if SummonNewCustomPickViewModel.instance:isGetReward(var_4_0) then
		GameFacade.showToast(ToastEnum.ActivityRewardHasReceive)

		return false
	end

	local var_4_2 = SummonNewCustomPickViewModel.instance:isNewbiePoolExist() == false and MessageBoxIdDefine.Act167SummonNeTip or MessageBoxIdDefine.Act167SummonNewTipWithNewBiePool

	GameFacade.showMessageBox(var_4_2, MsgBoxEnum.BoxType.Yes_No, arg_4_0.realSendSummon, nil, nil, arg_4_0, nil, nil, var_4_1.config.name)
end

function var_0_0.realSendSummon(arg_5_0)
	local var_5_0 = SummonNewCustomPickViewModel.instance:getCurActId()

	CharacterModel.instance:setGainHeroViewShowState(true)
	SummonNewCustomPickViewRpc.instance:sendAct169SummonRequest(var_5_0, 0)
end

function var_0_0.onGetReward(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0._viewType = arg_6_1

	if arg_6_1 == 1 then
		ViewMgr.instance:closeView(ViewName.SummonNewCustomPickFullView)
	else
		ViewMgr.instance:closeView(ViewName.ActivityBeginnerView)
	end

	UIBlockMgr.instance:endAll()
	PostProcessingMgr.instance:forceRefreshCloseBlur()
	arg_6_0:startBlack()
	VirtualSummonScene.instance:registerCallback(SummonSceneEvent.OnPreloadFinishAtScene, arg_6_0._onSummonPreloadFinish, arg_6_0)
	SummonController.instance:doVirtualSummonBehavior(arg_6_2, true, true, arg_6_0._onCloseSommonScene, arg_6_0, true)
	TaskDispatcher.runDelay(arg_6_0._onFirstLoadSceneBlock, arg_6_0, 0.5)
	TaskDispatcher.runDelay(arg_6_0._onSceneOpenFinish, arg_6_0, 5)
end

function var_0_0._onFirstLoadSceneBlock(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0._onFirstLoadSceneBlock, arg_7_0, 0.5)
	SummonController.instance:onFirstLoadSceneBlock()
end

function var_0_0._onSummonPreloadFinish(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._onSceneOpenFinish, arg_8_0)
	arg_8_0:_onSceneOpenFinish()
end

function var_0_0._onSceneOpenFinish(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._onSceneOpenFinish, arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._onFirstLoadSceneBlock, arg_9_0)
	arg_9_0:endBlack()
end

function var_0_0._onCloseSommonScene(arg_10_0)
	local var_10_0 = SceneType.Main

	SummonController.instance:setSummonEndOpenCallBack()
	MainController.instance:enterMainScene(true)
	VirtualSummonScene.instance:close(true)

	if GameSceneMgr.instance:getCurSceneType() ~= var_10_0 then
		SceneHelper.instance:waitSceneDone(var_10_0, function()
			arg_10_0:onBackMainScene()
		end)
	else
		arg_10_0:onBackMainScene()
	end
end

function var_0_0.onBackMainScene(arg_12_0)
	if arg_12_0._viewType == 1 then
		arg_12_0:backFullPage()
	else
		arg_12_0:backPage()
	end
end

function var_0_0.getSelectHeroNameStr(arg_13_0, arg_13_1)
	local var_13_0 = ""

	for iter_13_0 = 1, #arg_13_1 do
		local var_13_1 = HeroConfig.instance:getHeroCO(arg_13_1[iter_13_0])

		if iter_13_0 == 1 then
			var_13_0 = var_13_1.name
		else
			var_13_0 = var_13_0 .. ", " .. var_13_1.name
		end
	end

	return var_13_0
end

function var_0_0.getConfirmParam(arg_14_0)
	local var_14_0 = SummonNewCustomPickViewModel.instance:getCurActId()
	local var_14_1 = ActivityConfig.instance:getActivityCo(var_14_0)

	return MessageBoxIdDefine.SummonLuckyBagSelectChar, var_14_1.name
end

function var_0_0.setSelect(arg_15_0, arg_15_1)
	local var_15_0 = SummonNewCustomPickChoiceListModel.instance:getSelectIds()
	local var_15_1 = SummonNewCustomPickViewModel.instance:getMaxSelectCount()

	if not SummonNewCustomPickChoiceListModel.instance:isHeroIdSelected(arg_15_1) and var_15_1 <= #var_15_0 and var_15_1 == 1 then
		SummonNewCustomPickChoiceListModel.instance:clearSelectIds()
	end

	SummonNewCustomPickChoiceListModel.instance:setSelectId(arg_15_1)
	arg_15_0:dispatchEvent(SummonNewCustomPickEvent.OnCustomPickListChanged)
end

function var_0_0.backPage(arg_16_0)
	arg_16_0:backHome()
	arg_16_0:checkRewardPop()
	NavigateMgr.instance:registerCallback(NavigateEvent.BeforeClickHome, arg_16_0.onClickHome, arg_16_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_16_0.onCloseActivityPage, arg_16_0)
end

function var_0_0.onClickHome(arg_17_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, arg_17_0.onCloseActivityPage, arg_17_0)
end

function var_0_0.getCurrentListenViewName(arg_18_0)
	if SummonNewCustomPickChoiceListModel.instance:haveAllRole() then
		return ViewName.CommonPropView
	else
		return ViewName.CommonPropView
	end
end

function var_0_0.onCloseActivityPage(arg_19_0, arg_19_1)
	if arg_19_1 == arg_19_0:getCurrentListenViewName() then
		arg_19_0:startBlack()
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_19_0.onOpenActivityPageFinish, arg_19_0)
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, arg_19_0.onCloseActivityPage, arg_19_0)

		local var_19_0 = ActivityConfig.instance:getActivityCo(arg_19_0._actId)
		local var_19_1 = var_19_0 and var_19_0.achievementJumpId

		if var_19_1 then
			JumpController.instance:jump(var_19_1)
		else
			ActivityController.instance:openActivityBeginnerView()
		end
	end
end

function var_0_0.onOpenActivityPageFinish(arg_20_0, arg_20_1)
	if arg_20_1 == ViewName.ActivityBeginnerView then
		arg_20_0:endBlack()
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_20_0.onOpenActivityPage, arg_20_0)
	end
end

function var_0_0.backFullPage(arg_21_0)
	arg_21_0:backHome()
	arg_21_0:checkRewardPop()

	local var_21_0 = arg_21_0._actId
	local var_21_1 = {
		actId = var_21_0
	}

	var_21_1.refreshData = false

	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.SummonNewCustomPickFullView, var_21_1)
end

function var_0_0.backHome(arg_22_0)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Main then
		MainController.instance:enterMainScene(true)
	end

	VirtualSummonScene.instance:close(true)
end

function var_0_0.setSummonReward(arg_23_0, arg_23_1)
	arg_23_0._summonReward = arg_23_1
end

function var_0_0.checkRewardPop(arg_24_0)
	if arg_24_0._summonReward and #arg_24_0._summonReward > 0 then
		arg_24_0:startBlack()
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_24_0.onCommonPropViewOpenFinish, arg_24_0)
		RoomController.instance:popUpRoomBlockPackageView(arg_24_0._summonReward)
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, arg_24_0._summonReward, true)
	end

	arg_24_0._summonReward = nil
end

function var_0_0.onCommonPropViewOpenFinish(arg_25_0, arg_25_1)
	if arg_25_1 == ViewName.CommonPropView then
		arg_25_0:endBlack()
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_25_0.onCommonPropViewOpenFinish, arg_25_0)
	end
end

function var_0_0.startBlack(arg_26_0)
	UIBlockHelper.instance:startBlock("SummonNewCustomPickChoiceController", 3, nil)
end

function var_0_0.endBlack(arg_27_0)
	UIBlockHelper.instance:endBlock("SummonNewCustomPickChoiceController", 3)
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0
