module("modules.logic.summonsimulationpick.controller.SummonSimulationPickController", package.seeall)

slot0 = class("SummonSimulationPickController", BaseController)

function slot0.onInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.reInit(slot0)
end

function slot0.getActivityInfo(slot0, slot1, slot2, slot3)
	SummonSimulationPickRpc.instance:getInfo(slot1, slot2, slot3)
end

function slot0.setCurActivityId(slot0, slot1)
	slot0._activityId = slot1
end

function slot0.getCurrentActivityInfo(slot0)
	if not slot0._activityId then
		return nil
	end

	return SummonSimulationPickModel.instance:getActInfo(slot1)
end

function slot0.setCurSelectType(slot0, slot1)
	slot0._selectType = slot1
end

function slot0.summonSimulation(slot0, slot1, slot2)
	slot0:setCurActivityId(slot1)

	if slot2 == nil then
		slot2 = true
	end

	if slot2 then
		GameFacade.showMessageBox(SummonSimulationPickModel.instance:getActInfo(slot1):haveSaveCurrent() and MessageBoxIdDefine.SummonSimulationAgain or MessageBoxIdDefine.SummonSimulationNoSaveAgain, MsgBoxEnum.BoxType.Yes_No, slot0.realSummonSimulation, nil, , slot0, nil, , slot3.leftTimes, slot3.maxCount)

		return
	end

	slot0:realSummonSimulation()
end

function slot0.realSummonSimulation(slot0)
	slot0:registerCallback(SummonSimulationEvent.onSummonSimulation, slot0.onSummonSimulationSuccess, slot0)
	SummonSimulationPickRpc.instance:summonSimulation(slot0._activityId)
end

function slot0.onSummonSimulationSuccess(slot0, slot1)
	SummonController.instance:registerCallback(SummonEvent.summonShowBlackScreen, slot0.onReceiveShowBlackScreen, slot0)
	SummonController.instance:registerCallback(SummonEvent.summonCloseBlackScreen, slot0.onReceiveCloseBlackScreen, slot0)
	SummonController.instance:registerCallback(SummonEvent.summonMainCloseImmediately, slot0.closeView, slot0)
	slot0:setCurrentSummonActivityId(slot1)
	SummonController.instance:doVirtualSummonBehavior(SummonSimulationPickModel.instance:getActInfo(slot1).currentHeroIds, true, true, slot0.backHome, slot0)
	slot0:unregisterCallback(SummonSimulationEvent.onSummonSimulation, slot0.onSummonSimulationSuccess, slot0)
end

function slot0.saveResult(slot0, slot1)
	slot0:setCurActivityId(slot1)
	GameFacade.showMessageBox(MessageBoxIdDefine.SummonSimulationSave, MsgBoxEnum.BoxType.Yes_No, slot0.realSaveResult, nil, , slot0)
end

function slot0.realSaveResult(slot0)
	SummonSimulationPickRpc.instance:saveResult(slot0:getCurrentSummonActivityId())
end

function slot0.selectResult(slot0, slot1, slot2, slot3)
	slot0:setCurActivityId(slot1)
	slot0:setCurSelectType(slot2)

	if slot3 or true then
		slot6 = MessageBoxIdDefine.SummonSimulationSelectWithLeftTime

		if SummonSimulationPickModel.instance:getActInfo(slot1).leftTimes <= 0 then
			slot6 = slot2 == SummonSimulationEnum.SaveType.Saved and MessageBoxIdDefine.SummonSimulationSelectSaved or MessageBoxIdDefine.SummonSimulationSelectCurrent
		end

		GameFacade.showMessageBox(slot6, MsgBoxEnum.BoxType.Yes_No, slot0.realSelectResult, nil, , slot0, nil, , slot5)

		return
	end

	slot0:realSelectResult()
end

function slot0.realSelectResult(slot0)
	CharacterModel.instance:setGainHeroViewShowState(false)
	CharacterModel.instance:setGainHeroViewNewShowState(true)
	SummonSimulationPickRpc.instance:selectResult(slot0._activityId, slot0._selectType)
	slot0:registerCallback(SummonSimulationEvent.onSelectResult, slot0.onSelectResult, slot0)
end

function slot0.onSelectResult(slot0)
	slot0:startBlack(true)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0.onViewOpen, slot0)
end

function slot0.trySummonSimulation(slot0, slot1)
	if not SummonSimulationPickModel.instance:getActInfo(slot1).isSelect and slot2.leftTimes < slot2.maxCount then
		slot0:setCurrentSummonActivityId(slot1)
		ViewMgr.instance:openView(ViewName.SummonSimulationResultView, {
			isReprint = true,
			summonResultList = SummonController.instance:getVirtualSummonResult(#slot2.currentHeroIds > 0 and slot2.currentHeroIds or slot2.saveHeroIds, false, false)
		})

		return
	end

	uv0.instance:summonSimulation(slot1, false)
end

function slot0.startBlack(slot0, slot1)
	if slot1 then
		ViewMgr.instance:openView(ViewName.LoadingBlackView, nil, true)
	else
		GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.LoadingBlackView)
		GameSceneMgr.instance:showLoading(SceneType.Main)
	end
end

function slot0.endBlack(slot0, slot1)
	if slot1 then
		ViewMgr.instance:closeView(ViewName.LoadingBlackView, true)
	else
		GameSceneMgr.instance:hideLoading(SceneType.Main)
	end
end

function slot0.closeView(slot0)
	slot0:endBlack()
	slot0:unregisterSceneEvent()
	ViewMgr.instance:closeAllViews({
		ViewName.SummonView
	})
end

function slot0.setCurrentSummonActivityId(slot0, slot1)
	slot0._currentActivityId = slot1
end

function slot0.getCurrentSummonActivityId(slot0)
	return slot0._currentActivityId
end

function slot0.unregisterSceneEvent(slot0)
	SummonController.instance:unregisterCallback(SummonEvent.summonShowBlackScreen, slot0.onReceiveShowBlackScreen, slot0)
	SummonController.instance:unregisterCallback(SummonEvent.summonCloseBlackScreen, slot0.onReceiveCloseBlackScreen, slot0)
	SummonController.instance:unregisterCallback(SummonEvent.summonMainCloseImmediately, slot0.closeView, slot0)
end

function slot0.backHome(slot0)
	if VirtualSummonScene.instance:isOpen() and not ViewMgr.instance:isOpen(ViewName.BackpackView) then
		slot0:startBlack(true)
	end

	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Main then
		MainController.instance:enterMainScene(true)
	end

	VirtualSummonScene.instance:close(true)

	if not slot2 then
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0.onViewOpen, slot0)
		BackpackController.instance:enterItemBackpack(ItemEnum.CategoryType.UseType)
	end
end

function slot0.onViewClose(slot0, slot1)
	if slot1 == ViewName.CommonPropView then
		slot0:endBlack(true)
	end
end

function slot0.onViewOpen(slot0, slot1)
	if slot1 == ViewName.BackpackView or slot1 == ViewName.CharacterGetView or slot1 == ViewName.CommonPropView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, slot0.onViewOpen, slot0)
		slot0:endBlack(true)
	end
end

function slot0.openSummonTips(slot0, slot1)
	logNormal("Click SummonSimulationTips actId: " .. slot1)

	slot2 = SummonSimulationPickConfig.instance:getSummonConfigById(slot1)

	SummonMainController.instance:openSummonDetail(SummonConfig.instance:getSummonPool(slot2.poolId), nil, slot2.activityId)
end

function slot0.onReceiveShowBlackScreen(slot0)
	logNormal("SummonSimulationPickController onReceiveShowBlackScreen")
	slot0:startBlack()
	TaskDispatcher.runDelay(slot0.afterBlackLoading, slot0, 0.3)
end

function slot0.afterBlackLoading(slot0)
	logNormal("SummonSimulationPickController afterBlackLoading")
	TaskDispatcher.cancelTask(slot0.afterBlackLoading, slot0)
	SummonController.instance:onFirstLoadSceneBlock()
end

function slot0.onReceiveCloseBlackScreen(slot0)
	logNormal("SummonSimulationPickController onReceiveCloseBlackScreen")
	slot0:closeView()
end

slot0.instance = slot0.New()

return slot0
