module("modules.logic.main.controller.MainController", package.seeall)

local var_0_0 = class("MainController", BaseController)

function var_0_0.addConstEvents(arg_1_0)
	LoginController.instance:registerCallback(LoginEvent.OnLoginEnterMainScene, arg_1_0._onLoginEnterMainScene, arg_1_0)
	PlayerController.instance:registerCallback(PlayerEvent.OnDailyRefresh, arg_1_0._onDailyRefresh, arg_1_0)
	ActivityController.instance:registerCallback(ActivityEvent.UpdateActivity, arg_1_0._onActivityUpdate, arg_1_0)
	var_0_0.instance:registerCallback(MainEvent.ManuallyOpenMainView, arg_1_0._onManuallyOpenMainView, arg_1_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_1_0._onCloseView, arg_1_0, LuaEventSystem.Low)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_1_0._onCloseViewFinish, arg_1_0, LuaEventSystem.Low)
end

function var_0_0.onInit(arg_2_0)
	arg_2_0.firstEnterMainScene = true
	arg_2_0._inPopupFlow = false
	arg_2_0._needOpenMainView = false
end

function var_0_0.reInit(arg_3_0)
	arg_3_0:_destroyPopupFlow()

	arg_3_0.firstEnterMainScene = true
	arg_3_0._inPopupFlow = false
	arg_3_0._needOpenMainView = false
end

function var_0_0._startPopupFlow(arg_4_0)
	arg_4_0:_destroyPopupFlow()

	arg_4_0._popupFlow = FlowSequence.New()

	arg_4_0._popupFlow:addWork(MainGuideWork.New())
	arg_4_0._popupFlow:addWork(MainLimitedRoleEffect.New())
	arg_4_0._popupFlow:addWork(FunctionWork.New(function()
		BGMSwitchController.instance:startAllOnLogin()
	end))
	arg_4_0._popupFlow:addWork(MainAchievementToast.New())
	arg_4_0._popupFlow:addWork(MainThumbnailWork.New())
	arg_4_0._popupFlow:addWork(MainMailWork.New())
	arg_4_0._popupFlow:addWork(MainUseExpireItemWork.New())
	arg_4_0._popupFlow:addWork(MainSignInWork.New())
	arg_4_0._popupFlow:addWork(MainFightReconnectWork.New())
	arg_4_0._popupFlow:addWork(MainPatFaceWork.New())
	arg_4_0._popupFlow:addWork(MainParallelGuideWork.New())
	arg_4_0._popupFlow:addWork(AutoOpenNoticeWork.New())
	arg_4_0._popupFlow:registerDoneListener(arg_4_0._onPopupFlowDone, arg_4_0)
	arg_4_0._popupFlow:start({})

	arg_4_0._inPopupFlow = true
end

function var_0_0._destroyPopupFlow(arg_6_0)
	if arg_6_0._popupFlow then
		arg_6_0._popupFlow:destroy()

		arg_6_0._popupFlow = nil
		arg_6_0._inPopupFlow = false
	end
end

function var_0_0._onLoginEnterMainScene(arg_7_0)
	var_0_0.instance:dispatchEvent(MainEvent.OnFirstEnterMain)
	arg_7_0:_startPopupFlow()
end

function var_0_0._onDailyRefresh(arg_8_0)
	arg_8_0:_onCheckAutoPop(true)
end

function var_0_0._onActivityUpdate(arg_9_0)
	arg_9_0:_onCheckAutoPop(false)
end

function var_0_0._onCheckAutoPop(arg_10_0, arg_10_1)
	arg_10_0._isDailyRefresh = arg_10_1

	if arg_10_0._inPopupFlow then
		arg_10_0:registerCallback(MainEvent.OnMainPopupFlowFinish, arg_10_0._onCheckFlowDone, arg_10_0)

		return
	end

	arg_10_0:_setDailyRefreshPopUp()
end

function var_0_0._onCheckFlowDone(arg_11_0)
	arg_11_0:unregisterCallback(MainEvent.OnMainPopupFlowFinish, arg_11_0._onCheckFlowDone, arg_11_0)
	arg_11_0:_setDailyRefreshPopUp()
end

function var_0_0._setDailyRefreshPopUp(arg_12_0)
	arg_12_0:_destroyPopupFlow()

	arg_12_0._popupFlow = FlowSequence.New()

	arg_12_0._popupFlow:addWork(MainSignInWork.New())

	if arg_12_0._isDailyRefresh then
		arg_12_0._popupFlow:addWork(MainPatFaceWork.New())
	else
		arg_12_0._popupFlow:addWork(Activity152PatFaceWork.New())
	end

	arg_12_0._popupFlow:registerDoneListener(arg_12_0._onPopupFlowDailyDone, arg_12_0)

	arg_12_0._inPopupFlow = true

	arg_12_0._popupFlow:start({
		dailyRefresh = arg_12_0._isDailyRefresh
	})
end

function var_0_0._onPopupFlowDailyDone(arg_13_0)
	arg_13_0._inPopupFlow = false

	var_0_0.instance:dispatchEvent(MainEvent.OnDailyPopupFlowFinish)
end

function var_0_0._onPopupFlowDone(arg_14_0, arg_14_1)
	arg_14_0._inPopupFlow = false

	var_0_0.instance:dispatchEvent(MainEvent.OnMainPopupFlowFinish)
end

function var_0_0.enterMainScene(arg_15_0, arg_15_1, arg_15_2)
	GameSceneMgr.instance:startSceneDefaultLevel(SceneType.Main, 101, arg_15_1, arg_15_2)
end

function var_0_0.openMainThumbnailView(arg_16_0, arg_16_1, arg_16_2)
	var_0_0.instance:dispatchEvent(MainEvent.OnClickSwitchRole)
	ViewMgr.instance:openView(ViewName.MainThumbnailView, arg_16_1, arg_16_2)
end

function var_0_0.setRequestNoticeTime(arg_17_0)
	arg_17_0.requestTime = Time.realtimeSinceStartup
end

function var_0_0.getLastRequestNoticeTime(arg_18_0)
	return arg_18_0.requestTime
end

function var_0_0.isInMainView(arg_19_0)
	local var_19_0 = ViewMgr.instance:getOpenViewNameList()
	local var_19_1 = {}

	for iter_19_0, iter_19_1 in ipairs(var_19_0) do
		local var_19_2 = ViewMgr.instance:getSetting(iter_19_1)

		if var_19_2.layer ~= UILayerName.Message and var_19_2.layer ~= UILayerName.IDCanvasPopUp then
			table.insert(var_19_1, iter_19_1)
		end
	end

	local var_19_3 = true

	if #var_19_1 > 1 or var_19_1[1] ~= ViewName.MainView then
		var_19_3 = false
	end

	return var_19_3
end

function var_0_0.isInPopupFlow(arg_20_0)
	return arg_20_0._inPopupFlow
end

function var_0_0.clearOpenMainViewFlag(arg_21_0)
	arg_21_0._needOpenMainView = false
end

function var_0_0._onManuallyOpenMainView(arg_22_0)
	arg_22_0._needOpenMainView = true

	arg_22_0:_checkOpenMainView()
end

function var_0_0._checkOpenMainView(arg_23_0)
	if not arg_23_0._needOpenMainView or ViewMgr.instance:hasOpenFullView() then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.StoreView) then
		return
	end

	arg_23_0._needOpenMainView = false

	if ViewMgr.instance:isOpen(ViewName.MainView) then
		return
	end

	ViewMgr.instance:openView(ViewName.MainView)
end

function var_0_0._onCloseView(arg_24_0)
	arg_24_0:_checkOpenMainView()
end

function var_0_0._onCloseViewFinish(arg_25_0)
	arg_25_0:_checkOpenMainView()
end

var_0_0.instance = var_0_0.New()

return var_0_0
