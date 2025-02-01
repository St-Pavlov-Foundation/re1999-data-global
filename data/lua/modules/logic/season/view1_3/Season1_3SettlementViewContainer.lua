module("modules.logic.season.view1_3.Season1_3SettlementViewContainer", package.seeall)

slot0 = class("Season1_3SettlementViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Season1_3SettlementView.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		-- Nothing
	end
end

return slot0
