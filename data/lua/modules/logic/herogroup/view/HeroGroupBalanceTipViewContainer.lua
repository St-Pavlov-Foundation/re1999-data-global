module("modules.logic.herogroup.view.HeroGroupBalanceTipViewContainer", package.seeall)

slot0 = class("HeroGroupBalanceTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		HeroGroupBalanceTipView.New()
	}
end

return slot0
