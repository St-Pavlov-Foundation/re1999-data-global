-- chunkname: @modules/logic/sdk/controller/SDKController.lua

module("modules.logic.sdk.controller.SDKController", package.seeall)

local SDKController = class("SDKController", BaseController)

function SDKController:onInit()
	SDKChannelEventModel.instance:onInit()

	self._checkShowATTWithGetIDFATime = Time.time + 900
end

function SDKController:reInit()
	SDKChannelEventModel.instance:reInit()
end

function SDKController:addConstEvents()
	SDKMgr.instance:setDataPropertiesChangeCallBack(self._onDataPropertiesChangeCallBack, self)

	if (GameChannelConfig.isGpGlobal() or GameChannelConfig.isGpJapan()) and VersionValidator.instance:isInReviewing() == false and BootNativeUtil.isIOS() and SDKModel.instance:getNeedShowATTWithGetIDFA() then
		MainController.instance:registerCallback(MainEvent.ShowMainView, self._checkShowATTWithGetIDFA, self)
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	end
end

function SDKController:onLoginSuccess()
	SDKModel.instance:updateBaseProperties()
end

function SDKController:openSDKExitView(loginCallback, exitCallback)
	local param = {}

	param.loginCallback = loginCallback
	param.exitCallback = exitCallback

	ViewMgr.instance:openView(ViewName.SDKExitGameView, param)
end

function SDKController:_onDataPropertiesChangeCallBack(code, msg)
	SDKModel.instance:updateBaseProperties(code, msg)
end

function SDKController:_onCloseViewFinish()
	local viewNameList = ViewMgr.instance:getOpenViewNameList()
	local topView = viewNameList[#viewNameList]

	if topView == ViewName.MainView then
		self:_checkShowATTWithGetIDFA()
	end
end

function SDKController:_checkShowATTWithGetIDFA()
	if Time.time < self._checkShowATTWithGetIDFATime then
		return
	end

	if (GameChannelConfig.isGpGlobal() or GameChannelConfig.isGpJapan()) and VersionValidator.instance:isInReviewing() == false and BootNativeUtil.isIOS() and GuideController.instance:isGuiding() == false and SDKModel.instance:getNeedShowATTWithGetIDFA() then
		SDKModel.instance:setNeedShowATTWithGetIDFA(false)
		ZProj.SDKMgr.Instance:ShowATTWithGetIDFA()
	end
end

function SDKController:_onFinishAllPatFace()
	if Time.time < self._checkShowATTWithGetIDFATime then
		return
	end

	if (GameChannelConfig.isGpGlobal() or GameChannelConfig.isGpJapan()) and VersionValidator.instance:isInReviewing() == false and BootNativeUtil.isIOS() and SDKModel.instance:getNeedShowATTWithGetIDFA() then
		SDKModel.instance:setNeedShowATTWithGetIDFA(false)
		ZProj.SDKMgr.Instance:ShowATTWithGetIDFA()
	end
end

function SDKController:openSDKScoreJumpView()
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.AppReview, 1)
	SDKChannelEventModel.instance:setNeedAppReview(false)

	local packageName = BootNativeUtil.getPackageName()

	if packageName == "en.shenlan.m.reverse1999.huawei" or packageName == "jp.shenlan.m.reverse1999.huawei" then
		return
	end

	local version = UnityEngine.Application.version

	if GameChannelConfig.isGpGlobal() and version == "1.0.4" then
		if BootNativeUtil.isAndroid() then
			ViewMgr.instance:openView(ViewName.SDKScoreJumpView)
		end
	elseif GameChannelConfig.isGpJapan() and version == "1.0.5" then
		if BootNativeUtil.isAndroid() then
			ViewMgr.instance:openView(ViewName.SDKScoreJumpView)
		end
	else
		ViewMgr.instance:openView(ViewName.SDKScoreJumpView)
	end
end

SDKController.instance = SDKController.New()

return SDKController
