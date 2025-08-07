module("modules.logic.sp01.assassin2.controller.stealthgameflow.StealthEnemyMoveWork", package.seeall)

local var_0_0 = class("StealthEnemyMoveWork", BaseWork)

function var_0_0.ctor(arg_1_0)
	arg_1_0.maxStep = 0
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	arg_2_0.curStep = 0

	local var_2_0 = AssassinStealthGameModel.instance:getEnemyOperationData()

	arg_2_0.moveDataList = var_2_0 and var_2_0.moves or {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.moveDataList) do
		arg_2_0.maxStep = math.max(arg_2_0.maxStep, #iter_2_1.path)
	end

	arg_2_0:_nextMove()
end

local var_0_1 = 1

function var_0_0._nextMove(arg_3_0)
	if arg_3_0.curStep >= arg_3_0.maxStep then
		local var_3_0 = AssassinStealthGameModel.instance:getEnemyOperationData()
		local var_3_1 = var_3_0 and var_3_0.monster

		AssassinStealthGameController.instance:updateEnemies(var_3_1)
		arg_3_0:onDone(true)
	else
		arg_3_0.curStep = arg_3_0.curStep + 1

		for iter_3_0, iter_3_1 in ipairs(arg_3_0.moveDataList) do
			arg_3_0.maxStep = math.max(arg_3_0.maxStep, #iter_3_1.path)

			local var_3_2 = iter_3_1.path[arg_3_0.curStep]

			if var_3_2 then
				AssassinStealthGameController.instance:enemyMove(iter_3_1.uid, var_3_2.gridId, var_3_2.pos)
			end
		end

		TaskDispatcher.cancelTask(arg_3_0._nextMove, arg_3_0)
		TaskDispatcher.runDelay(arg_3_0._nextMove, arg_3_0, var_0_1)
	end
end

function var_0_0.clearWork(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._nextMove, arg_4_0)
end

return var_0_0
