module("modules.logic.season.view1_4.Season1_4SettlementViewContainer", package.seeall)

slot0 = class("Season1_4SettlementViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Season1_4SettlementView.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		-- Nothing
	end
end

return slot0
