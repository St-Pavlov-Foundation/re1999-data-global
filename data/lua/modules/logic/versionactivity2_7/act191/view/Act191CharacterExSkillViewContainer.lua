module("modules.logic.versionactivity2_7.act191.view.Act191CharacterExSkillViewContainer", package.seeall)

local var_0_0 = class("Act191CharacterExSkillViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		Act191CharacterExSkillView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	arg_2_0.navigateView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	return {
		arg_2_0.navigateView
	}
end

function var_0_0.onContainerOpenFinish(arg_3_0)
	arg_3_0.navigateView:resetCloseBtnAudioId(AudioEnum.UI.Play_ui_mould_close)
	arg_3_0.navigateView:resetHomeBtnAudioId(AudioEnum.UI.Play_ui_mould_close)
end

return var_0_0
