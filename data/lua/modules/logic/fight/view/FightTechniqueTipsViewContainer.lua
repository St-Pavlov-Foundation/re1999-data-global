module("modules.logic.fight.view.FightTechniqueTipsViewContainer", package.seeall)

slot0 = class("FightTechniqueTipsViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		FightTechniqueTipsView.New()
	}
end

return slot0
