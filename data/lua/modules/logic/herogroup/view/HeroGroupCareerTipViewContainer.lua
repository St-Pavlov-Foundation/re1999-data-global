module("modules.logic.herogroup.view.HeroGroupCareerTipViewContainer", package.seeall)

slot0 = class("HeroGroupCareerTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		HeroGroupCareerTipView.New()
	}
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
end

return slot0
