module("modules.logic.fight.view.FightFocusViewContainer", package.seeall)

local var_0_0 = class("FightFocusViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		FightFocusView.New(),
		TabViewGroup.New(1, "fightinfocontainer/skilltipview")
	}
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	arg_2_0:closeThis()
end

function var_0_0.buildTabViews(arg_3_0, arg_3_1)
	if arg_3_1 == 1 then
		arg_3_0._skillTipView = SkillTipView.New()

		return {
			arg_3_0._skillTipView
		}
	end
end

function var_0_0.switchTab(arg_4_0, arg_4_1)
	arg_4_0:dispatchEvent(ViewEvent.ToSwitchTab, 1, arg_4_1)
end

function var_0_0.showSkillTipView(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0._skillTipView:showInfo(arg_5_1, arg_5_2, arg_5_3)
end

function var_0_0.hideSkillTipView(arg_6_0)
	arg_6_0._skillTipView:hideInfo()
end

function var_0_0.playOpenTransition(arg_7_0)
	var_0_0.super.playOpenTransition(arg_7_0, {
		anim = "open"
	})
end

function var_0_0.playCloseTransition(arg_8_0)
	var_0_0.super.playCloseTransition(arg_8_0, {
		anim = "close"
	})
end

return var_0_0
