module("modules.logic.versionactivity1_6.dungeon.view.boss.VersionActivity1_6_BossRuleView", package.seeall)

local var_0_0 = class("VersionActivity1_6_BossRuleView", BaseView)

function var_0_0.onInitView(arg_1_0)
	local var_1_0 = gohelper.findChild(arg_1_0.viewGO, "Left/Rule")

	arg_1_0._goadditionRule = gohelper.findChild(var_1_0, "#scroll_ConditionIcons")
	arg_1_0._goruletemp = gohelper.findChild(var_1_0, "#scroll_ConditionIcons/#go_ruletemp")
	arg_1_0._imagetagicon = gohelper.findChildImage(arg_1_0._goruletemp, "#image_tagicon")
	arg_1_0._gorulelist = gohelper.findChild(arg_1_0._goadditionRule, "Viewport/content")
	arg_1_0._btnadditionRuleclick = gohelper.findChildButtonWithAudio(arg_1_0._goadditionRule, "#btn_additionRuleclick")
	arg_1_0._goruledesc = gohelper.findChild(var_1_0, "Tips")
	arg_1_0._goruleitem = gohelper.findChild(arg_1_0._goruledesc, "image_TipsBG/#go_Item1")
	arg_1_0._goExtraRuleitem = gohelper.findChild(arg_1_0._goruledesc, "image_TipsBG/#go_Item2")
	arg_1_0._goruleDescList = gohelper.findChild(arg_1_0._goruledesc, "bg/#go_ruleDescList")
	arg_1_0._nextBossTitle = gohelper.findChildText(arg_1_0.viewGO, "Left/Rule/Tips/image_TipsBG/#go_Item2/#txt_Descr/#txt_Title")
	arg_1_0._nextBossDay = gohelper.findChildText(arg_1_0.viewGO, "Left/Rule/Tips/image_TipsBG/#go_Item2/#txt_Descr/#txt_Title/#txt_dayNum")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnadditionRuleclick:AddClickListener(arg_2_0._btnRuleAreaOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnadditionRuleclick:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	gohelper.setActive(arg_4_0._goruleitem, false)
	gohelper.setActive(arg_4_0._goExtraRuleitem, false)
	gohelper.setActive(arg_4_0._goruletemp, false)
	gohelper.setActive(arg_4_0._goruledesc, false)
	gohelper.addUIClickAudio(arg_4_0._btnadditionRuleclick.gameObject, AudioEnum.UI.play_ui_hero_sign)

	arg_4_0._normalRuleItemList = {}
	arg_4_0._extraRuleItemList = {}
end

function var_0_0.refreshUI(arg_5_0, arg_5_1, arg_5_2)
	gohelper.setActive(arg_5_0._goruleitem, false)
	gohelper.setActive(arg_5_0._goExtraRuleitem, false)
	arg_5_0:addNormalRuleItem(arg_5_1, arg_5_2 and arg_5_2 ~= 0)

	if arg_5_2 and arg_5_2 ~= 0 then
		arg_5_0:AddExtraRuleItem(arg_5_2)
	end
end

function var_0_0.addNormalRuleItem(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = DungeonConfig.instance:getBattleAdditionRule(arg_6_1)

	if string.nilorempty(var_6_0) then
		gohelper.setActive(arg_6_0._goadditionRule, false)

		return
	end

	arg_6_0:_clear()
	gohelper.setActive(arg_6_0._goadditionRule, true)
	gohelper.setActive(arg_6_0._goruleitem, true)

	local var_6_1 = GameUtil.splitString2(var_6_0, true, "|", "#")

	arg_6_0._ruleList = var_6_1

	for iter_6_0, iter_6_1 in ipairs(var_6_1) do
		local var_6_2 = iter_6_1[1]
		local var_6_3 = iter_6_1[2]

		if lua_rule.configDict[var_6_3] then
			local var_6_4 = arg_6_0:_addRuleItem(iter_6_1, false, arg_6_2)

			var_6_4.battleId = arg_6_1
			arg_6_0._normalRuleItemList[#arg_6_0._normalRuleItemList + 1] = var_6_4
		end
	end
end

function var_0_0.AddExtraRuleItem(arg_7_0, arg_7_1)
	local var_7_0 = DungeonConfig.instance:getBattleAdditionRule(arg_7_1)
	local var_7_1 = VersionActivity1_6DungeonBossModel.instance

	if not var_7_0 then
		return
	end

	local var_7_2 = GameUtil.splitString2(var_7_0, true, "|", "#")

	for iter_7_0, iter_7_1 in ipairs(var_7_2) do
		local var_7_3 = iter_7_1[1]
		local var_7_4 = iter_7_1[2]

		if lua_rule.configDict[var_7_4] then
			local var_7_5 = arg_7_0:_addRuleItem(iter_7_1, true)

			var_7_5.battleId = arg_7_1
			arg_7_0._extraRuleItemList[#arg_7_0._extraRuleItemList + 1] = var_7_5

			table.insert(arg_7_0._ruleList, iter_7_1)

			local var_7_6 = var_7_1:getCurBossEpisodeRemainDay()

			arg_7_0._nextBossTitle.text = string.format(luaLang("p_v1a6_activityboss_help_3_txt_3"), var_7_6)
			arg_7_0._nextBossDay.text = ""
		end
	end
end

function var_0_0._addRuleItem(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = arg_8_0:getUserDataTb_()

	var_8_0.targetId = arg_8_1[1]
	var_8_0.ruleId = arg_8_1[2]
	var_8_0.ruleCfg = lua_rule.configDict[var_8_0.ruleId]

	local var_8_1 = gohelper.clone(arg_8_0._goruletemp, arg_8_0._gorulelist, var_8_0.ruleCfg.id)

	var_8_0.go = var_8_1

	gohelper.setActive(var_8_1, true)

	local var_8_2 = gohelper.onceAddComponent(var_8_1, typeof(UnityEngine.CanvasGroup))

	if var_8_2 then
		var_8_2.alpha = arg_8_2 and 0.5 or 1
	end

	local var_8_3 = arg_8_3 and 1.3 or 1

	transformhelper.setLocalScale(var_8_1.transform, var_8_3, var_8_3, 1)

	local var_8_4 = gohelper.findChildImage(var_8_1, "#image_tagicon")

	UISpriteSetMgr.instance:setCommonSprite(var_8_4, "wz_" .. var_8_0.targetId)

	local var_8_5 = gohelper.findChildImage(var_8_1, "")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(var_8_5, var_8_0.ruleCfg.icon)

	var_8_4.maskable = true
	var_8_5.maskable = true

	return var_8_0
end

function var_0_0._btnRuleAreaOnClick(arg_9_0)
	ViewMgr.instance:openView(ViewName.HeroGroupFightRuleDescView, {
		ruleList = arg_9_0._ruleList
	})
end

function var_0_0._clear(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0._normalRuleItemList) do
		gohelper.destroy(iter_10_1.go)
	end

	for iter_10_2, iter_10_3 in ipairs(arg_10_0._extraRuleItemList) do
		gohelper.destroy(iter_10_3.go)
	end

	arg_10_0._normalRuleItemList = {}
	arg_10_0._extraRuleItemList = {}
end

function var_0_0.onDestroyView(arg_11_0)
	arg_11_0:_clear()
end

return var_0_0
