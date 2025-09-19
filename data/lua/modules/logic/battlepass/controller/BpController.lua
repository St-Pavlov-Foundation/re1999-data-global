module("modules.logic.battlepass.controller.BpController", package.seeall)

local var_0_0 = class("BpController", BaseController)

function var_0_0.addConstEvents(arg_1_0)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, arg_1_0._onUpdateTaskList, arg_1_0)
	TaskController.instance:registerCallback(TaskEvent.OnDeleteTask, arg_1_0._onDeleteTaskList, arg_1_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_1_0.dailyRefresh, arg_1_0)
	LoginController.instance:registerCallback(LoginEvent.OnGetInfoFinish, arg_1_0._getBpInfo, arg_1_0)
end

function var_0_0.openBattlePassView(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0._isOpenSp = arg_2_1
	arg_2_0._isOpenCharge = arg_2_3
	arg_2_0._openViewParam = arg_2_2

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_permit_enter_button)

	if not BpModel.instance:hasGetInfo() then
		arg_2_0:registerCallback(BpEvent.OnGetInfo, arg_2_0._onGetInfo, arg_2_0)
	elseif not BpModel.instance:isEnd() then
		arg_2_0:_openBpView()
	else
		GameFacade.showToast(ToastEnum.BattlePass)

		return
	end

	BpRpc.instance:sendGetBpInfoRequest(true)
end

function var_0_0.dailyRefresh(arg_3_0)
	if not BpModel.instance:isEnd() and ViewMgr.instance:isOpen(ViewName.BpView) then
		BpRpc.instance:sendGetBpInfoRequest(true)
	end
end

function var_0_0._openBpView(arg_4_0)
	if arg_4_0._isOpenSp then
		if BpModel.instance.firstShowSp then
			ViewMgr.instance:openView(ViewName.BPSPFaceView)
		else
			ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, arg_4_0.onViewOpen, arg_4_0)
			ViewMgr.instance:openView(ViewName.BpSPView, arg_4_0._openViewParam)
		end
	else
		module_views_preloader.BpViewPreLoad(function()
			if BpModel.instance:isEnd() then
				return
			end

			ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, arg_4_0.onViewOpen, arg_4_0)

			local var_5_0 = arg_4_0._openViewParam or {}

			if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.BattlePassTaskMain) then
				var_5_0.defaultTabIds = {}
				var_5_0.defaultTabIds[2] = 2
			end

			var_5_0.isPlayDayFirstAnim = not BpModel.instance.firstShow and not arg_4_0._isOpenCharge

			if BpModel.instance.firstShow then
				arg_4_0._isOpenCharge = nil
			end

			ViewMgr.instance:openView(ViewName.BpView, var_5_0)

			if arg_4_0._isOpenCharge then
				if BpModel.instance:isBpChargeEnd() then
					return
				end

				ViewMgr.instance:openView(ViewName.BpChargeView)
			end
		end)
	end
end

function var_0_0.onViewOpen(arg_6_0, arg_6_1)
	if arg_6_1 == ViewName.BpView then
		ViewMgr.instance:closeView(ViewName.BpSPView, true)
	elseif arg_6_1 == ViewName.BpSPView then
		ViewMgr.instance:closeView(ViewName.BpView, true)
	else
		return
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, arg_6_0.onViewOpen, arg_6_0)
end

function var_0_0._onGetInfo(arg_7_0)
	arg_7_0:unregisterCallback(BpEvent.OnGetInfo, arg_7_0._onGetInfo, arg_7_0)

	if BpModel.instance:isEnd() then
		return
	end

	arg_7_0:_openBpView()
end

function var_0_0._getBpInfo(arg_8_0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.BP) then
		return
	end

	BpRpc.instance:sendGetBpInfoRequest(false)
end

function var_0_0.onCheckBpEndTime(arg_9_0)
	if not BpModel.instance:isEnd() then
		local var_9_0 = BpModel.instance.endTime - ServerTime.now()

		if var_9_0 > 0 then
			TaskDispatcher.cancelTask(arg_9_0._onBpClose, arg_9_0)
			TaskDispatcher.runDelay(arg_9_0._onBpClose, arg_9_0, var_9_0)
		end
	end
end

function var_0_0.onBpLevelUp(arg_10_0)
	arg_10_0._isLevelUp = true

	TaskDispatcher.runDelay(arg_10_0._showLevelUpView, arg_10_0, 0.1)
end

function var_0_0.needShowLevelUp(arg_11_0)
	return arg_11_0._isLevelUp
end

function var_0_0.pauseShowLevelUp(arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._showLevelUpView, arg_12_0)

	arg_12_0._isLevelUp = nil
end

function var_0_0._showLevelUpView(arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0._showLevelUpView, arg_13_0)

	arg_13_0._isLevelUp = nil

	ViewMgr.instance:openView(ViewName.BpLevelupTipView)
end

function var_0_0._onBpClose(arg_14_0)
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

	arg_14_0:dispatchEvent(BpEvent.OnGetInfo)
end

function var_0_0._onUpdateTaskList(arg_15_0, arg_15_1)
	if BpTaskModel.instance:updateInfo(arg_15_1.taskInfo) then
		var_0_0.instance:dispatchEvent(BpEvent.OnTaskUpdate)
		var_0_0.instance:dispatchEvent(BpEvent.OnRedDotUpdate)
	end
end

function var_0_0._onDeleteTaskList(arg_16_0, arg_16_1)
	if BpTaskModel.instance:deleteInfo(arg_16_1.taskIds) then
		var_0_0.instance:dispatchEvent(BpEvent.OnTaskUpdate)
		var_0_0.instance:dispatchEvent(BpEvent.OnRedDotUpdate)
	end
end

function var_0_0._showCommonPropView(arg_17_0, arg_17_1)
	if BpModel.instance.lockAlertBonus then
		BpModel.instance.cacheBonus = arg_17_1
	else
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.BpPropView, arg_17_1)
	end
end

function var_0_0.isEmptySkinFaceViewStr(arg_18_0, arg_18_1)
	local var_18_0 = PlayerPrefsHelper.getString(arg_18_0:_getSkinFaceViewKey(arg_18_1), "")

	return string.nilorempty(var_18_0)
end

function var_0_0.setSkinFaceViewStr(arg_19_0, arg_19_1)
	arg_19_1 = arg_19_1 or 0

	return PlayerPrefsHelper.setString(arg_19_0:_getSkinFaceViewKey(arg_19_1), tostring(arg_19_1))
end

function var_0_0._getSkinFaceViewKey(arg_20_0, arg_20_1)
	arg_20_1 = arg_20_1 or 0

	return string.format("%s#%s#%s", PlayerPrefsKey.BPSkinFaceView, arg_20_1, PlayerModel.instance:getMyUserId())
end

var_0_0.instance = var_0_0.New()

return var_0_0
