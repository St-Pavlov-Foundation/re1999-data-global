module("modules.logic.survival.view.handbook.SurvivalHandbookViewContainer", package.seeall)

local var_0_0 = class("SurvivalHandbookViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		TabViewGroup.New(1, "#go_btns"),
		SurvivalHandbookView.New()
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			arg_2_0.navigateButtonView
		}
	end
end

function var_0_0.onContainerOpenFinish(arg_3_0)
	arg_3_0.navigateButtonView:resetOnCloseViewAudio(AudioEnum.UI.Play_UI_Universal_Click)
end

return var_0_0
