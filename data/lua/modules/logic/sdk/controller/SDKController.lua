module("modules.logic.sdk.controller.SDKController", package.seeall)

slot0 = class("SDKController", BaseController)

function slot0.onInit(slot0)
	SDKChannelEventModel.instance:onInit()
end

function slot0.reInit(slot0)
	SDKChannelEventModel.instance:reInit()
end

function slot0.addConstEvents(slot0)
	SDKMgr.instance:setDataPropertiesChangeCallBack(slot0._onDataPropertiesChangeCallBack, slot0)
end

function slot0.onLoginSuccess(slot0)
	SDKModel.instance:updateBaseProperties()
end

function slot0.openSDKExitView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.SDKExitGameView, {
		loginCallback = slot1,
		exitCallback = slot2
	})
end

function slot0._onDataPropertiesChangeCallBack(slot0, slot1, slot2)
	SDKModel.instance:updateBaseProperties(slot1, slot2)
end

function slot0.openSDKScoreJumpView(slot0)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.AppReview, 1)
	SDKChannelEventModel.instance:setNeedAppReview(false)

	if BootNativeUtil.getPackageName() == "en.shenlan.m.reverse1999.huawei" or slot1 == "jp.shenlan.m.reverse1999.huawei" then
		return
	end

	if GameChannelConfig.isGpGlobal() and UnityEngine.Application.version == "1.0.4" then
		if BootNativeUtil.isAndroid() then
			ViewMgr.instance:openView(ViewName.SDKScoreJumpView)
		end
	elseif GameChannelConfig.isGpJapan() and slot2 == "1.0.5" then
		if BootNativeUtil.isAndroid() then
			ViewMgr.instance:openView(ViewName.SDKScoreJumpView)
		end
	else
		ViewMgr.instance:openView(ViewName.SDKScoreJumpView)
	end
end

slot0.instance = slot0.New()

return slot0
