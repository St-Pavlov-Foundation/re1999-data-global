module("modules.logic.season.view.SeasonSettlementViewContainer", package.seeall)

slot0 = class("SeasonSettlementViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		SeasonSettlementView.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		-- Nothing
	end
end

return slot0
