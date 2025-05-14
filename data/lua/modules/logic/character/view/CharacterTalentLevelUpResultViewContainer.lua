module("modules.logic.character.view.CharacterTalentLevelUpResultViewContainer", package.seeall)

local var_0_0 = class("CharacterTalentLevelUpResultViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		CharacterTalentLevelUpResultView.New(),
		TabViewGroup.New(1, "#go_lefttop")
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

function var_0_0.playOpenTransition(arg_3_0)
	arg_3_0:onPlayOpenTransitionFinish()
end

function var_0_0.playCloseTransition(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum.Talent.play_ui_resonate_success_close)
	var_0_0.super.playCloseTransition(arg_4_0, {
		anim = "charactertalentlevelupresult_out"
	})
	CharacterController.instance:dispatchEvent(CharacterEvent.playTalentLevelUpViewInAni)
end

return var_0_0
