module("modules.logic.webview.view.WebViewContainer", package.seeall)

slot0 = class("WebViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, WebView.New())

	return slot1
end

return slot0
