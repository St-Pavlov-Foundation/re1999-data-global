module("modules.logic.seasonver.act123.view2_0.Season123_2_0FightFailViewContainer", package.seeall)

slot0 = class("Season123_2_0FightFailViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Season123_2_0FightFailView.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		-- Nothing
	end
end

return slot0
