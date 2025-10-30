module("modules.logic.herogroup.view.HeroGroupFightRuleDescView", package.seeall)

local var_0_0 = class("HeroGroupFightRuleDescView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btncloserule = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_closerule")
	arg_1_0._gorule = gohelper.findChild(arg_1_0.viewGO, "#go_rule")
	arg_1_0._goruleDescList = gohelper.findChild(arg_1_0.viewGO, "#go_rule/#scroll_rule/Viewport/#go_ruleDescList")
	arg_1_0._goruleitem = gohelper.findChild(arg_1_0.viewGO, "#go_rule/#scroll_rule/Viewport/#go_ruleDescList/#go_ruleitem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncloserule:AddClickListener(arg_2_0._btncloseruleOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncloserule:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._rulesimagelineList = arg_4_0:getUserDataTb_()
	arg_4_0._cloneRuleGos = arg_4_0:getUserDataTb_()

	gohelper.setActive(arg_4_0._goruleitem, false)
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0:_refreshUI()
end

function var_0_0._btncloseruleOnClick(arg_6_0)
	arg_6_0:closeThis()

	if arg_6_0._isHardMode then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.HardModeHideRuleDesc)
	end
end

function var_0_0._refreshUI(arg_7_0)
	local var_7_0 = arg_7_0.viewParam.ruleList

	if arg_7_0.viewParam.offSet then
		recthelper.setAnchor(arg_7_0._gorule.transform, arg_7_0.viewParam.offSet[1], arg_7_0.viewParam.offSet[2])
	end

	if arg_7_0.viewParam.pivot then
		arg_7_0._gorule.transform.pivot = arg_7_0.viewParam.pivot
	end

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		local var_7_1 = iter_7_1[1]
		local var_7_2 = iter_7_1[2]
		local var_7_3 = lua_rule.configDict[var_7_2]

		if var_7_3 then
			arg_7_0:_setRuleDescItem(var_7_3, var_7_1)
		end

		if iter_7_0 == #var_7_0 then
			gohelper.setActive(arg_7_0._rulesimagelineList[iter_7_0], false)
		end
	end
end

function var_0_0._setRuleDescItem(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = {
		"#6680bd",
		"#d05b4c",
		"#c7b376"
	}
	local var_8_1 = gohelper.clone(arg_8_0._goruleitem, arg_8_0._goruleDescList, arg_8_1.id)

	gohelper.setActive(var_8_1, true)
	table.insert(arg_8_0._cloneRuleGos, var_8_1)

	local var_8_2 = gohelper.findChildImage(var_8_1, "icon")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(var_8_2, arg_8_1.icon)

	local var_8_3 = gohelper.findChild(var_8_1, "line")

	table.insert(arg_8_0._rulesimagelineList, var_8_3)

	local var_8_4 = gohelper.findChildImage(var_8_1, "tag")

	UISpriteSetMgr.instance:setCommonSprite(var_8_4, "wz_" .. arg_8_2)

	local var_8_5 = gohelper.findChildText(var_8_1, "desc")

	SkillHelper.addHyperLinkClick(var_8_5)

	local var_8_6 = arg_8_1.desc
	local var_8_7 = SkillHelper.buildDesc(var_8_6, nil, "#6680bd")
	local var_8_8 = luaLang("dungeon_add_rule_target_" .. arg_8_2)
	local var_8_9 = var_8_0[arg_8_2]

	var_8_5.text = formatLuaLang("fight_rule_desc", var_8_9, var_8_8, var_8_7)
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0
