module("modules.logic.season.view.SeasonFightSuccViewContainer", package.seeall)

slot0 = class("SeasonFightSuccViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		SeasonFightSuccView.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		-- Nothing
	end
end

return slot0
