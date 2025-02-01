module("modules.logic.fight.view.FightCareerIntroduceViewContainer", package.seeall)

slot0 = class("FightCareerIntroduceViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		FightCareerIntroduceView.New()
	}
end

return slot0
