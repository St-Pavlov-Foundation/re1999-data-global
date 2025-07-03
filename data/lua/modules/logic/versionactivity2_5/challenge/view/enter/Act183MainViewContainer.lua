module("modules.logic.versionactivity2_5.challenge.view.enter.Act183MainViewContainer", package.seeall)

local var_0_0 = class("Act183MainViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, Act183MainView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "root/#go_topleft"))
	table.insert(var_1_0, TabViewGroup.New(2, "root/left/#go_store"))

	local var_1_1 = HelpShowView.New()

	var_1_1:setHelpId(HelpEnum.HelpId.Act183EnterMain)
	table.insert(var_1_0, var_1_1)

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.Act183EnterMain)

		return {
			arg_2_0.navigateView
		}
	elseif arg_2_1 == 2 then
		return {
			Act183StoreEntry.New()
		}
	end
end

return var_0_0
