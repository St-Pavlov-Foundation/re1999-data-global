module("modules.logic.versionactivity2_0.dungeon.view.graffiti.VersionActivity2_0DungeonGraffitiViewContainer", package.seeall)

local var_0_0 = class("VersionActivity2_0DungeonGraffitiViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, VersionActivity2_0DungeonGraffitiView.New())
	table.insert(var_1_0, VersionActivity2_0DungeonGraffitiRewardView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_topleft"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			arg_2_0._navigateButtonView
		}
	end
end

function var_0_0._overrideCloseFunc(arg_3_0)
	return
end

return var_0_0
