module("modules.logic.fight.view.preview.SkillEditorAutoPlaySkillItem", package.seeall)

local var_0_0 = class("SkillEditorAutoPlaySkillItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._text = gohelper.findChildText(arg_1_1, "Text")
	arg_1_0._text1 = gohelper.findChildText(arg_1_1, "imgSelect/Text")
	arg_1_0._click = SLFramework.UGUI.UIClickListener.Get(arg_1_1)
	arg_1_0._selectGO = gohelper.findChild(arg_1_1, "imgSelect")

	gohelper.setActive(arg_1_1, true)
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._click:AddClickListener(arg_2_0._onClickThis, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._click:RemoveClickListener()
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	arg_4_0._mo = arg_4_1

	local var_4_0 = arg_4_1.co

	if arg_4_1.type == SkillEditorMgr.SelectType.Hero or SkillEditorHeroSelectModel.instance.selectType == SkillEditorMgr.SelectType.SubHero then
		arg_4_0._text.text = var_4_0.skinId .. (var_4_0.name and "\n" .. var_4_0.name or "")
		arg_4_0._text1.text = var_4_0.skinId .. (var_4_0.name and "\n" .. var_4_0.name or "")
	elseif arg_4_1.type == SkillEditorMgr.SelectType.Monster then
		local var_4_1 = FightConfig.instance:getSkinCO(var_4_0.skinId)
		local var_4_2 = var_4_1 and var_4_1.name or nil

		if not var_4_1 then
			logError("皮肤表找不到id,怪物模型id：", var_4_0.skinId)
		end

		arg_4_0._text.text = var_4_0.skinId .. (var_4_2 and "\n" .. var_4_2 or "")
		arg_4_0._text1.text = var_4_0.skinId .. (var_4_2 and "\n" .. var_4_2 or "")
	elseif arg_4_1.type == SkillEditorMgr.SelectType.Group then
		local var_4_3 = string.splitToNumber(var_4_0.monster, "#")
		local var_4_4 = lua_monster.configDict[var_4_3[1]]

		for iter_4_0 = 2, #var_4_3 do
			if tabletool.indexOf(string.splitToNumber(var_4_0.bossId, "#"), var_4_3[iter_4_0]) then
				var_4_4 = lua_monster.configDict[var_4_3[iter_4_0]]

				break
			end
		end

		arg_4_0._text.text = var_4_0.id .. (var_4_4 and var_4_4.name and "\n" .. var_4_4.name or "")
		arg_4_0._text1.text = var_4_0.id .. (var_4_4 and var_4_4.name and "\n" .. var_4_4.name or "")
	else
		arg_4_0._text.text = var_4_0.id .. (var_4_0.name and "\n" .. var_4_0.name or "")
		arg_4_0._text1.text = var_4_0.id .. (var_4_0.name and "\n" .. var_4_0.name or "")
	end
end

function var_0_0.onSelect(arg_5_0, arg_5_1)
	gohelper.setActive(arg_5_0._selectGO, arg_5_1)
end

function var_0_0._onClickThis(arg_6_0)
	arg_6_0._view:selectCell(arg_6_0._mo.id, true)
	SkillEditorToolAutoPlaySkillSelectModel.instance:addAtLast(arg_6_0._mo)
end

return var_0_0
