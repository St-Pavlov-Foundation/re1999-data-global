module("modules.logic.seasonver.act123.view2_0.Season123_2_0EnemyRule", package.seeall)

local var_0_0 = class("Season123_2_0EnemyRule", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goadditionRule = gohelper.findChild(arg_1_0.viewGO, "go_rule/#go_additionRule")
	arg_1_0._goruletemp = gohelper.findChild(arg_1_0.viewGO, "go_rule/#go_additionRule/#go_ruletemp")
	arg_1_0._imagetagicon = gohelper.findChildImage(arg_1_0.viewGO, "go_rule/#go_additionRule/#go_ruletemp/#image_tagicon")
	arg_1_0._gorulelist = gohelper.findChild(arg_1_0.viewGO, "go_rule/#go_additionRule/#go_rulelist")
	arg_1_0._btnadditionRuleclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_rule/#go_additionRule/#go_rulelist/#btn_additionRuleclick")
	arg_1_0._goruledesc = gohelper.findChild(arg_1_0.viewGO, "go_rule/#go_ruledesc")
	arg_1_0._btncloserule = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_rule/#go_ruledesc/#btn_closerule")
	arg_1_0._goruleitem = gohelper.findChild(arg_1_0.viewGO, "go_rule/#go_ruledesc/bg/#go_ruleitem")
	arg_1_0._goruleDescList = gohelper.findChild(arg_1_0.viewGO, "go_rule/#go_ruledesc/bg/#go_ruleDescList")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnadditionRuleclick:AddClickListener(arg_2_0._btnadditionRuleOnClick, arg_2_0)
	arg_2_0._btncloserule:AddClickListener(arg_2_0._btncloseruleOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnadditionRuleclick:RemoveClickListener()
	arg_3_0._btncloserule:RemoveClickListener()
end

function var_0_0._btncloseruleOnClick(arg_4_0)
	if arg_4_0._ruleItemClick then
		arg_4_0._ruleItemClick = false

		return
	end

	gohelper.setActive(arg_4_0._goruledesc, false)
end

function var_0_0._btnadditionRuleOnClick(arg_5_0)
	arg_5_0._ruleItemClick = arg_5_0._goruledesc.activeSelf

	gohelper.setActive(arg_5_0._goruledesc, true)
end

function var_0_0._editableInitView(arg_6_0)
	gohelper.setActive(arg_6_0._goruleitem, false)
	gohelper.setActive(arg_6_0._goruletemp, false)
	gohelper.setActive(arg_6_0._goruledesc, false)

	arg_6_0._rulesimagelineList = arg_6_0:getUserDataTb_()
	arg_6_0._childGoList = arg_6_0:getUserDataTb_()

	gohelper.addUIClickAudio(arg_6_0._btnadditionRuleclick.gameObject, AudioEnum.UI.play_ui_hero_sign)
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:addEventCb(Season123Controller.instance, Season123Event.EnemyDetailSwitchTab, arg_7_0.refreshUI, arg_7_0)
	arg_7_0:refreshUI()
end

function var_0_0.refreshUI(arg_8_0)
	local var_8_0 = Season123EnemyModel.instance:getSelectBattleId()
	local var_8_1 = DungeonConfig.instance:getBattleAdditionRule(var_8_0)

	if string.nilorempty(var_8_1) then
		gohelper.setActive(arg_8_0._goadditionRule, false)

		return
	end

	arg_8_0:_clear()
	gohelper.setActive(arg_8_0._goadditionRule, true)

	local var_8_2 = GameUtil.splitString2(var_8_1, true, "|", "#")

	for iter_8_0, iter_8_1 in ipairs(var_8_2) do
		local var_8_3 = iter_8_1[1]
		local var_8_4 = iter_8_1[2]
		local var_8_5 = lua_rule.configDict[var_8_4]

		if var_8_5 then
			arg_8_0:_addRuleItem(var_8_5, var_8_3)
			arg_8_0:_setRuleDescItem(var_8_5, var_8_3)
		end

		if iter_8_0 == #var_8_2 then
			gohelper.setActive(arg_8_0._rulesimagelineList[iter_8_0], false)
		end
	end
end

function var_0_0._addRuleItem(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = gohelper.clone(arg_9_0._goruletemp, arg_9_0._gorulelist, arg_9_1.id)

	gohelper.setActive(var_9_0, true)

	local var_9_1 = gohelper.findChildImage(var_9_0, "#image_tagicon")
	local var_9_2 = gohelper.findChildImage(var_9_0, "")

	table.insert(arg_9_0._childGoList, var_9_0)
	UISpriteSetMgr.instance:setCommonSprite(var_9_1, "wz_" .. arg_9_2)
	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(var_9_2, arg_9_1.icon)
end

function var_0_0._setRuleDescItem(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = {
		"#6680bd",
		"#d05b4c",
		"#c7b376"
	}
	local var_10_1 = gohelper.clone(arg_10_0._goruleitem, arg_10_0._goruleDescList, arg_10_1.id)

	table.insert(arg_10_0._childGoList, var_10_1)
	gohelper.setActive(var_10_1, true)

	local var_10_2 = gohelper.findChildImage(var_10_1, "icon")
	local var_10_3 = gohelper.findChild(var_10_1, "line")

	table.insert(arg_10_0._rulesimagelineList, var_10_3)

	local var_10_4 = gohelper.findChildImage(var_10_1, "tag")
	local var_10_5 = gohelper.findChildText(var_10_1, "desc")
	local var_10_6 = string.gsub(arg_10_1.desc, "%【(.-)%】", "<color=#6680bd>[%1]</color>")
	local var_10_7 = "\n" .. HeroSkillModel.instance:getEffectTagDescFromDescRecursion(arg_10_1.desc, var_10_0[1])
	local var_10_8 = luaLang("dungeon_add_rule_target_" .. arg_10_2)
	local var_10_9 = var_10_0[arg_10_2]

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(var_10_2, arg_10_1.icon)
	UISpriteSetMgr.instance:setCommonSprite(var_10_4, "wz_" .. arg_10_2)

	var_10_5.text = string.format("<color=%s>[%s]</color>%s%s", var_10_9, var_10_8, var_10_6, var_10_7)
end

function var_0_0._clear(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0._childGoList) do
		gohelper.destroy(iter_11_1)
	end

	arg_11_0._rulesimagelineList = arg_11_0:getUserDataTb_()
	arg_11_0._childGoList = arg_11_0:getUserDataTb_()
end

function var_0_0.onDestroyView(arg_12_0)
	arg_12_0:_clear()
end

return var_0_0
