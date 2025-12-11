module("modules.logic.fight.system.work.FightWorkPlayHandCard", package.seeall)

local var_0_0 = class("FightWorkPlayHandCard", FightWorkItem)
local var_0_1 = 0

var_0_0.playing = 0

function var_0_0.onConstructor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	var_0_1 = var_0_1 + 1
	var_0_0.playing = var_0_1
	arg_1_0.index = arg_1_1
	arg_1_0.toId = arg_1_2
	arg_1_0.discardIndex = arg_1_3
	arg_1_0.selectedSkillId = arg_1_4
end

function var_0_0.onStart(arg_2_0)
	local var_2_0 = arg_2_0:com_registFlowSequence()
	local var_2_1 = FightMsgMgr.sendMsg(FightMsgId.RegistPlayHandCardWork, arg_2_0.index, arg_2_0.toId, arg_2_0.discardIndex, arg_2_0.selectedSkillId)

	var_2_0:addWork(var_2_1)
	arg_2_0:playWorkAndDone(var_2_0)
end

function var_0_0.onDestructor(arg_3_0)
	var_0_1 = var_0_1 - 1
	var_0_0.playing = var_0_1
end

return var_0_0
