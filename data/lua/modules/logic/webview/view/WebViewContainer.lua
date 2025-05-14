module("modules.logic.webview.view.WebViewContainer", package.seeall)

local var_0_0 = class("WebViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, WebView.New())

	return var_1_0
end

return var_0_0
