module("modules.logic.versionactivity1_3.buff.view.VersionActivity1_3BuffViewContainer", package.seeall)

local var_0_0 = class("VersionActivity1_3BuffViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0.buffView = VersionActivity1_3BuffView.New()

	return {
		arg_1_0.buffView,
		TabViewGroup.New(1, "#go_BackBtns")
	}
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
