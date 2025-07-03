module("modules.logic.versionactivity2_7.lengzhou6.model.skill.GeneralSkill", package.seeall)

local var_0_0 = class("GeneralSkill", SkillBase)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.init(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._skillType = LengZhou6Enum.SkillType.passive
end

function var_0_0.execute(arg_2_0)
	if var_0_0.super.execute(arg_2_0) and arg_2_0._triggerPoint == LengZhou6GameModel.instance:getCurGameStep() then
		local var_2_0 = arg_2_0._effect[1]
		local var_2_1 = LengZhou6EffectUtils.instance:getHandleFunc(var_2_0)

		if var_2_1 ~= nil then
			var_2_1(arg_2_0._effect)
		end
	end
end

return var_0_0
