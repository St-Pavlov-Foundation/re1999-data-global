module("modules.logic.fight.view.cardeffect.FightEnemyPlayCardOpInEffect", package.seeall)

local var_0_0 = class("FightEnemyPlayCardOpInEffect", BaseWork)
local var_0_1 = 1
local var_0_2 = var_0_1 * 0.033

function var_0_0.onStart(arg_1_0, arg_1_1)
	arg_1_0._dt = var_0_2 / FightModel.instance:getUISpeed()

	var_0_0.super.onStart(arg_1_0, arg_1_1)

	local var_1_0 = FightDataHelper.roundMgr:getRoundData()

	if not var_1_0 then
		arg_1_0:onDone(true)

		return
	end

	arg_1_0._flow = FlowSequence.New()

	local var_1_1 = FlowParallel.New()

	arg_1_0._flow:addWork(var_1_1)

	local var_1_2 = var_1_0:getAIUseCardMOList()

	for iter_1_0, iter_1_1 in ipairs(var_1_2) do
		local var_1_3 = FightHelper.getEntity(iter_1_1.uid)
		local var_1_4 = var_1_3 and var_1_3.nameUI
		local var_1_5 = var_1_4 and var_1_4:getOpCtrl():getSkillOpGO(iter_1_1)
		local var_1_6 = FlowSequence.New()

		var_1_6:addWork(WorkWaitSeconds.New((#var_1_2 - iter_1_0 + 1) * arg_1_0._dt * 4))
		var_1_6:addWork(FunctionWork.New(function()
			gohelper.setActive(var_1_5, true)

			if var_1_4 and not gohelper.isNil(var_1_5) then
				var_1_4:getOpCtrl():checkLockFirst()
				var_1_4:getOpCtrl():onFlyEnd(MonoHelper.getLuaComFromGo(var_1_5, FightOpItem))
			end
		end))
		var_1_1:addWork(var_1_6)
	end

	arg_1_0._flow:registerDoneListener(arg_1_0._onDone, arg_1_0)
	arg_1_0._flow:start()
	TaskDispatcher.runDelay(arg_1_0._delayDone, arg_1_0, 3 / FightModel.instance:getUISpeed())
end

function var_0_0.clearWork(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._delayDone, arg_3_0)

	if arg_3_0._flow then
		arg_3_0._flow:destroy()

		arg_3_0._flow = nil
	end
end

function var_0_0._onDone(arg_4_0)
	arg_4_0:onDone(true)
end

function var_0_0._delayDone(arg_5_0)
	arg_5_0:onDone(true)
end

return var_0_0
