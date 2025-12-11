module("modules.logic.fight.fightcomponent.FightMsgComponent", package.seeall)

local var_0_0 = class("FightMsgComponent", FightBaseClass)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.msgList = {}
	arg_1_0.count = 0
end

function var_0_0.registMsg(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = FightMsgMgr.registMsg(arg_2_1, arg_2_2, arg_2_3)

	arg_2_0.count = arg_2_0.count + 1
	arg_2_0.msgList[arg_2_0.count] = var_2_0

	return var_2_0
end

function var_0_0.removeMsg(arg_3_0, arg_3_1)
	FightMsgMgr.removeMsg(arg_3_1)
end

function var_0_0.sendMsg(arg_4_0, arg_4_1, ...)
	return FightMsgMgr.sendMsg(arg_4_1, ...)
end

function var_0_0.replyMsg(arg_5_0, arg_5_1, arg_5_2)
	FightMsgMgr.replyMsg(arg_5_1, arg_5_2)
end

function var_0_0.onDestructor(arg_6_0)
	local var_6_0 = arg_6_0.msgList

	for iter_6_0 = arg_6_0.count, 1, -1 do
		FightMsgMgr.removeMsg(var_6_0[iter_6_0])
	end
end

return var_0_0
