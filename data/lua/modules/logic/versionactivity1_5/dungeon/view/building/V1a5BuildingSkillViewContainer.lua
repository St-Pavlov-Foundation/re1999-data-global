module("modules.logic.versionactivity1_5.dungeon.view.building.V1a5BuildingSkillViewContainer", package.seeall)

local var_0_0 = class("V1a5BuildingSkillViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		V1a5BuildingSkillView.New(),
		TabViewGroup.New(1, "#go_topleft")
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
	end
end

return var_0_0
