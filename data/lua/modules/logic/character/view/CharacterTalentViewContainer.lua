module("modules.logic.character.view.CharacterTalentViewContainer", package.seeall)

local var_0_0 = class("CharacterTalentViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0.talent_view = CharacterTalentView.New()

	return {
		TabViewGroup.New(1, "#go_btns"),
		arg_1_0.talent_view
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
	arg_5_0._navigateButtonView:resetOnCloseViewAudio(AudioEnum.Talent.play_ui_resonate_close)
end

function var_0_0.playOpenTransition(arg_6_0)
	arg_6_0:onPlayOpenTransitionFinish()
end

function var_0_0.playCloseTransition(arg_7_0)
	var_0_0.super.playCloseTransition(arg_7_0, {
		anim = "charactertalentup_out"
	})

	local var_7_0 = gohelper.findChildComponent(arg_7_0.viewGO, "commen/rentouxiang/ani/tou/tou", typeof(UnityEngine.Animator))

	if var_7_0 then
		gohelper.setActive(gohelper.findChild(arg_7_0.viewGO, "commen/rentouxiang/ani/tou/tou_in"), false)

		var_7_0.enabled = true

		gohelper.setActive(var_7_0.gameObject, true)
		var_7_0:Play("0")
	end

	gohelper.findChildComponent(arg_7_0.viewGO, "commen/rentouxiang/ani", typeof(UnityEngine.Animator)):Play("ani_0")
	gohelper.findChildComponent(arg_7_0.viewGO, "#btn_chessboard", typeof(UnityEngine.Animator)):Play("chessboard_out")
	arg_7_0.talent_view:playChessIconOutAni()
end

return var_0_0
