module("modules.logic.equip.view.EquipInfoTipsViewContainer", package.seeall)

slot0 = class("EquipInfoTipsViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0.tipView = EquipInfoTipsView.New()

	return {
		slot0.tipView
	}
end

function slot0.buildTabViews(slot0, slot1)
end

function slot0.playCloseTransition(slot0)
	slot0:startViewCloseBlock()
	slot0.tipView.animatorPlayer:Play(UIAnimationName.Close, slot0.onPlayCloseTransitionFinish, slot0)
	TaskDispatcher.runDelay(slot0.onPlayCloseTransitionFinish, slot0, 2)
end

return slot0
