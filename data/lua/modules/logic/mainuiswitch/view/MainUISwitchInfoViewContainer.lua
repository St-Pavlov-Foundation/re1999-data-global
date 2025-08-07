module("modules.logic.mainuiswitch.view.MainUISwitchInfoViewContainer", package.seeall)

local var_0_0 = class("MainUISwitchInfoViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, MainUISwitchInfoView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "middle/#go_mainUI"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		local var_2_0 = {}

		arg_2_0:_addMainUI(var_2_0)

		return var_2_0
	end
end

function var_0_0._addMainUI(arg_3_0, arg_3_1)
	local var_3_0 = {}

	table.insert(var_3_0, SwitchMainUIShowView.New())
	table.insert(var_3_0, SwitchMainActivityEnterView.New())
	table.insert(var_3_0, SwitchMainActExtraDisplay.New())
	table.insert(var_3_0, SwitchMainUIView.New())
	table.insert(var_3_0, SwitchMainUIEagleAnimView.New())

	arg_3_1[1] = MultiView.New(var_3_0)

	return arg_3_1[1]
end

function var_0_0.isInitMainFullView(arg_4_0)
	return false
end

return var_0_0
