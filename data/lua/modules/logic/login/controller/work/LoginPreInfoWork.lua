module("modules.logic.login.controller.work.LoginPreInfoWork", package.seeall)

slot0 = class("LoginPreInfoWork", BaseWork)

function slot0.ctor(slot0)
end

function slot0.onStart(slot0, slot1)
	CurrencyController.instance:registerCallback(CurrencyEvent.GetCurrencyInfoSuccess, slot0._onGetCurrencyInfoSuccess, slot0)
	OpenController.instance:registerCallback(OpenEvent.GetOpenInfoSuccess, slot0._onGetPlayerInfoSuccess, slot0)
	GuideController.instance:registerCallback(GuideEvent.GetGuideInfoSuccess, slot0._onGetGuideInfoSuccess, slot0)
	slot0:_getPlayerInfoBeforeLoading()
end

function slot0.clearWork(slot0)
	CurrencyController.instance:unregisterCallback(CurrencyEvent.GetCurrencyInfoSuccess, slot0._onGetCurrencyInfoSuccess, slot0)
	OpenController.instance:unregisterCallback(OpenEvent.GetOpenInfoSuccess, slot0._onGetPlayerInfoSuccess, slot0)
	GuideController.instance:unregisterCallback(GuideEvent.GetGuideInfoSuccess, slot0._onGetGuideInfoSuccess, slot0)
	TaskDispatcher.cancelTask(slot0._getInfoTimeout, slot0)
end

function slot0._getPlayerInfoBeforeLoading(slot0)
	slot0._getPlayerInfo = nil
	slot0._getCurrencyInfo = nil
	slot0._getGuideInfo = nil

	TaskDispatcher.runDelay(slot0._getInfoTimeout, slot0, 60)
	CommonRpc.instance:sendGetServerTimeRequest()
	PlayerRpc.instance:sendGetPlayerInfoRequest()
	CurrencyRpc.instance:sendGetAllCurrency()
	GuideRpc.instance:sendGetGuideInfoRequest()
end

function slot0._sendPlayerBaseProperties(slot0)
	StatController.instance:onLogin()
end

function slot0._getInfoTimeout(slot0)
	if not slot0._getPlayerInfo or not slot0._getCurrencyInfo or not slot0._getGuideInfo then
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.LoginLostConnect1, MsgBoxEnum.BoxType.Yes, function ()
			LoginController.instance:logout()
		end, nil)
	end
end

function slot0._checkPreInfo(slot0)
	if slot0._getPlayerInfo and slot0._getCurrencyInfo and slot0._getGuideInfo then
		TaskDispatcher.cancelTask(slot0._getInfoTimeout, slot0)
		slot0:_sendPlayerBaseProperties()

		if SDKDataTrackMgr then
			StatController.instance:track(StatEnum.EventName.GameLoading, {
				[StatEnum.EventProperties.IsEnterGame] = true
			})
		end

		slot0:onDone(true)
	end
end

function slot0._onGetPlayerInfoSuccess(slot0)
	OpenController.instance:unregisterCallback(OpenEvent.GetOpenInfoSuccess, slot0._onGetPlayerInfoSuccess, slot0)

	slot0._getPlayerInfo = true

	slot0:_checkPreInfo()
end

function slot0._onGetCurrencyInfoSuccess(slot0)
	CurrencyController.instance:unregisterCallback(CurrencyEvent.GetCurrencyInfoSuccess, slot0._onGetCurrencyInfoSuccess, slot0)

	slot0._getCurrencyInfo = true

	slot0:_checkPreInfo()
end

function slot0._onGetGuideInfoSuccess(slot0)
	GuideController.instance:unregisterCallback(GuideEvent.GetGuideInfoSuccess, slot0._onGetGuideInfoSuccess, slot0)

	slot0._getGuideInfo = true

	slot0:_checkPreInfo()
end

return slot0
