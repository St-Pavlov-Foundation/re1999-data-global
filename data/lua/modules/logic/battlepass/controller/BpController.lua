module("modules.logic.battlepass.controller.BpController", package.seeall)

slot0 = class("BpController", BaseController)

function slot0.addConstEvents(slot0)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, slot0._onUpdateTaskList, slot0)
	TaskController.instance:registerCallback(TaskEvent.OnDeleteTask, slot0._onDeleteTaskList, slot0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0.dailyRefresh, slot0)
	LoginController.instance:registerCallback(LoginEvent.OnGetInfoFinish, slot0._getBpInfo, slot0)
end

function slot0.openBattlePassView(slot0, slot1, slot2, slot3)
	slot0._isOpenSp = slot1
	slot0._isOpenCharge = slot3
	slot0._openViewParam = slot2

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_permit_enter_button)

	if not BpModel.instance:hasGetInfo() then
		slot0:registerCallback(BpEvent.OnGetInfo, slot0._onGetInfo, slot0)
	elseif not BpModel.instance:isEnd() then
		slot0:_openBpView()
	else
		GameFacade.showToast(ToastEnum.BattlePass)

		return
	end

	BpRpc.instance:sendGetBpInfoRequest(true)
end

function slot0.dailyRefresh(slot0)
	if not BpModel.instance:isEnd() and ViewMgr.instance:isOpen(ViewName.BpView) then
		BpRpc.instance:sendGetBpInfoRequest(true)
	end
end

function slot0._openBpView(slot0)
	if slot0._isOpenSp then
		if BpModel.instance.firstShowSp then
			ViewMgr.instance:openView(ViewName.BPSPFaceView)
		else
			ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, slot0.onViewOpen, slot0)
			ViewMgr.instance:openView(ViewName.BpSPView, slot0._openViewParam)
		end
	else
		module_views_preloader.BpViewPreLoad(function ()
			if BpModel.instance:isEnd() then
				return
			end

			ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, uv0.onViewOpen, uv0)

			slot0 = uv0._openViewParam or {}

			if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.BattlePassTaskMain) then
				slot0.defaultTabIds = {
					[2] = 2
				}
			end

			slot0.isPlayDayFirstAnim = not BpModel.instance.firstShow and not uv0._isOpenCharge

			if BpModel.instance.firstShow then
				uv0._isOpenCharge = nil
			end

			ViewMgr.instance:openView(ViewName.BpView, slot0)

			if uv0._isOpenCharge then
				if BpModel.instance:isBpChargeEnd() then
					return
				end

				ViewMgr.instance:openView(ViewName.BpChargeView)
			end
		end)
	end
end

function slot0.onViewOpen(slot0, slot1)
	if slot1 == ViewName.BpView then
		ViewMgr.instance:closeView(ViewName.BpSPView, true)
	elseif slot1 == ViewName.BpSPView then
		ViewMgr.instance:closeView(ViewName.BpView, true)
	else
		return
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, slot0.onViewOpen, slot0)
end

function slot0._onGetInfo(slot0)
	slot0:unregisterCallback(BpEvent.OnGetInfo, slot0._onGetInfo, slot0)

	if BpModel.instance:isEnd() then
		return
	end

	slot0:_openBpView()
end

function slot0._getBpInfo(slot0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.BP) then
		return
	end

	BpRpc.instance:sendGetBpInfoRequest(false)
end

function slot0.onCheckBpEndTime(slot0)
	if not BpModel.instance:isEnd() and BpModel.instance.endTime - ServerTime.now() > 0 then
		TaskDispatcher.cancelTask(slot0._onBpClose, slot0)
		TaskDispatcher.runDelay(slot0._onBpClose, slot0, slot1)
	end
end

function slot0.onBpLevelUp(slot0)
	slot0._isLevelUp = true

	TaskDispatcher.runDelay(slot0._showLevelUpView, slot0, 0.1)
end

function slot0.needShowLevelUp(slot0)
	return slot0._isLevelUp
end

function slot0.pauseShowLevelUp(slot0)
	TaskDispatcher.cancelTask(slot0._showLevelUpView, slot0)

	slot0._isLevelUp = nil
end

function slot0._showLevelUpView(slot0)
	TaskDispatcher.cancelTask(slot0._showLevelUpView, slot0)

	slot0._isLevelUp = nil

	ViewMgr.instance:openView(ViewName.BpLevelupTipView)
end

function slot0._onBpClose(slot0)
	if ViewMgr.instance:isOpen(ViewName.BpView) then
		GameFacade.showToast(ToastEnum.BattlePass)
	end

	BpModel.instance:clearFlow()
	ViewMgr.instance:closeView(ViewName.BpView, true)
	ViewMgr.instance:closeView(ViewName.BpBuyView, true)
	ViewMgr.instance:closeView(ViewName.BpInformationView, true)
	ViewMgr.instance:closeView(ViewName.BpRuleTipsView, true)
	ViewMgr.instance:closeView(ViewName.BpSPInformationView, true)
	ViewMgr.instance:closeView(ViewName.BpSPRuleTipsView, true)
	ViewMgr.instance:closeView(ViewName.BpChargeView, true)
	ViewMgr.instance:closeView(ViewName.BpPropView2, true)
	ViewMgr.instance:closeView(ViewName.BPSPFaceView, true)

	BpModel.instance.endTime = 0

	slot0:dispatchEvent(BpEvent.OnGetInfo)
end

function slot0._onUpdateTaskList(slot0, slot1)
	if BpTaskModel.instance:updateInfo(slot1.taskInfo) then
		uv0.instance:dispatchEvent(BpEvent.OnTaskUpdate)
		uv0.instance:dispatchEvent(BpEvent.OnRedDotUpdate)
	end
end

function slot0._onDeleteTaskList(slot0, slot1)
	if BpTaskModel.instance:deleteInfo(slot1.taskIds) then
		uv0.instance:dispatchEvent(BpEvent.OnTaskUpdate)
		uv0.instance:dispatchEvent(BpEvent.OnRedDotUpdate)
	end
end

function slot0._showCommonPropView(slot0, slot1)
	if BpModel.instance.lockAlertBonus then
		BpModel.instance.cacheBonus = slot1
	else
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.BpPropView, slot1)
	end
end

slot0.instance = slot0.New()

return slot0
