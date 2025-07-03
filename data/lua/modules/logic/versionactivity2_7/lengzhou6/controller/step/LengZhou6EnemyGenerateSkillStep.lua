module("modules.logic.versionactivity2_7.lengzhou6.controller.step.LengZhou6EnemyGenerateSkillStep", package.seeall)

local var_0_0 = class("LengZhou6EnemyGenerateSkillStep", EliminateChessStepBase)

function var_0_0.onStart(arg_1_0)
	LengZhou6EliminateController.instance:dispatchEvent(LengZhou6Event.UpdateEnemySkill)

	local var_1_0 = LengZhou6GameModel.instance:getEnemy():getAction():calCurResidueCd()
	local var_1_1 = 0

	if LengZhou6GameModel.instance:getEnemy():havePoisonBuff() then
		var_1_1 = LengZhou6Enum.EnemyBuffEffectShowTime
	end

	LengZhou6GameModel.instance:setCurGameStep(LengZhou6Enum.BattleStep.poisonSettlement)
	LengZhou6GameController.instance:dispatchEvent(LengZhou6Event.EnemySkillRound, var_1_0)

	if var_1_1 ~= 0 then
		TaskDispatcher.runDelay(arg_1_0._onDone, arg_1_0, var_1_1)
	else
		arg_1_0:onDone(true)
	end
end

return var_0_0
