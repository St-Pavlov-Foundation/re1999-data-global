module("modules.logic.character.view.CharacterTalentLevelUpViewContainer", package.seeall)

local var_0_0 = class("CharacterTalentLevelUpViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		TabViewGroup.New(1, "#go_lefttop"),
		TabViewGroup.New(2, "#go_righttop"),
		CharacterTalentLevelUpView.New()
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
	elseif arg_2_1 == 2 then
		local var_2_0 = CurrencyEnum.CurrencyType
		local var_2_1 = {
			var_2_0.Gold
		}

		return {
			CurrencyView.New(var_2_1)
		}
	end
end

function var_0_0.playOpenTransition(arg_3_0)
	arg_3_0:onPlayOpenTransitionFinish()
end

function var_0_0.playCloseTransition(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum.Talent.play_ui_resonate_open)
	var_0_0.super.playCloseTransition(arg_4_0, {
		anim = "charactertalentlevelup_out"
	})
	CharacterController.instance:dispatchEvent(CharacterEvent.playTalentViewBackAni, arg_4_0._head_close_ani1 or "2_1", arg_4_0._head_close_ani1 and true or false, arg_4_0._head_close_ani2 or "ani_2_1", true)
end

return var_0_0
