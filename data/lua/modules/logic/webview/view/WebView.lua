module("modules.logic.webview.view.WebView", package.seeall)

local var_0_0 = class("WebView", BaseView)

var_0_0.DEFAULT_OPEN_AUDIO_VOLUME = 0
var_0_0.DEFAULT_CLOSE_AUDIO_VOLUME = 50

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotools = gohelper.findChild(arg_1_0.viewGO, "#go_tools")
	arg_1_0._btnreload = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_tools/#btn_reload")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_tools/#btn_close")
	arg_1_0._goweb = gohelper.findChild(arg_1_0.viewGO, "#go_web")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnreload:AddClickListener(arg_2_0._btnreloadOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, arg_2_0.onScreenSizeChanged, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnreload:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, arg_3_0.onScreenSizeChanged, arg_3_0)
end

function var_0_0._btnreloadOnClick(arg_4_0)
	arg_4_0.webViewComp:Reload()
end

function var_0_0._btncloseOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0.webViewComp = gohelper.onceAddComponent(arg_6_0._goweb, typeof(ZProj.SLWebView))
end

function var_0_0._onOpenView(arg_7_0, arg_7_1)
	if arg_7_1 == ViewName.ToastView then
		return
	end

	if arg_7_1 ~= arg_7_0.viewName then
		arg_7_0:closeThis()
	end
end

function var_0_0.onUpdateParam(arg_8_0)
	arg_8_0:openWeb()
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0:openWeb()
end

function var_0_0.openWeb(arg_10_0)
	arg_10_0.url = arg_10_0:getUrl()
	arg_10_0.callback = arg_10_0.viewParam.callback
	arg_10_0.callbackObj = arg_10_0.viewParam.callbackObj
	arg_10_0.left = arg_10_0.viewParam.left or WebViewEnum.DefaultMargin.Left
	arg_10_0.right = arg_10_0.viewParam.right or WebViewEnum.DefaultMargin.Right
	arg_10_0.top = arg_10_0.viewParam.top or WebViewEnum.DefaultMargin.Top
	arg_10_0.bottom = arg_10_0.viewParam.bottom or WebViewEnum.DefaultMargin.Bottom
	arg_10_0.autoTop = arg_10_0.viewParam.autoTop or true
	arg_10_0.autoBottom = arg_10_0.viewParam.autoBottom or true

	local var_10_0 = not arg_10_0.autoTop and arg_10_0.top or WebViewController.instance:getWebViewTopOffset(nil, nil, arg_10_0.top)
	local var_10_1 = not arg_10_0.autoBottom and arg_10_0.bottom or WebViewController.instance:getWebViewBottomOffset(nil, nil, arg_10_0.bottom)

	arg_10_0.webViewComp:Show(arg_10_0.url, arg_10_0.callbackWrap, arg_10_0, arg_10_0.left, var_10_0, arg_10_0.right, var_10_1)

	local var_10_2 = arg_10_0.DEFAULT_OPEN_AUDIO_VOLUME

	AudioMgr.instance:setRTPCValue(AudioEnum.Volume.Global_Volume, var_10_2)
end

function var_0_0.onScreenSizeChanged(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = not arg_11_0.autoTop and arg_11_0.top or WebViewController.instance:getWebViewTopOffset(arg_11_1, arg_11_2, arg_11_0.top)
	local var_11_1 = not arg_11_0.autoBottom and arg_11_0.bottom or WebViewController.instance:getWebViewBottomOffset(arg_11_1, arg_11_2, arg_11_0.bottom)

	logNormal(string.format("Change WebView Margins width:%s height:%s", arg_11_1, arg_11_2))
	arg_11_0.webViewComp.webViewObject:SetMargins(arg_11_0.left, var_11_0, arg_11_0.right, var_11_1)
end

function var_0_0.getUrl(arg_12_0)
	local var_12_0 = arg_12_0.viewParam.url

	if not arg_12_0.viewParam.needRecordUser then
		return var_12_0
	end

	return WebViewController.instance:getRecordUserUrl(var_12_0)
end

function var_0_0.callbackWrap(arg_13_0, arg_13_1, arg_13_2)
	logNormal(string.format("cur url : %s, cb type : %s, msg : %s", arg_13_0.url, arg_13_1, arg_13_2))

	if arg_13_0.callback then
		return arg_13_0.callback(arg_13_0.callbackObj, arg_13_1, arg_13_2)
	end
end

function var_0_0.onDestroyView(arg_14_0)
	arg_14_0.webViewComp:Recycle()

	arg_14_0.webViewComp = nil
end

function var_0_0.onClose(arg_15_0)
	local var_15_0 = SettingsModel.instance:getGlobalAudioVolume() or arg_15_0.DEFAULT_CLOSE_AUDIO_VOLUME

	AudioMgr.instance:setRTPCValue(AudioEnum.Volume.Global_Volume, var_15_0)
end

return var_0_0
