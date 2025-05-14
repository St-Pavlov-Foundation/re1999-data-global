module("modules.logic.bossrush.view.V1a4_BossRushLevelDetailContainer", package.seeall)

local var_0_0 = class("V1a4_BossRushLevelDetailContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0._bossRushViewRule = V1a4_BossRushViewRule.New()
	arg_1_0._levelDetail = V1a4_BossRushLevelDetail.New()

	return {
		arg_1_0._levelDetail,
		TabViewGroup.New(1, "top_left"),
		arg_1_0._bossRushViewRule
	}
end

function var_0_0.getBossRushViewRule(arg_2_0)
	return arg_2_0._bossRushViewRule
end

function var_0_0.buildTabViews(arg_3_0, arg_3_1)
	if arg_3_1 == 1 then
		arg_3_0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		}, 100, arg_3_0._closeCallback, nil, nil, arg_3_0)

		return {
			arg_3_0._navigateButtonView
		}
	end
end

function var_0_0.playCloseTransition(arg_4_0)
	arg_4_0._levelDetail:playCloseTransition()
end

function var_0_0.playOpenTransition(arg_5_0)
	arg_5_0:onPlayOpenTransitionFinish()
end

function var_0_0.diffRootChild(arg_6_0, arg_6_1)
	arg_6_0:setRootChild(arg_6_1)

	return true
end

function var_0_0.setRootChild(arg_7_0, arg_7_1)
	local var_7_0 = gohelper.findChild(arg_7_1.viewGO, "DetailPanel/Condition")

	arg_7_1._goadditionRule = gohelper.findChild(var_7_0, "#scroll_ConditionIcons")
	arg_7_1._goruletemp = gohelper.findChild(arg_7_1._goadditionRule, "#go_ruletemp")
	arg_7_1._imagetagicon = gohelper.findChildImage(arg_7_1._goruletemp, "#image_tagicon")
	arg_7_1._gorulelist = gohelper.findChild(arg_7_1._goadditionRule, "Viewport/content")
	arg_7_1._btnadditionRuleclick = gohelper.findChildButtonWithAudio(arg_7_1._goadditionRule, "#btn_additionRuleclick")
end

return var_0_0
