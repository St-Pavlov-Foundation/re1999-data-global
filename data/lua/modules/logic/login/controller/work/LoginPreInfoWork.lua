module("modules.logic.login.controller.work.LoginPreInfoWork", package.seeall)

local var_0_0 = class("LoginPreInfoWork", BaseWork)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	CurrencyController.instance:registerCallback(CurrencyEvent.GetCurrencyInfoSuccess, arg_2_0._onGetCurrencyInfoSuccess, arg_2_0)
	OpenController.instance:registerCallback(OpenEvent.GetOpenInfoSuccess, arg_2_0._onGetPlayerInfoSuccess, arg_2_0)
	GuideController.instance:registerCallback(GuideEvent.GetGuideInfoSuccess, arg_2_0._onGetGuideInfoSuccess, arg_2_0)
	arg_2_0:_getPlayerInfoBeforeLoading()
end

function var_0_0.clearWork(arg_3_0)
	CurrencyController.instance:unregisterCallback(CurrencyEvent.GetCurrencyInfoSuccess, arg_3_0._onGetCurrencyInfoSuccess, arg_3_0)
	OpenController.instance:unregisterCallback(OpenEvent.GetOpenInfoSuccess, arg_3_0._onGetPlayerInfoSuccess, arg_3_0)
	GuideController.instance:unregisterCallback(GuideEvent.GetGuideInfoSuccess, arg_3_0._onGetGuideInfoSuccess, arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._getInfoTimeout, arg_3_0)
end

function var_0_0._getPlayerInfoBeforeLoading(arg_4_0)
	arg_4_0._getPlayerInfo = nil
	arg_4_0._getCurrencyInfo = nil
	arg_4_0._getGuideInfo = nil

	TaskDispatcher.runDelay(arg_4_0._getInfoTimeout, arg_4_0, 60)
	CommonRpc.instance:sendGetServerTimeRequest()
	PlayerRpc.instance:sendGetPlayerInfoRequest()
	CurrencyRpc.instance:sendGetAllCurrency()
	GuideRpc.instance:sendGetGuideInfoRequest()
end

function var_0_0._sendPlayerBaseProperties(arg_5_0)
	StatController.instance:onLogin()
end

function var_0_0._getInfoTimeout(arg_6_0)
	if not arg_6_0._getPlayerInfo or not arg_6_0._getCurrencyInfo or not arg_6_0._getGuideInfo then
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.LoginLostConnect1, MsgBoxEnum.BoxType.Yes, function()
			LoginController.instance:logout()
		end, nil)
	end
end

function var_0_0._checkPreInfo(arg_8_0)
	if arg_8_0._getPlayerInfo and arg_8_0._getCurrencyInfo and arg_8_0._getGuideInfo then
		TaskDispatcher.cancelTask(arg_8_0._getInfoTimeout, arg_8_0)
		arg_8_0:_sendPlayerBaseProperties()

		if SDKDataTrackMgr then
			StatController.instance:track(StatEnum.EventName.GameLoading, {
				[StatEnum.EventProperties.IsEnterGame] = true
			})
		end

		arg_8_0:onDone(true)
	end
end

function var_0_0._onGetPlayerInfoSuccess(arg_9_0)
	OpenController.instance:unregisterCallback(OpenEvent.GetOpenInfoSuccess, arg_9_0._onGetPlayerInfoSuccess, arg_9_0)

	arg_9_0._getPlayerInfo = true

	arg_9_0:_checkPreInfo()
end

function var_0_0._onGetCurrencyInfoSuccess(arg_10_0)
	CurrencyController.instance:unregisterCallback(CurrencyEvent.GetCurrencyInfoSuccess, arg_10_0._onGetCurrencyInfoSuccess, arg_10_0)

	arg_10_0._getCurrencyInfo = true

	arg_10_0:_checkPreInfo()
end

function var_0_0._onGetGuideInfoSuccess(arg_11_0)
	GuideController.instance:unregisterCallback(GuideEvent.GetGuideInfoSuccess, arg_11_0._onGetGuideInfoSuccess, arg_11_0)

	arg_11_0._getGuideInfo = true

	arg_11_0:_checkPreInfo()
end

return var_0_0
