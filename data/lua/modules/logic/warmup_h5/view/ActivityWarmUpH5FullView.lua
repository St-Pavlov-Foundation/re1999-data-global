module("modules.logic.warmup_h5.view.ActivityWarmUpH5FullView", package.seeall)

local var_0_0 = class("ActivityWarmUpH5FullView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._simagelangtxt = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_langtxt")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/#btn_click")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Root/#txt_LimitTime")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	SDKDataTrackMgr.instance:trackClickActivityJumpButton()

	local var_4_0 = arg_4_0.viewContainer:getH5BaseUrl()

	WebViewController.instance:simpleOpenWebView(var_4_0, arg_4_0._onWebViewCb, arg_4_0)
end

function var_0_0._actId(arg_5_0)
	return arg_5_0.viewContainer:actId()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._txtLimitTime.text = ""
end

function var_0_0._onWebViewCb(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 == WebViewEnum.WebViewCBType.Cb and string.split(arg_7_2, "#")[1] == "webClose" then
		ViewMgr.instance:closeView(ViewName.WebView)
	end
end

function var_0_0.onOpen(arg_8_0)
	local var_8_0 = arg_8_0.viewParam.parent

	gohelper.addChild(var_8_0, arg_8_0.viewGO)
	var_0_0.super.onOpen(arg_8_0)
	AudioMgr.instance:trigger(AudioEnum3_1.WarmUpH5.play_ui_mingdi_h5_open)
	arg_8_0:_refreshTimeTick()
	TaskDispatcher.cancelTask(arg_8_0._refreshTimeTick, arg_8_0)
	TaskDispatcher.runRepeat(arg_8_0._refreshTimeTick, arg_8_0, 1)
end

function var_0_0._refreshTimeTick(arg_9_0)
	arg_9_0._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(arg_9_0:_actId())
end

function var_0_0.onClose(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._refreshTimeTick, arg_10_0)
end

function var_0_0.onDestroyView(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._refreshTimeTick, arg_11_0)
end

return var_0_0
