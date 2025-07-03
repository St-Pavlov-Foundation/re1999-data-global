module("modules.logic.versionactivity2_7.lengzhou6.model.skill.PlayerActiveSkill", package.seeall)

local var_0_0 = class("PlayerActiveSkill", SkillBase)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.init(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._skillParams = {}
	arg_1_0._skillParamCount = 0

	if arg_1_0._effect[1] == "EliminationCross" or arg_1_0._effect[1] == "EliminationRange" then
		arg_1_0._skillParamCount = 2
	end

	arg_1_0._skillType = LengZhou6Enum.SkillType.active
end

function var_0_0.setParams(arg_2_0, arg_2_1, arg_2_2)
	table.insert(arg_2_0._skillParams, arg_2_1)
	table.insert(arg_2_0._skillParams, arg_2_2)
end

function var_0_0.clearParams(arg_3_0)
	tabletool.clear(arg_3_0._skillParams)
end

function var_0_0.paramIsFull(arg_4_0)
	return #arg_4_0._skillParams == arg_4_0._skillParamCount
end

function var_0_0.execute(arg_5_0)
	if var_0_0.super.execute(arg_5_0) and arg_5_0:paramIsFull() then
		local var_5_0 = arg_5_0._effect[1]
		local var_5_1 = LengZhou6EffectUtils.instance:getHandleFunc(var_5_0)

		if var_5_1 ~= nil then
			if #arg_5_0._skillParams ~= 0 then
				var_5_1(arg_5_0._skillParams[1], arg_5_0._skillParams[2])
			else
				var_5_1(arg_5_0._effect)
			end

			arg_5_0:clearParams()
			LengZhou6EliminateController.instance:dispatchEvent(LengZhou6Event.UpdatePlayerSkill)
			LengZhou6EliminateController.instance:dispatchEvent(LengZhou6Event.FinishReleaseSkill)
			LengZhou6StatHelper.instance:addUseSkillInfo(arg_5_0:getConfigId())
		end
	end
end

return var_0_0
