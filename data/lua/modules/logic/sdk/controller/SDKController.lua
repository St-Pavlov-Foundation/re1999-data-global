module("modules.logic.sdk.controller.SDKController", package.seeall)

local var_0_0 = class("SDKController", BaseController)

function var_0_0.onInit(arg_1_0)
	SDKChannelEventModel.instance:onInit()
end

function var_0_0.reInit(arg_2_0)
	SDKChannelEventModel.instance:reInit()
end

function var_0_0.addConstEvents(arg_3_0)
	SDKMgr.instance:setDataPropertiesChangeCallBack(arg_3_0._onDataPropertiesChangeCallBack, arg_3_0)
end

function var_0_0.onLoginSuccess(arg_4_0)
	SDKModel.instance:updateBaseProperties()
end

function var_0_0.openSDKExitView(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = {
		loginCallback = arg_5_1,
		exitCallback = arg_5_2
	}

	ViewMgr.instance:openView(ViewName.SDKExitGameView, var_5_0)
end

function var_0_0._onDataPropertiesChangeCallBack(arg_6_0, arg_6_1, arg_6_2)
	SDKModel.instance:updateBaseProperties(arg_6_1, arg_6_2)
end

function var_0_0.openSDKScoreJumpView(arg_7_0)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.AppReview, 1)
	SDKChannelEventModel.instance:setNeedAppReview(false)

	local var_7_0 = BootNativeUtil.getPackageName()

	if var_7_0 == "en.shenlan.m.reverse1999.huawei" or var_7_0 == "jp.shenlan.m.reverse1999.huawei" then
		return
	end

	local var_7_1 = UnityEngine.Application.version

	if GameChannelConfig.isGpGlobal() and var_7_1 == "1.0.4" then
		if BootNativeUtil.isAndroid() then
			ViewMgr.instance:openView(ViewName.SDKScoreJumpView)
		end
	elseif GameChannelConfig.isGpJapan() and var_7_1 == "1.0.5" then
		if BootNativeUtil.isAndroid() then
			ViewMgr.instance:openView(ViewName.SDKScoreJumpView)
		end
	else
		ViewMgr.instance:openView(ViewName.SDKScoreJumpView)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
