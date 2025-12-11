module("modules.logic.necrologiststory.view.NecrologistStoryViewContainer", package.seeall)

local var_0_0 = class("NecrologistStoryViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, NecrologistStoryButtonView.New())

	arg_1_0._storyView = NecrologistStoryView.New()

	table.insert(var_1_0, arg_1_0._storyView)
	table.insert(var_1_0, TabViewGroup.New(1, "#go_topleft"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		local var_2_0 = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			var_2_0
		}
	end
end

function var_0_0.getLastItem(arg_3_0)
	return arg_3_0._storyView:getLastItem()
end

return var_0_0
