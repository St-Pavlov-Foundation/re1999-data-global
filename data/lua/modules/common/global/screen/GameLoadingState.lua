module("modules.common.global.screen.GameLoadingState", package.seeall)

local var_0_0 = class("GameLoadingState")

var_0_0.LoadingView = 1
var_0_0.LoadingBlackView = 2
var_0_0.LoadingBlackView2 = 3
var_0_0.LoadingHeadsetView = 4
var_0_0.LoadingRoomView = 5
var_0_0.LoadingDownloadView = 6
var_0_0.LoadingCachotView = 7
var_0_0.LoadingCachotChangeView = 8

local var_0_1 = {
	[var_0_0.LoadingView] = ViewName.LoadingView,
	[var_0_0.LoadingBlackView] = ViewName.LoadingBlackView,
	[var_0_0.LoadingBlackView2] = ViewName.LoadingBlackView2,
	[var_0_0.LoadingHeadsetView] = ViewName.LoadingHeadsetView,
	[var_0_0.LoadingRoomView] = ViewName.LoadingRoomView,
	[var_0_0.LoadingDownloadView] = ViewName.LoadingDownloadView,
	[var_0_0.LoadingCachotView] = ViewName.V1a6_CachotLoadingView,
	[var_0_0.LoadingCachotChangeView] = ViewName.V1a6_CachotLayerChangeView
}
local var_0_2 = {
	[ViewName.LoadingView] = var_0_0.LoadingView,
	[ViewName.LoadingBlackView] = var_0_0.LoadingBlackView,
	[ViewName.LoadingBlackView2] = var_0_0.LoadingBlackView2,
	[ViewName.LoadingHeadsetView] = var_0_0.LoadingHeadsetView,
	[ViewName.LoadingRoomView] = var_0_0.LoadingRoomView,
	[ViewName.LoadingDownloadView] = var_0_0.LoadingDownloadView,
	[ViewName.V1a6_CachotLoadingView] = var_0_0.LoadingCachotView,
	[ViewName.V1a6_CachotLayerChangeView] = var_0_0.LoadingCachotChangeView
}

function var_0_0.ctor(arg_1_0)
	arg_1_0:addConstEvents()

	arg_1_0._loadingType = nil
	arg_1_0._showLoadingView = nil
end

function var_0_0.addConstEvents(arg_2_0)
	GameSceneMgr.instance:registerCallback(SceneEventName.OpenLoading, arg_2_0._openLoading, arg_2_0)
	GameSceneMgr.instance:registerCallback(SceneEventName.CloseLoading, arg_2_0._closeLoading, arg_2_0)
	GameSceneMgr.instance:registerCallback(SceneEventName.SetLoadingTypeOnce, arg_2_0._setLoadingTypeOnce, arg_2_0)
	GameSceneMgr.instance:registerCallback(SceneEventName.WaitViewOpenCloseLoading, arg_2_0._waitViewOpenCloseLoading, arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_2_0._checkOpenView, arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_2_0._onCloseView, arg_2_0)
end

function var_0_0.getLoadingType(arg_3_0)
	return arg_3_0._loadingType
end

function var_0_0._onCloseView(arg_4_0, arg_4_1)
	if var_0_2[arg_4_1] then
		arg_4_0._showLoadingView = nil
	end
end

function var_0_0._setLoadingTypeOnce(arg_5_0, arg_5_1)
	arg_5_0._loadingType = tonumber(arg_5_1)
end

function var_0_0._checkOpenView(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0._viewName and arg_6_0._viewName == arg_6_1 then
		arg_6_0._viewName = nil

		arg_6_0:_closeLoading()
	end
end

function var_0_0._waitViewOpenCloseLoading(arg_7_0, arg_7_1)
	logNormal("GameLoadingState waitViewName:" .. arg_7_1)

	arg_7_0._viewName = arg_7_1
end

function var_0_0.getLoadingViewName(arg_8_0)
	return arg_8_0._showLoadingView
end

function var_0_0._openLoading(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_0._showLoadingView then
		GameSceneMgr.instance:dispatchEvent(SceneEventName.AgainOpenLoading)
	else
		local var_9_0 = arg_9_0._loadingType

		arg_9_0._loadingType = nil

		local var_9_1 = var_9_0 and var_0_1[var_9_0] or var_0_1[1]

		arg_9_0._showLoadingView = var_9_1

		ViewMgr.instance:openView(var_9_1, arg_9_1)
	end
end

function var_0_0._closeLoading(arg_10_0)
	if arg_10_0._viewName then
		return
	end

	if arg_10_0._showLoadingView == ViewName.LoadingView then
		if ViewMgr.instance:isOpen(ViewName.LoadingView) then
			GameSceneMgr.instance:dispatchEvent(SceneEventName.DelayCloseLoading)
		elseif ViewMgr.instance:isOpening(arg_10_0._showLoadingView) then
			ViewMgr.instance:closeView(arg_10_0._showLoadingView)
		else
			arg_10_0._showLoadingView = nil
		end
	elseif arg_10_0._showLoadingView == ViewName.LoadingHeadsetView then
		-- block empty
	elseif arg_10_0._showLoadingView == ViewName.V1a6_CachotLoadingView then
		-- block empty
	elseif arg_10_0._showLoadingView == ViewName.V1a6_CachotLayerChangeView then
		-- block empty
	else
		ViewMgr.instance:closeView(arg_10_0._showLoadingView)

		arg_10_0._showLoadingView = nil
	end
end

return var_0_0
