module("modules.logic.versionactivity2_2.act169.controller.SummonNewCustomPickChoiceController", package.seeall)

slot0 = class("SummonNewCustomPickChoiceController", BaseController)

function slot0.onSelectActivity(slot0, slot1)
	SummonNewCustomPickChoiceListModel.instance:initDatas(slot1)

	slot0._actId = slot1

	slot0:dispatchEvent(SummonNewCustomPickEvent.OnCustomPickListChanged)
end

function slot0.trySendChoice(slot0)
	if not ActivityModel.instance:getActMO(SummonNewCustomPickChoiceListModel.instance:getActivityId()) or not slot2:isOpen() or slot2:isExpired() then
		GameFacade.showToast(ToastEnum.ActivityNotInOpenTime)

		return false
	end

	if not SummonNewCustomPickChoiceListModel.instance:getSelectIds() then
		GameFacade.showToast(ToastEnum.SummonCustomPickOneMoreSelect)

		return false
	end

	if SummonNewCustomPickChoiceListModel.instance:getMaxSelectCount() > #slot3 then
		if slot4 == 1 then
			GameFacade.showToast(ToastEnum.SummonCustomPickOneMoreSelect)
		end

		return false
	end

	if SummonNewCustomPickViewModel.instance:isGetReward(slot1) then
		GameFacade.showToast(ToastEnum.ActivityRewardHasReceive)

		return false
	end

	slot6, slot7 = slot0:getConfirmParam(slot3)

	GameFacade.showMessageBox(slot6, MsgBoxEnum.BoxType.Yes_No, slot0.realSendChoice, nil, , slot0, nil, , slot0:getSelectHeroNameStr(slot3), slot7)
end

function slot0.realSendChoice(slot0)
	SummonNewCustomPickViewRpc.instance:sendAct169SummonRequest(SummonNewCustomPickViewModel.instance:getCurActId(), SummonNewCustomPickChoiceListModel.instance:getSelectIds()[1])
end

function slot0.trySendSummon(slot0)
	if not ActivityModel.instance:getActMO(SummonNewCustomPickChoiceListModel.instance:getActivityId()) or not slot2:isOpen() or slot2:isExpired() then
		GameFacade.showToast(ToastEnum.ActivityNotInOpenTime)

		return false
	end

	if SummonNewCustomPickViewModel.instance:isGetReward(slot1) then
		GameFacade.showToast(ToastEnum.ActivityRewardHasReceive)

		return false
	end

	GameFacade.showMessageBox(SummonNewCustomPickViewModel.instance:isNewbiePoolExist() == false and MessageBoxIdDefine.Act167SummonNeTip or MessageBoxIdDefine.Act167SummonNewTipWithNewBiePool, MsgBoxEnum.BoxType.Yes_No, slot0.realSendSummon, nil, , slot0, nil, , slot2.config.name)
end

function slot0.realSendSummon(slot0)
	CharacterModel.instance:setGainHeroViewShowState(true)
	SummonNewCustomPickViewRpc.instance:sendAct169SummonRequest(SummonNewCustomPickViewModel.instance:getCurActId(), 0)
end

function slot0.onGetReward(slot0, slot1, slot2)
	slot0._viewType = slot1

	if slot1 == 1 then
		ViewMgr.instance:closeView(ViewName.SummonNewCustomPickFullView)
	else
		ViewMgr.instance:closeView(ViewName.ActivityBeginnerView)
	end

	UIBlockMgr.instance:endAll()
	PostProcessingMgr.instance:forceRefreshCloseBlur()
	slot0:startBlack()
	VirtualSummonScene.instance:registerCallback(SummonSceneEvent.OnPreloadFinishAtScene, slot0._onSummonPreloadFinish, slot0)
	SummonController.instance:doVirtualSummonBehavior(slot2, true, true, slot0._onCloseSommonScene, slot0, true)
	TaskDispatcher.runDelay(slot0._onFirstLoadSceneBlock, slot0, 0.5)
	TaskDispatcher.runDelay(slot0._onSceneOpenFinish, slot0, 5)
end

function slot0._onFirstLoadSceneBlock(slot0)
	TaskDispatcher.cancelTask(slot0._onFirstLoadSceneBlock, slot0, 0.5)
	SummonController.instance:onFirstLoadSceneBlock()
end

function slot0._onSummonPreloadFinish(slot0)
	TaskDispatcher.cancelTask(slot0._onSceneOpenFinish, slot0)
	slot0:_onSceneOpenFinish()
end

function slot0._onSceneOpenFinish(slot0)
	TaskDispatcher.cancelTask(slot0._onSceneOpenFinish, slot0)
	TaskDispatcher.cancelTask(slot0._onFirstLoadSceneBlock, slot0)
	slot0:endBlack()
end

function slot0._onCloseSommonScene(slot0)
	SummonController.instance:setSummonEndOpenCallBack()
	MainController.instance:enterMainScene(true)
	VirtualSummonScene.instance:close(true)

	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Main then
		SceneHelper.instance:waitSceneDone(slot1, function ()
			uv0:onBackMainScene()
		end)
	else
		slot0:onBackMainScene()
	end
end

function slot0.onBackMainScene(slot0)
	if slot0._viewType == 1 then
		slot0:backFullPage()
	else
		slot0:backPage()
	end
end

function slot0.getSelectHeroNameStr(slot0, slot1)
	slot2 = ""

	for slot6 = 1, #slot1 do
		slot7 = HeroConfig.instance:getHeroCO(slot1[slot6])
		slot2 = (slot6 ~= 1 or slot7.name) and slot7.name .. ", " .. slot7.name
	end

	return slot2
end

function slot0.getConfirmParam(slot0)
	return MessageBoxIdDefine.SummonLuckyBagSelectChar, ActivityConfig.instance:getActivityCo(SummonNewCustomPickViewModel.instance:getCurActId()).name
end

function slot0.setSelect(slot0, slot1)
	slot3 = SummonNewCustomPickViewModel.instance:getMaxSelectCount()

	if not SummonNewCustomPickChoiceListModel.instance:isHeroIdSelected(slot1) and slot3 <= #SummonNewCustomPickChoiceListModel.instance:getSelectIds() and slot3 == 1 then
		SummonNewCustomPickChoiceListModel.instance:clearSelectIds()
	end

	SummonNewCustomPickChoiceListModel.instance:setSelectId(slot1)
	slot0:dispatchEvent(SummonNewCustomPickEvent.OnCustomPickListChanged)
end

function slot0.backPage(slot0)
	slot0:backHome()
	slot0:checkRewardPop()
	NavigateMgr.instance:registerCallback(NavigateEvent.BeforeClickHome, slot0.onClickHome, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, slot0.onCloseActivityPage, slot0)
end

function slot0.onClickHome(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, slot0.onCloseActivityPage, slot0)
end

function slot0.getCurrentListenViewName(slot0)
	if SummonNewCustomPickChoiceListModel.instance:haveAllRole() then
		return ViewName.CommonPropView
	else
		return ViewName.CommonPropView
	end
end

function slot0.onCloseActivityPage(slot0, slot1)
	if slot1 == slot0:getCurrentListenViewName() then
		slot0:startBlack()
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0.onOpenActivityPageFinish, slot0)
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, slot0.onCloseActivityPage, slot0)

		if ActivityConfig.instance:getActivityCo(slot0._actId) and slot3.achievementJumpId then
			JumpController.instance:jump(slot4)
		else
			ActivityController.instance:openActivityBeginnerView()
		end
	end
end

function slot0.onOpenActivityPageFinish(slot0, slot1)
	if slot1 == ViewName.ActivityBeginnerView then
		slot0:endBlack()
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0.onOpenActivityPage, slot0)
	end
end

function slot0.backFullPage(slot0)
	slot0:backHome()
	slot0:checkRewardPop()
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.SummonNewCustomPickFullView, {
		actId = slot0._actId,
		refreshData = false
	})
end

function slot0.backHome(slot0)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Main then
		MainController.instance:enterMainScene(true)
	end

	VirtualSummonScene.instance:close(true)
end

function slot0.setSummonReward(slot0, slot1)
	slot0._summonReward = slot1
end

function slot0.checkRewardPop(slot0)
	if slot0._summonReward and #slot0._summonReward > 0 then
		slot0:startBlack()
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0.onCommonPropViewOpenFinish, slot0)
		RoomController.instance:popUpRoomBlockPackageView(slot0._summonReward)
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, slot0._summonReward, true)
	end

	slot0._summonReward = nil
end

function slot0.onCommonPropViewOpenFinish(slot0, slot1)
	if slot1 == ViewName.CommonPropView then
		slot0:endBlack()
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0.onCommonPropViewOpenFinish, slot0)
	end
end

function slot0.startBlack(slot0)
	UIBlockHelper.instance:startBlock("SummonNewCustomPickChoiceController", 3, nil)
end

function slot0.endBlack(slot0)
	UIBlockHelper.instance:endBlock("SummonNewCustomPickChoiceController", 3)
end

slot0.instance = slot0.New()

LuaEventSystem.addEventMechanism(slot0.instance)

return slot0
