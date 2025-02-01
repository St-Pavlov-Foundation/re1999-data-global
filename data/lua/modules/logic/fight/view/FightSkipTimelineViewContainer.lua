module("modules.logic.fight.view.FightSkipTimelineViewContainer", package.seeall)

slot0 = class("FightSkipTimelineViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		FightSkipTimelineView.New()
	}
end

return slot0
