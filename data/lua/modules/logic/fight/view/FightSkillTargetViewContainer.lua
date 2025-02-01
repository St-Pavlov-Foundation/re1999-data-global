module("modules.logic.fight.view.FightSkillTargetViewContainer", package.seeall)

slot0 = class("FightSkillTargetViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		FightSkillTargetView.New()
	}
end

return slot0
