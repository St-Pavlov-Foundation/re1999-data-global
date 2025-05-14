module("modules.logic.bgmswitch.view.BGMSwitchViewContainer", package.seeall)

local var_0_0 = class("BGMSwitchViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		BGMSwitchMechineView.New(),
		BGMSwitchMusicView.New(),
		BGMSwitchEggView.New(),
		TabViewGroup.New(1, "#go_btns"),
		BGMSwitchView.New()
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigationView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		arg_2_0.navigationView:setHelpId(HelpEnum.HelpId.BgmView)

		return {
			arg_2_0.navigationView
		}
	end
end

return var_0_0
