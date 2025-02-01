module("modules.logic.versionactivity2_2.act173.view.Activity173FullViewContainer", package.seeall)

slot0 = class("Activity173FullViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, Activity173FullView.New())

	return slot1
end

function slot0.playCloseTransition(slot0)
	slot0:startViewCloseBlock()
	SLFramework.AnimatorPlayer.Get(slot0.viewGO):Play(UIAnimationName.Close, slot0.onPlayCloseTransitionFinish, slot0)
end

return slot0
