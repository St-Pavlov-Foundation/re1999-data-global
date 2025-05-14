module("modules.logic.weekwalk.view.WeekWalkEnemyInfoViewRule", package.seeall)

local var_0_0 = class("WeekWalkEnemyInfoViewRule", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goadditionRule = gohelper.findChild(arg_1_0.viewGO, "go_rule/#go_additionRule")
	arg_1_0._goruletemp = gohelper.findChild(arg_1_0.viewGO, "go_rule/#go_additionRule/#go_ruletemp")
	arg_1_0._imagetagicon = gohelper.findChildImage(arg_1_0.viewGO, "go_rule/#go_additionRule/#go_ruletemp/#image_tagicon")
	arg_1_0._gorulelist = gohelper.findChild(arg_1_0.viewGO, "go_rule/#go_additionRule/#go_rulelist")
	arg_1_0._btnadditionRuleclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_rule/#go_additionRule/#go_rulelist/#btn_additionRuleclick")
	arg_1_0._goruledesc = gohelper.findChild(arg_1_0.viewGO, "go_rule/#go_ruledesc")

	gohelper.setActive(arg_1_0._goruledesc, false)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnadditionRuleclick:AddClickListener(arg_2_0._btnadditionRuleOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnadditionRuleclick:RemoveClickListener()
end

function var_0_0._btncloseruleOnClick(arg_4_0)
	if arg_4_0._isHardMode then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.HardModeHideRuleDesc)
	end
end

function var_0_0._btnadditionRuleOnClick(arg_5_0)
	ViewMgr.instance:openView(ViewName.HeroGroupFightRuleDescView, {
		ruleList = arg_5_0._ruleList,
		closeCb = arg_5_0._btncloseruleOnClick,
		closeCbObj = arg_5_0
	})

	if arg_5_0._isHardMode then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.HardModeShowRuleDesc)
	end
end

function var_0_0._editableInitView(arg_6_0)
	gohelper.setActive(arg_6_0._goruleitem, false)
	gohelper.setActive(arg_6_0._goruletemp, false)

	arg_6_0._rulesimageList = arg_6_0:getUserDataTb_()
	arg_6_0._rulesimagelineList = arg_6_0:getUserDataTb_()
	arg_6_0._simageList = arg_6_0:getUserDataTb_()
	arg_6_0._childGoList = arg_6_0:getUserDataTb_()

	gohelper.addUIClickAudio(arg_6_0._btnadditionRuleclick.gameObject, AudioEnum.UI.play_ui_hero_sign)
end

function var_0_0._addRuleItem(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = gohelper.clone(arg_7_0._goruletemp, arg_7_0._gorulelist, arg_7_1.id)

	table.insert(arg_7_0._childGoList, var_7_0)
	gohelper.setActive(var_7_0, true)

	local var_7_1 = gohelper.findChildImage(var_7_0, "#image_tagicon")

	UISpriteSetMgr.instance:setCommonSprite(var_7_1, "wz_" .. arg_7_2)

	local var_7_2 = gohelper.findChildImage(var_7_0, "")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(var_7_2, arg_7_1.icon)
end

function var_0_0.refreshUI(arg_8_0, arg_8_1)
	local var_8_0 = DungeonConfig.instance:getBattleAdditionRule(arg_8_1)

	if string.nilorempty(var_8_0) then
		gohelper.setActive(arg_8_0._goadditionRule, false)

		return
	end

	arg_8_0:_clear()
	gohelper.setActive(arg_8_0._goadditionRule, true)

	local var_8_1 = GameUtil.splitString2(var_8_0, true, "|", "#")

	arg_8_0._ruleList = var_8_1

	for iter_8_0, iter_8_1 in ipairs(var_8_1) do
		local var_8_2 = iter_8_1[1]
		local var_8_3 = iter_8_1[2]
		local var_8_4 = lua_rule.configDict[var_8_3]

		if var_8_4 then
			arg_8_0:_addRuleItem(var_8_4, var_8_2)
		end

		if iter_8_0 == #var_8_1 then
			gohelper.setActive(arg_8_0._rulesimagelineList[iter_8_0], false)
		end
	end
end

function var_0_0._clear(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0._childGoList) do
		gohelper.destroy(iter_9_1)
	end

	arg_9_0._rulesimageList = arg_9_0:getUserDataTb_()
	arg_9_0._rulesimagelineList = arg_9_0:getUserDataTb_()
	arg_9_0._simageList = arg_9_0:getUserDataTb_()
	arg_9_0._childGoList = arg_9_0:getUserDataTb_()
end

function var_0_0.onDestroyView(arg_10_0)
	arg_10_0:_clear()
end

return var_0_0
