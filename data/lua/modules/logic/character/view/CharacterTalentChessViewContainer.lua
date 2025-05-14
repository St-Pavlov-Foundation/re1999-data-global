module("modules.logic.character.view.CharacterTalentChessViewContainer", package.seeall)

local var_0_0 = class("CharacterTalentChessViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0.chess_view = CharacterTalentChessView.New()

	return {
		TabViewGroup.New(1, "#go_btns"),
		arg_1_0.chess_view
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.Talent)

		return {
			arg_2_0._navigateButtonView
		}
	end
end

function var_0_0.onContainerInit(arg_3_0)
	HelpController.instance:registerCallback(HelpEvent.RefreshHelp, arg_3_0._navigateButtonView.showHelpBtnIcon, arg_3_0._navigateButtonView)
end

function var_0_0.onContainerDestroy(arg_4_0)
	HelpController.instance:unregisterCallback(HelpEvent.RefreshHelp, arg_4_0._navigateButtonView.showHelpBtnIcon, arg_4_0._navigateButtonView)
end

function var_0_0.onContainerOpenFinish(arg_5_0)
	arg_5_0._navigateButtonView:resetOnCloseViewAudio(AudioEnum.UI.play_ui_checkpoint_click)
end

function var_0_0.playOpenTransition(arg_6_0)
	arg_6_0:onPlayOpenTransitionFinish()
end

function var_0_0.playCloseTransition(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.Talent.play_ui_resonate_property_close)
	var_0_0.super.playCloseTransition(arg_7_0, {
		anim = "charactertalentchess_out"
	})
	CharacterController.instance:dispatchEvent(CharacterEvent.playTalentViewBackAni, "3_1", false, "ani_3_1", true)
	arg_7_0.chess_view:playChessIconOutAni()
end

return var_0_0
