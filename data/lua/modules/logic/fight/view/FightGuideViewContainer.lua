module("modules.logic.fight.view.FightGuideViewContainer", package.seeall)

slot0 = class("FightGuideViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		FightGuideView.New()
	}
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
end

return slot0
