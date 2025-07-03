module("modules.logic.versionactivity2_7.lengzhou6.controller.step.EliminateChessUpdateDamageStep", package.seeall)

local var_0_0 = class("EliminateChessUpdateDamageStep", EliminateChessStepBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0._data.damage
	local var_1_1 = arg_1_0._data.hp

	arg_1_0._isRound = arg_1_0._data.isRound

	LengZhou6GameModel.instance:getEnemy():changeHp(-var_1_0)
	LengZhou6GameModel.instance:getPlayer():changeHp(var_1_1)
	LengZhou6EliminateController.instance:dispatchEvent(LengZhou6Event.UpdateEliminateDamage)

	local var_1_2 = LengZhou6EliminateController.instance:dispatchShowAssess()

	LengZhou6EliminateController.instance:resetCurEliminateCount()

	local var_1_3 = 0

	if var_1_2 ~= nil then
		var_1_3 = math.max(var_1_3, EliminateEnum_2_7.AssessShowTime)
	end

	local var_1_4, var_1_5 = LengZhou6GameModel.instance:getTotalPlayerSettle()

	if var_1_4 > 0 then
		var_1_3 = math.max(var_1_3, EliminateEnum_2_7.UpdateDamageStepTime)
	end

	if var_1_3 == 0 then
		arg_1_0:_onDone()
	else
		TaskDispatcher.runDelay(arg_1_0._onDone, arg_1_0, var_1_3)
	end
end

function var_0_0._onDone(arg_2_0)
	LengZhou6GameController.instance:_updateRoundAndCD(arg_2_0._isRound)
	var_0_0.super._onDone(arg_2_0)
end

return var_0_0
