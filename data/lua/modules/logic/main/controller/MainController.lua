module("modules.logic.main.controller.MainController", package.seeall)

local var_0_0 = class("MainController", BaseController)

function var_0_0.addConstEvents(arg_1_0)
	LoginController.instance:registerCallback(LoginEvent.OnLoginEnterMainScene, arg_1_0._onLoginEnterMainScene, arg_1_0)
	PlayerController.instance:registerCallback(PlayerEvent.OnDailyRefresh, arg_1_0._onDailyRefresh, arg_1_0)
	ActivityController.instance:registerCallback(ActivityEvent.UpdateActivity, arg_1_0._onActivityUpdate, arg_1_0)
end

function var_0_0.onInit(arg_2_0)
	arg_2_0.firstEnterMainScene = true
	arg_2_0._inPopupFlow = false
end

function var_0_0.reInit(arg_3_0)
	arg_3_0:_destroyPopupFlow()

	arg_3_0.firstEnterMainScene = true
	arg_3_0._inPopupFlow = false
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
	arg_10_0:_destroyPopupFlow()

	arg_10_0._popupFlow = FlowSequence.New()

	arg_10_0._popupFlow:addWork(MainSignInWork.New())

	if arg_10_1 then
		arg_10_0._popupFlow:addWork(MainPatFaceWork.New())
	else
		arg_10_0._popupFlow:addWork(Activity152PatFaceWork.New())
	end

	arg_10_0._popupFlow:start({
		dailyRefresh = arg_10_1
	})

	arg_10_0._inPopupFlow = true
end

function var_0_0._onPopupFlowDone(arg_11_0, arg_11_1)
	arg_11_0._inPopupFlow = false

	var_0_0.instance:dispatchEvent(MainEvent.OnMainPopupFlowFinish)
end

function var_0_0.enterMainScene(arg_12_0, arg_12_1, arg_12_2)
	GameSceneMgr.instance:startSceneDefaultLevel(SceneType.Main, 101, arg_12_1, arg_12_2)
end

function var_0_0.openMainThumbnailView(arg_13_0, arg_13_1, arg_13_2)
	var_0_0.instance:dispatchEvent(MainEvent.OnClickSwitchRole)
	ViewMgr.instance:openView(ViewName.MainThumbnailView, arg_13_1, arg_13_2)
end

function var_0_0.setRequestNoticeTime(arg_14_0)
	arg_14_0.requestTime = Time.realtimeSinceStartup
end

function var_0_0.getLastRequestNoticeTime(arg_15_0)
	return arg_15_0.requestTime
end

function var_0_0.isInMainView(arg_16_0)
	local var_16_0 = ViewMgr.instance:getOpenViewNameList()
	local var_16_1 = {}

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		local var_16_2 = ViewMgr.instance:getSetting(iter_16_1)

		if var_16_2.layer ~= UILayerName.Message and var_16_2.layer ~= UILayerName.IDCanvasPopUp then
			table.insert(var_16_1, iter_16_1)
		end
	end

	local var_16_3 = true

	if #var_16_1 > 1 or var_16_1[1] ~= ViewName.MainView then
		var_16_3 = false
	end

	return var_16_3
end

function var_0_0.isInPopupFlow(arg_17_0)
	return arg_17_0._inPopupFlow
end

var_0_0.instance = var_0_0.New()

return var_0_0
