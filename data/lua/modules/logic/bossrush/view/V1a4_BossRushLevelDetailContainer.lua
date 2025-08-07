module("modules.logic.bossrush.view.V1a4_BossRushLevelDetailContainer", package.seeall)

local var_0_0 = class("V1a4_BossRushLevelDetailContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0._bossRushViewRule = V1a4_BossRushViewRule.New()

	local var_1_0 = BossRushConfig.instance:getActivityId()
	local var_1_1 = arg_1_0:_getHelpId(var_1_0)
	local var_1_2 = BossRushModel.instance:getActivityMainView()

	arg_1_0._levelDetail = (var_1_2 and var_1_2.LevelDetail or V1a4_BossRushLevelDetail).New()

	local var_1_3 = {
		arg_1_0._levelDetail,
		TabViewGroup.New(1, "top_left"),
		arg_1_0._bossRushViewRule
	}

	if var_1_1 then
		local var_1_4 = HelpShowView.New()

		var_1_4:setHelpId(var_1_1)
		var_1_4:setDelayTime(0.5)
		table.insert(var_1_3, var_1_4)
	end

	return var_1_3
end

function var_0_0._getHelpId(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0.viewParam.stage

	if var_2_0 then
		if not arg_2_0._stageHelpId then
			arg_2_0._stageHelpId = {
				[VersionActivity2_9Enum.ActivityId.BossRush] = {
					HelpEnum.HelpId.BossRushViewHelpSp01_1,
					HelpEnum.HelpId.BossRushViewHelpSp01_2
				}
			}
		end

		local var_2_1 = arg_2_0._stageHelpId[arg_2_1]

		return var_2_1 and var_2_1[var_2_0]
	end
end

function var_0_0.getBossRushViewRule(arg_3_0)
	return arg_3_0._bossRushViewRule
end

function var_0_0.buildTabViews(arg_4_0, arg_4_1)
	if arg_4_1 == 1 then
		local var_4_0 = BossRushConfig.instance:getActivityId()
		local var_4_1 = arg_4_0:_getHelpId(var_4_0)
		local var_4_2 = var_4_1 ~= nil

		arg_4_0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			var_4_2
		}, var_4_1 or 100, arg_4_0._closeCallback, nil, nil, arg_4_0)

		return {
			arg_4_0._navigateButtonView
		}
	end
end

function var_0_0.playCloseTransition(arg_5_0)
	arg_5_0._levelDetail:playCloseTransition()
end

function var_0_0.playOpenTransition(arg_6_0)
	arg_6_0:onPlayOpenTransitionFinish()
end

function var_0_0.diffRootChild(arg_7_0, arg_7_1)
	arg_7_0:setRootChild(arg_7_1)

	return true
end

function var_0_0.setRootChild(arg_8_0, arg_8_1)
	local var_8_0 = gohelper.findChild(arg_8_1.viewGO, "DetailPanel/Condition")

	arg_8_1._goadditionRule = gohelper.findChild(var_8_0, "#scroll_ConditionIcons")
	arg_8_1._goruletemp = gohelper.findChild(arg_8_1._goadditionRule, "#go_ruletemp")
	arg_8_1._imagetagicon = gohelper.findChildImage(arg_8_1._goruletemp, "#image_tagicon")
	arg_8_1._gorulelist = gohelper.findChild(arg_8_1._goadditionRule, "Viewport/content")
	arg_8_1._btnadditionRuleclick = gohelper.findChildButtonWithAudio(arg_8_1._goadditionRule, "#btn_additionRuleclick")
end

return var_0_0
