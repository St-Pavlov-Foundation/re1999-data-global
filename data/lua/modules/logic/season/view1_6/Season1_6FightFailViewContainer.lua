module("modules.logic.season.view1_6.Season1_6FightFailViewContainer", package.seeall)

slot0 = class("Season1_6FightFailViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Season1_6FightFailView.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		-- Nothing
	end
end

return slot0
