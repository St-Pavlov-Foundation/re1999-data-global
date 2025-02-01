module("modules.logic.activity.view.V1a5_HarvestSeason_FullSignViewContainer", package.seeall)

slot0 = class("V1a5_HarvestSeason_FullSignViewContainer", V1a5_HarvestSeason_SignItem_SignViewContainer)

function slot0.onGetMainViewClassType(slot0)
	return V1a5_HarvestSeason_FullSignView
end

return slot0
