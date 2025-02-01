module("modules.logic.fight.view.FightCardIntroduceViewContainer", package.seeall)

slot0 = class("FightCardIntroduceViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		FightCardIntroduceView.New()
	}
end

return slot0
