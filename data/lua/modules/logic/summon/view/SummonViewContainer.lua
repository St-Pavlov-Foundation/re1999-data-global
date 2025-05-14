module("modules.logic.summon.view.SummonViewContainer", package.seeall)

local var_0_0 = class("SummonViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, TabViewGroup.New(1, "#go_content"))
	table.insert(var_1_0, SummonView.New())

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		return {
			MultiView.New({
				SummonCharView.New()
			}),
			MultiView.New({
				SummonEquipView.New(),
				SummonEquipFloatView.New()
			})
		}
	end
end

return var_0_0
