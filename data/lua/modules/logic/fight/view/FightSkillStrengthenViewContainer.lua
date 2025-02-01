module("modules.logic.fight.view.FightSkillStrengthenViewContainer", package.seeall)

slot0 = class("FightSkillStrengthenViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		FightSkillStrengthenView.New()
	}
end

return slot0
