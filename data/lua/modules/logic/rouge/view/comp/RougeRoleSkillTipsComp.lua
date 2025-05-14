module("modules.logic.rouge.view.comp.RougeRoleSkillTipsComp", package.seeall)

local var_0_0 = class("RougeRoleSkillTipsComp", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._skillicon1 = arg_1_0:_addSkillItem(gohelper.findChild(arg_1_0._go, "skillicon1"), arg_1_0._onSkill1Click, arg_1_0)
	arg_1_0._skillicon2 = arg_1_0:_addSkillItem(gohelper.findChild(arg_1_0._go, "skillicon2"), arg_1_0._onSkill2Click, arg_1_0)
	arg_1_0._click = gohelper.findChildButtonWithAudio(arg_1_0._go, "block")

	arg_1_0._click:AddClickListener(arg_1_0._onClick, arg_1_0)
end

function var_0_0.setClickCallback(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._callback = arg_2_1
	arg_2_0._target = arg_2_2
end

function var_0_0._onClick(arg_3_0)
	if arg_3_0._callback then
		arg_3_0._callback(arg_3_0._target)
	end
end

function var_0_0._onSkill1Click(arg_4_0)
	arg_4_0._displaySkillItemComp:refresh(arg_4_0._skillicon1:getSkillCO())
	arg_4_0:_setSkillIconSelected(true)
	RougeHeroGroupModel.instance:rougeSaveCurGroup()
end

function var_0_0._onSkill2Click(arg_5_0)
	arg_5_0._displaySkillItemComp:refresh(arg_5_0._skillicon2:getSkillCO())
	arg_5_0:_setSkillIconSelected(false)
	RougeHeroGroupModel.instance:rougeSaveCurGroup()
end

function var_0_0._setSkillIconSelected(arg_6_0, arg_6_1)
	arg_6_0._skillicon1:setSelected(arg_6_1)
	arg_6_0._skillicon2:setSelected(not arg_6_1)
end

function var_0_0._addSkillItem(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = MonoHelper.addNoUpdateLuaComOnceToGo(arg_7_1, RougeRoleSkillItemComp)

	var_7_0:setClickCallback(arg_7_2, arg_7_3)

	return var_7_0
end

function var_0_0.refresh(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0._displaySkillItemComp = arg_8_2

	local var_8_0 = arg_8_2:getSkillCO()

	for iter_8_0, iter_8_1 in pairs(arg_8_1) do
		local var_8_1 = lua_skill.configDict[iter_8_1]

		if var_8_1 then
			local var_8_2 = arg_8_0["_skillicon" .. iter_8_0]

			if var_8_2 then
				var_8_2:refresh(var_8_1)
				var_8_2:setSelected(var_8_0 == var_8_1)
			else
				break
			end
		end
	end
end

function var_0_0.onDestroy(arg_9_0)
	arg_9_0._click:RemoveClickListener()
end

return var_0_0
