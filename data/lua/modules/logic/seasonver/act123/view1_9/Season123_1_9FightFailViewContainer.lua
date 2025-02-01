module("modules.logic.seasonver.act123.view1_9.Season123_1_9FightFailViewContainer", package.seeall)

slot0 = class("Season123_1_9FightFailViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Season123_1_9FightFailView.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		-- Nothing
	end
end

return slot0
