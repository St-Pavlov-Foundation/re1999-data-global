module("modules.logic.fight.system.work.FightWorkEntityPlayAct", package.seeall)

local var_0_0 = class("FightWorkEntityPlayAct", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._entity = arg_1_1
	arg_1_0._actName = arg_1_2
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	arg_2_0:_playAnim()
end

function var_0_0._playAnim(arg_3_0)
	if arg_3_0._entity.spine and arg_3_0._entity.spine:hasAnimation(arg_3_0._actName) then
		TaskDispatcher.runDelay(arg_3_0._delayDone, arg_3_0, 30)
		arg_3_0._entity.spine:addAnimEventCallback(arg_3_0._onAnimEvent, arg_3_0)
		arg_3_0._entity.spine:play(arg_3_0._actName, false, true)

		arg_3_0._entity.spine.lockAct = true
	else
		arg_3_0:onDone(true)
	end
end

function var_0_0._delayDone(arg_4_0)
	arg_4_0:onDone(true)
end

function var_0_0._onAnimEvent(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_2 == SpineAnimEvent.ActionComplete then
		arg_5_0._entity.spine.lockAct = false

		arg_5_0._entity.spine:removeAnimEventCallback(arg_5_0._onAnimEvent, arg_5_0)
		arg_5_0._entity:resetAnimState()
		arg_5_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_6_0)
	if arg_6_0._entity.spine then
		arg_6_0._entity.spine.lockAct = false

		arg_6_0._entity.spine:removeAnimEventCallback(arg_6_0._onAnimEvent, arg_6_0)
	end

	TaskDispatcher.cancelTask(arg_6_0._delayDone, arg_6_0)
end

return var_0_0
