module("modules.logic.handbook.view.HandbookCGDetailViewContainer", package.seeall)

local var_0_0 = class("HandbookCGDetailViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, HandbookCGDetailView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_ui/#go_btns"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	end
end

return var_0_0
