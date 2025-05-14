module("modules.logic.character.view.CharacterExSkillViewContainer", package.seeall)

local var_0_0 = class("CharacterExSkillViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		CharacterExSkillView.New(),
		TabViewGroup.New(1, "#go_btn"),
		CommonRainEffectView.New("bg/#go_glowcontainer")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	arg_2_0.navigateView = NavigateButtonsView.New({
		true,
		true,
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

function var_0_0.hideHomeBtn(arg_4_0)
	arg_4_0.navigateView:setParam({
		true,
		false,
		false
	})
end

return var_0_0
