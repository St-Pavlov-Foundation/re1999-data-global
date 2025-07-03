module("modules.logic.versionactivity2_7.lengzhou6.model.skill.EnemyGeneralSkill", package.seeall)

local var_0_0 = class("EnemyGeneralSkill", SkillBase)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.init(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._skillType = LengZhou6Enum.SkillType.enemyActive
end

function var_0_0.execute(arg_2_0)
	if var_0_0.super.execute(arg_2_0) then
		local var_2_0 = arg_2_0._effect[1]
		local var_2_1 = LengZhou6EffectUtils.instance:getHandleFunc(var_2_0)

		if var_2_1 ~= nil then
			local var_2_2 = LengZhou6GameModel.instance:getSkillEffectUp(arg_2_0._effect[1])

			var_2_1(arg_2_0._effect, var_2_2)
		end
	end
end

function var_0_0.getSkillDesc(arg_3_0)
	local var_3_0 = arg_3_0:getConfig().desc

	if arg_3_0._effect[1] == LengZhou6Enum.SkillEffect.Shuffle then
		return var_3_0
	end

	return GameUtil.getSubPlaceholderLuaLangOneParam(var_3_0, arg_3_0:getTotalValue())
end

function var_0_0.getTotalValue(arg_4_0)
	if arg_4_0._totalValue == nil then
		arg_4_0._totalValue = arg_4_0:_getTotalValue()
	end

	return arg_4_0._totalValue
end

function var_0_0._getTotalValue(arg_5_0)
	local var_5_0 = arg_5_0._effect[1]

	return (arg_5_0._effect[2] and tonumber(arg_5_0._effect[2]) or 0) + LengZhou6GameModel.instance:getSkillEffectUp(var_5_0)
end

return var_0_0
