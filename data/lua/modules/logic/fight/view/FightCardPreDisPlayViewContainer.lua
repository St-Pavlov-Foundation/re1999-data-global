module("modules.logic.fight.view.FightCardPreDisPlayViewContainer", package.seeall)

slot0 = class("FightCardPreDisPlayViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		FightCardPreDisPlayView.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
end

return slot0
