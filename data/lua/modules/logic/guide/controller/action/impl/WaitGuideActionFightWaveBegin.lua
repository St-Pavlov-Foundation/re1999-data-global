module("modules.logic.guide.controller.action.impl.WaitGuideActionFightWaveBegin", package.seeall)

local var_0_0 = class("WaitGuideActionFightWaveBegin", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)
	FightController.instance:registerCallback(FightEvent.OnBeginWave, arg_1_0._onBeginWave, arg_1_0)

	arg_1_0._groundId = tonumber(arg_1_0.actionParam)
end

function var_0_0._onBeginWave(arg_2_0)
	if arg_2_0._groundId and FightModel.instance:getCurMonsterGroupId() ~= arg_2_0._groundId then
		return
	end

	FightController.instance:unregisterCallback(FightEvent.OnBeginWave, arg_2_0._onBeginWave, arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.OnBeginWave, arg_3_0._onBeginWave, arg_3_0)
end

return var_0_0
