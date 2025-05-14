module("modules.logic.seasonver.act123.view2_3.Season123_2_3FightRuleView", package.seeall)

local var_0_0 = class("Season123_2_3FightRuleView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._content = gohelper.findChild(arg_1_0.viewGO, "mask/Scroll View/Viewport/Content")
	arg_1_0._simagedecorate = gohelper.findChildSingleImage(arg_1_0.viewGO, "mask/#simage_decorate")
	arg_1_0._goItem = gohelper.findChild(arg_1_0._content, "#go_ruleitem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	gohelper.setActive(arg_4_0._goItem, false)
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0:refreshRule()
end

function var_0_0.refreshRule(arg_6_0)
	local var_6_0 = var_0_0.getRuleList() or {}

	if not arg_6_0.itemList then
		arg_6_0.itemList = arg_6_0:getUserDataTb_()
	end

	for iter_6_0 = 1, math.max(#arg_6_0.itemList, #var_6_0) do
		local var_6_1 = var_6_0[iter_6_0]
		local var_6_2 = arg_6_0.itemList[iter_6_0] or arg_6_0:createItem(iter_6_0)

		arg_6_0:updateItem(var_6_2, var_6_1)
	end

	arg_6_0:setDecorateVisible(#var_6_0 <= 1)
end

function var_0_0.createItem(arg_7_0, arg_7_1)
	local var_7_0 = {}
	local var_7_1 = gohelper.clone(arg_7_0._goItem, arg_7_0._content, string.format("item%s", arg_7_1))

	var_7_0.go = var_7_1
	var_7_0.txtEffectDesc = gohelper.findChildTextMesh(var_7_1, "txt_effectdesc")
	var_7_0.imgTag = gohelper.findChildImage(var_7_1, "rulecontain/image_tag")
	var_7_0.imgIcon = gohelper.findChildImage(var_7_1, "rulecontain/image_icon")
	arg_7_0.itemList[arg_7_1] = var_7_0

	return var_7_0
end

function var_0_0.updateItem(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_2 or string.nilorempty(arg_8_2[2]) then
		gohelper.setActive(arg_8_1.go, false)

		return
	end

	gohelper.setActive(arg_8_1.go, true)

	local var_8_0 = lua_rule.configDict[arg_8_2[2]]
	local var_8_1 = arg_8_2[1]
	local var_8_2 = {
		"#6680bd",
		"#d05b4c",
		"#c7b376"
	}
	local var_8_3 = string.gsub(var_8_0.desc, "%【(.-)%】", "<color=#6680bd>[%1]</color>")
	local var_8_4 = "\n" .. HeroSkillModel.instance:getEffectTagDescFromDescRecursion(var_8_0.desc, var_8_2[1])
	local var_8_5 = luaLang("dungeon_add_rule_target_" .. var_8_1)
	local var_8_6 = var_8_2[var_8_1]

	arg_8_1.txtEffectDesc.text = string.format("<color=%s>[%s]</color>%s%s", var_8_6, var_8_5, var_8_3, var_8_4)

	UISpriteSetMgr.instance:setCommonSprite(arg_8_1.imgTag, "wz_" .. arg_8_2[1])
	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(arg_8_1.imgIcon, var_8_0.icon)
end

function var_0_0.destroyItem(arg_9_0, arg_9_1)
	return
end

function var_0_0.getRuleList()
	local var_10_0 = FightModel.instance:getFightParam()

	if not var_10_0 then
		return
	end

	local var_10_1 = lua_battle.configDict[var_10_0.battleId]

	if not var_10_1 then
		return
	end

	local var_10_2 = var_10_1.additionRule
	local var_10_3 = GameUtil.splitString2(var_10_2, true, "|", "#")
	local var_10_4 = Season123Model.instance:getBattleContext()

	if var_10_4 then
		var_10_3 = Season123HeroGroupModel.filterRule(var_10_4.actId, var_10_3)

		if var_10_4.stage then
			var_10_3 = Season123Config.instance:filterRule(var_10_3, var_10_4.stage)
		end
	end

	return var_10_3
end

function var_0_0.setDecorateVisible(arg_11_0, arg_11_1)
	gohelper.setActive(arg_11_0._simagedecorate.gameObject, arg_11_1)

	if arg_11_1 then
		arg_11_0._simagedecorate:LoadImage(ResUrl.getSeasonIcon("img_zs2.png"))
	end
end

function var_0_0.onClose(arg_12_0)
	return
end

function var_0_0.onDestroyView(arg_13_0)
	if arg_13_0.itemList then
		for iter_13_0, iter_13_1 in pairs(arg_13_0.itemList) do
			arg_13_0:destroyItem(iter_13_1)
		end

		arg_13_0.itemList = nil
	end
end

return var_0_0
