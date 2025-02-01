module("modules.logic.fight.view.FightChangeHeroSelectSkillTargetViewContainer", package.seeall)

slot0 = class("FightChangeHeroSelectSkillTargetViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		FightChangeHeroSelectSkillTargetView.New()
	}
end

return slot0
