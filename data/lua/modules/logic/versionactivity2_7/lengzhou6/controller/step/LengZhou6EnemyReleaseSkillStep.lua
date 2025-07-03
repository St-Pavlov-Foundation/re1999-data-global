module("modules.logic.versionactivity2_7.lengzhou6.controller.step.LengZhou6EnemyReleaseSkillStep", package.seeall)

local var_0_0 = class("LengZhou6EnemyReleaseSkillStep", EliminateChessStepBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0._data
	local var_1_1 = LengZhou6GameModel.instance:getEnemy()

	if var_1_1 == nil or var_1_0 == nil then
		arg_1_0:onDone(true)

		return
	end

	local var_1_2 = var_1_0._id
	local var_1_3 = var_1_0:getEffect()[1]
	local var_1_4 = var_1_0:getConfigId()

	LengZhou6EliminateController.instance:dispatchEvent(LengZhou6Event.UseEnemySkill, var_1_2)
	var_1_1:useSkill(var_1_2)
	LengZhou6Controller.instance:dispatchEvent(LengZhou6Event.EnemyUseSkill, var_1_4)

	if var_1_3 == LengZhou6Enum.SkillEffect.DealsDamage or var_1_3 == LengZhou6Enum.SkillEffect.Heal then
		LengZhou6EliminateController.instance:dispatchEvent(LengZhou6Event.ShowEnemyEffect, var_1_3)
		TaskDispatcher.runDelay(arg_1_0._onDone, arg_1_0, LengZhou6Enum.EnemySkillTime)

		return
	else
		TaskDispatcher.runDelay(arg_1_0._onDone, arg_1_0, LengZhou6Enum.EnemySkillTime_2)
	end
end

return var_0_0
