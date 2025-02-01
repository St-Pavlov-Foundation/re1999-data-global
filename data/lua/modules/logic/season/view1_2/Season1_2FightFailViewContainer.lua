module("modules.logic.season.view1_2.Season1_2FightFailViewContainer", package.seeall)

slot0 = class("Season1_2FightFailViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Season1_2FightFailView.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		-- Nothing
	end
end

return slot0
