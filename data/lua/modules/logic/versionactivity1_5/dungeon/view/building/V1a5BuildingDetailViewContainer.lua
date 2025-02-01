module("modules.logic.versionactivity1_5.dungeon.view.building.V1a5BuildingDetailViewContainer", package.seeall)

slot0 = class("V1a5BuildingDetailViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		V1a5BuildingDetailView.New(),
		TabViewGroup.New(1, "#go_topleft"),
		TabViewGroup.New(2, "#go_topright")
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				false,
				false
			})
		}
	elseif slot1 == 2 then
		return {
			CurrencyView.New({
				CurrencyEnum.CurrencyType.V1a5DungeonBuild
			})
		}
	end
end

return slot0
