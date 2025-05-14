module("modules.logic.summon.view.SummonHeroDetailViewContainer", package.seeall)

local var_0_0 = class("SummonHeroDetailViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, SummonHeroDetailView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_lefttop"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		local var_2_0 = true

		if arg_2_0.viewParam and arg_2_0.viewParam.showHome ~= nil then
			var_2_0 = arg_2_0.viewParam.showHome
		end

		return {
			NavigateButtonsView.New({
				true,
				var_2_0,
				false
			})
		}
	end
end

return var_0_0
