module("modules.common.global.screen.GameLoadingState", package.seeall)

slot0 = class("GameLoadingState")
slot0.LoadingView = 1
slot0.LoadingBlackView = 2
slot0.LoadingBlackView2 = 3
slot0.LoadingHeadsetView = 4
slot0.LoadingRoomView = 5
slot0.LoadingDownloadView = 6
slot0.LoadingCachotView = 7
slot0.LoadingCachotChangeView = 8
slot1 = {
	[slot0.LoadingView] = ViewName.LoadingView,
	[slot0.LoadingBlackView] = ViewName.LoadingBlackView,
	[slot0.LoadingBlackView2] = ViewName.LoadingBlackView2,
	[slot0.LoadingHeadsetView] = ViewName.LoadingHeadsetView,
	[slot0.LoadingRoomView] = ViewName.LoadingRoomView,
	[slot0.LoadingDownloadView] = ViewName.LoadingDownloadView,
	[slot0.LoadingCachotView] = ViewName.V1a6_CachotLoadingView,
	[slot0.LoadingCachotChangeView] = ViewName.V1a6_CachotLayerChangeView
}
slot2 = {
	[ViewName.LoadingView] = slot0.LoadingView,
	[ViewName.LoadingBlackView] = slot0.LoadingBlackView,
	[ViewName.LoadingBlackView2] = slot0.LoadingBlackView2,
	[ViewName.LoadingHeadsetView] = slot0.LoadingHeadsetView,
	[ViewName.LoadingRoomView] = slot0.LoadingRoomView,
	[ViewName.LoadingDownloadView] = slot0.LoadingDownloadView,
	[ViewName.V1a6_CachotLoadingView] = slot0.LoadingCachotView,
	[ViewName.V1a6_CachotLayerChangeView] = slot0.LoadingCachotChangeView
}

function slot0.ctor(slot0)
	slot0:addConstEvents()

	slot0._loadingType = nil
	slot0._showLoadingView = nil
end

function slot0.addConstEvents(slot0)
	GameSceneMgr.instance:registerCallback(SceneEventName.OpenLoading, slot0._openLoading, slot0)
	GameSceneMgr.instance:registerCallback(SceneEventName.CloseLoading, slot0._closeLoading, slot0)
	GameSceneMgr.instance:registerCallback(SceneEventName.SetLoadingTypeOnce, slot0._setLoadingTypeOnce, slot0)
	GameSceneMgr.instance:registerCallback(SceneEventName.WaitViewOpenCloseLoading, slot0._waitViewOpenCloseLoading, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0._checkOpenView, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, slot0._onCloseView, slot0)
end

function slot0.getLoadingType(slot0)
	return slot0._loadingType
end

function slot0._onCloseView(slot0, slot1)
	if uv0[slot1] then
		slot0._showLoadingView = nil
	end
end

function slot0._setLoadingTypeOnce(slot0, slot1)
	slot0._loadingType = tonumber(slot1)
end

function slot0._checkOpenView(slot0, slot1, slot2)
	if slot0._viewName and slot0._viewName == slot1 then
		slot0._viewName = nil

		slot0:_closeLoading()
	end
end

function slot0._waitViewOpenCloseLoading(slot0, slot1)
	logNormal("GameLoadingState waitViewName:" .. slot1)

	slot0._viewName = slot1
end

function slot0.getLoadingViewName(slot0)
	return slot0._showLoadingView
end

function slot0._openLoading(slot0, slot1, slot2)
	if slot0._showLoadingView then
		GameSceneMgr.instance:dispatchEvent(SceneEventName.AgainOpenLoading)
	else
		slot0._loadingType = nil
		slot4 = slot0._loadingType and uv0[slot3] or uv0[1]
		slot0._showLoadingView = slot4

		ViewMgr.instance:openView(slot4, slot1)
	end
end

function slot0._closeLoading(slot0)
	if slot0._viewName then
		return
	end

	if slot0._showLoadingView == ViewName.LoadingView then
		if ViewMgr.instance:isOpen(ViewName.LoadingView) then
			GameSceneMgr.instance:dispatchEvent(SceneEventName.DelayCloseLoading)
		elseif ViewMgr.instance:isOpening(slot0._showLoadingView) then
			ViewMgr.instance:closeView(slot0._showLoadingView)
		else
			slot0._showLoadingView = nil
		end
	elseif slot0._showLoadingView == ViewName.LoadingHeadsetView then
		-- Nothing
	elseif slot0._showLoadingView == ViewName.V1a6_CachotLoadingView then
		-- Nothing
	elseif slot0._showLoadingView ~= ViewName.V1a6_CachotLayerChangeView then
		ViewMgr.instance:closeView(slot0._showLoadingView)

		slot0._showLoadingView = nil
	end
end

return slot0
