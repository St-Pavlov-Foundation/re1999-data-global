module("modules.logic.toughbattle.view.ToughBattleSkillViewContainer", package.seeall)

slot0 = class("ToughBattleSkillViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		ToughBattleSkillView.New()
	}
end

return slot0
