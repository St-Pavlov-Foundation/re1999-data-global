module("modules.logic.fight.view.FightTechniqueGuideViewContainer", package.seeall)

slot0 = class("FightTechniqueGuideViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		FightTechniqueGuideView.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
end

return slot0
