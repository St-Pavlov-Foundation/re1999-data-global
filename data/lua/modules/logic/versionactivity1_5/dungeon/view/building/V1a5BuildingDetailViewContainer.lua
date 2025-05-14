module("modules.logic.versionactivity1_5.dungeon.view.building.V1a5BuildingDetailViewContainer", package.seeall)

local var_0_0 = class("V1a5BuildingDetailViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		V1a5BuildingDetailView.New(),
		TabViewGroup.New(1, "#go_topleft"),
		TabViewGroup.New(2, "#go_topright")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				false,
				false
			})
		}
	elseif arg_2_1 == 2 then
		return {
			CurrencyView.New({
				CurrencyEnum.CurrencyType.V1a5DungeonBuild
			})
		}
	end
end

return var_0_0
