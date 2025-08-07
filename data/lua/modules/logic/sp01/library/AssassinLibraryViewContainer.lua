module("modules.logic.sp01.library.AssassinLibraryViewContainer", package.seeall)

local var_0_0 = class("AssassinLibraryViewContainer", BaseViewContainer)
local var_0_1 = 1
local var_0_2 = AssassinEnum.LibraryInfoViewTabId

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, AssassinLibraryView.New())
	table.insert(var_1_0, TabViewGroup.New(var_0_1, "root/#go_topleft"))
	table.insert(var_1_0, TabViewGroup.New(var_0_2, "root/#go_container"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == var_0_1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			arg_2_0.navigateView
		}
	elseif arg_2_1 == var_0_2 then
		return {
			AssassinLibraryHeroView.New(),
			AssassinLibraryListView.New(),
			AssassinLibraryVideoListView.New()
		}
	end
end

function var_0_0.switchLibType(arg_3_0, arg_3_1)
	local var_3_0 = AssassinEnum.LibraryType2TabViewId[arg_3_1]

	arg_3_0:dispatchEvent(ViewEvent.ToSwitchTab, var_0_2, var_3_0)
end

return var_0_0
