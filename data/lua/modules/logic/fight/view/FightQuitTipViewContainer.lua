module("modules.logic.fight.view.FightQuitTipViewContainer", package.seeall)

slot0 = class("FightQuitTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		FightQuitTipView.New(),
		Season166FightQuitTipView.New()
	}
end

return slot0
