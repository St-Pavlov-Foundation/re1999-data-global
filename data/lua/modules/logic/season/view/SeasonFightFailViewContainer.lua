module("modules.logic.season.view.SeasonFightFailViewContainer", package.seeall)

slot0 = class("SeasonFightFailViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		SeasonFightFailView.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		-- Nothing
	end
end

return slot0
