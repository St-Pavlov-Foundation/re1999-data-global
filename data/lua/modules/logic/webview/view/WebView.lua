module("modules.logic.webview.view.WebView", package.seeall)

slot0 = class("WebView", BaseView)
slot0.DEFAULT_OPEN_AUDIO_VOLUME = 0
slot0.DEFAULT_CLOSE_AUDIO_VOLUME = 50

function slot0.onInitView(slot0)
	slot0._gotools = gohelper.findChild(slot0.viewGO, "#go_tools")
	slot0._btnreload = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_tools/#btn_reload")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_tools/#btn_close")
	slot0._goweb = gohelper.findChild(slot0.viewGO, "#go_web")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnreload:AddClickListener(slot0._btnreloadOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, slot0.onScreenSizeChanged, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnreload:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, slot0.onScreenSizeChanged, slot0)
end

function slot0._btnreloadOnClick(slot0)
	slot0.webViewComp:Reload()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0.webViewComp = gohelper.onceAddComponent(slot0._goweb, typeof(ZProj.SLWebView))

	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
end

function slot0._onOpenView(slot0, slot1)
	if slot1 == ViewName.ToastView then
		return
	end

	if slot1 ~= slot0.viewName then
		slot0:closeThis()
	end
end

function slot0.onUpdateParam(slot0)
	slot0:openWeb()
end

function slot0.onOpen(slot0)
	slot0:openWeb()
end

function slot0.openWeb(slot0)
	slot0.url = slot0:getUrl()
	slot0.callback = slot0.viewParam.callback
	slot0.callbackObj = slot0.viewParam.callbackObj
	slot0.left = slot0.viewParam.left or WebViewEnum.DefaultMargin.Left
	slot0.right = slot0.viewParam.right or WebViewEnum.DefaultMargin.Right
	slot0.top = slot0.viewParam.top or WebViewEnum.DefaultMargin.Top
	slot0.bottom = slot0.viewParam.bottom or WebViewEnum.DefaultMargin.Bottom
	slot0.autoTop = slot0.viewParam.autoTop or true
	slot0.autoBottom = slot0.viewParam.autoBottom or true

	slot0.webViewComp:Show(slot0.url, slot0.callbackWrap, slot0, slot0.left, not slot0.autoTop and slot0.top or WebViewController.instance:getWebViewTopOffset(nil, , slot0.top), slot0.right, not slot0.autoBottom and slot0.bottom or WebViewController.instance:getWebViewBottomOffset(nil, , slot0.bottom))
	AudioMgr.instance:setRTPCValue(AudioEnum.Volume.Global_Volume, slot0.DEFAULT_OPEN_AUDIO_VOLUME)
end

function slot0.onScreenSizeChanged(slot0, slot1, slot2)
	logNormal(string.format("Change WebView Margins width:%s height:%s", slot1, slot2))
	slot0.webViewComp.webViewObject:SetMargins(slot0.left, not slot0.autoTop and slot0.top or WebViewController.instance:getWebViewTopOffset(slot1, slot2, slot0.top), slot0.right, not slot0.autoBottom and slot0.bottom or WebViewController.instance:getWebViewBottomOffset(slot1, slot2, slot0.bottom))
end

function slot0.getUrl(slot0)
	slot1 = slot0.viewParam.url

	if not slot0.viewParam.needRecordUser then
		return slot1
	end

	return WebViewController.instance:getRecordUserUrl(slot1)
end

function slot0.callbackWrap(slot0, slot1, slot2)
	logNormal(string.format("cur url : %s, cb type : %s, msg : %s", slot0.url, slot1, slot2))

	if slot0.callback then
		return slot0.callback(slot0.callbackObj, slot1, slot2)
	end
end

function slot0.onDestroyView(slot0)
	slot0.webViewComp:Recycle()

	slot0.webViewComp = nil
end

function slot0.onClose(slot0)
	AudioMgr.instance:setRTPCValue(AudioEnum.Volume.Global_Volume, SettingsModel.instance:getGlobalAudioVolume() or slot0.DEFAULT_CLOSE_AUDIO_VOLUME)
end

return slot0
