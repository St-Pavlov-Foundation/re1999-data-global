module("modules.logic.scene.view.LoadingRoomViewContainer", package.seeall)

slot0 = class("LoadingRoomViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		LoadingRoomView.New()
	}
end

function slot0.playCloseTransition(slot0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	uv0.super.playCloseTransition(slot0)
end

function slot0.onPlayCloseTransitionFinish(slot0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	uv0.super.onPlayCloseTransitionFinish(slot0)
end

return slot0
