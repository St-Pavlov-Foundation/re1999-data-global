module("modules.logic.fight.view.work.FightAutoPlayCardWork", package.seeall)

local var_0_0 = class("FightAutoPlayCardWork", FightWorkItem)

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	arg_1_0.SAFETIME = 10
	arg_1_0._beginRoundOp = arg_1_1
end

function var_0_0.onStart(arg_2_0)
	if not arg_2_0._beginRoundOp then
		arg_2_0:onDone(true)

		return
	end

	FightController.instance:dispatchEvent(FightEvent.AutoToSelectSkillTarget, arg_2_0._beginRoundOp.toId)

	local var_2_0 = arg_2_0._beginRoundOp.param1
	local var_2_1 = arg_2_0._beginRoundOp.toId
	local var_2_2 = arg_2_0._beginRoundOp.param2
	local var_2_3 = arg_2_0._beginRoundOp.param3
	local var_2_4 = FightMsgMgr.sendMsg(FightMsgId.RegistPlayHandCardWork, var_2_0, var_2_1, var_2_2, var_2_3)

	arg_2_0:playWorkAndDone(var_2_4)
end

return var_0_0
