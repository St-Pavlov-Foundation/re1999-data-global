module("modules.logic.season.view1_5.Season1_5SettlementViewContainer", package.seeall)

slot0 = class("Season1_5SettlementViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Season1_5SettlementView.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		-- Nothing
	end
end

return slot0
