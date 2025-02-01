module("modules.logic.herogroup.view.HeroGroupModifyNameViewContainer", package.seeall)

slot0 = class("HeroGroupModifyNameViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		HeroGroupModifyNameView.New()
	}
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
end

function slot0.playOpenTransition(slot0)
	slot0:onPlayOpenTransitionFinish()
end

return slot0
